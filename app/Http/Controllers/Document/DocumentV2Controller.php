<?php

namespace App\Http\Controllers\Document;

use App\Http\Controllers\Controller;
use App\Jobs\SendEmailJob;
use App\Mail\MailNotif;
use Illuminate\Http\Request;

use DataTables, Auth, DB;
use Validator,Redirect,Response;
use Mail;
use PDF;

class DocumentV2Controller extends Controller
{
    public function index(){
        $doctypes  = DB::table('doctypes')->where('doctype', 'Work Instruction')->get();
        $doclevels = DB::table('doclevels')->get();
        $docareas  = DB::table('docareas')->get();
        $ipdapi    = DB::table('general_setting')->where('setting_name', 'IPD_MODEL_API')->first();
        return view('transaction.document.v2.index', ['doctypes' => $doctypes, 'doclevels' => $doclevels, 'docareas' => $docareas, 'ipdapi' => $ipdapi]);
    }

    public function save(Request $req){
        // return $req;
        // return generateDcnNumber();
        // return public_path();
        DB::beginTransaction();
        try{
            $this->validate($req, [

                'docfiles'   => 'required',
                // 'filename.*' => 'mimes:doc,pdf,docx,zip'

            ]);

            $files = $req['docfiles'];
            
            $dcnNumber = generateDcnNumber('WI');
            $wfgroup   = getWfGroup($req['doctype']);

            $docHistory = array();
            $insertFiles = array();

            $docID = DB::table('documents')->insertGetId([
                'dcn_number'      => $dcnNumber,
                'document_type'   => $req['doctype'],
                'document_level'  => $req['doclevel'],
                'document_number' => $req['docnumber'],
                'document_title'  => $req['doctitle'],
                'description'     => $req['docremark'],
                'workflow_group'  => $wfgroup,
                // 'effectivity_date'=> $req['effectivedate'],
                'created_at'      => getLocalDatabaseDateTime(),
                'createdby'       => Auth::user()->username ?? Auth::user()->email
            ]);

            DB::table('document_versions')->insert([
                'dcn_number'  => $dcnNumber,
                'doc_version' => 1,
                'remark'      => null,
                'established_date' => $req['estabdate'],
                'validity_date'    => $req['validitydate'],
                'createdon'        => getLocalDatabaseDateTime(),
                'createdby'        => Auth::user()->username ?? Auth::user()->email
            ]);
            // document_historys
            
            $insertHistory = array(
                'dcn_number'        => $dcnNumber,
                'doc_version'       => 1,
                'activity'          => 'Document Created : ' . $req['doctitle'],
                'createdby'         => Auth::user()->username ?? Auth::user()->email,
                'createdon'         => getLocalDatabaseDateTime(),
                'updatedon'         => getLocalDatabaseDateTime()
            );
            array_push($docHistory, $insertHistory);

            foreach ($files as $efile) {
                $filename = $dcnNumber.'-'.$efile->getClientOriginalName();
                $upfiles = array(
                    'dcn_number' => $dcnNumber,
                    'doc_version'=> 1,
                    'efile'      => $filename,
                    'pathfile'   => 'storage/files/'. $filename,
                    'created_at' => getLocalDatabaseDateTime(),
                    'createdby'  => Auth::user()->username ?? Auth::user()->email
                );
                array_push($insertFiles, $upfiles);

                $efile->move('storage/files/', $filename);  

                $insertHistory = array(
                    'dcn_number'        => $dcnNumber,
                    'doc_version'       => 1,
                    'activity'          => 'Document Attachment Created : ' . $filename,
                    'createdby'         => Auth::user()->username ?? Auth::user()->email,
                    'createdon'         => getLocalDatabaseDateTime(),
                    'updatedon'         => getLocalDatabaseDateTime()
                );
                array_push($docHistory, $insertHistory);
            }

            // Generate Document Approval Workflow
            $wfapproval = DB::table('v_workflow_assignments')
                ->where('workflow_group', $wfgroup)
                // ->where('creatorid', Auth::user()->id)
                ->orderBy('approval_level', 'asc')
                ->get();

            if(sizeof($wfapproval) > 0){
                $insertApproval = array();
                foreach($wfapproval as $key => $row){
                    $is_active = 'N';
                    if($row->approval_level == $wfapproval[0]->approval_level){
                        $is_active = 'Y';
                    }
                    $approvals = array(
                        'dcn_number'        => $dcnNumber,
                        'approval_version'  => 1,
                        'workflow_group'    => $wfgroup,
                        'approver_level'    => $row->approval_level,
                        'approver_id'       => $row->approverid,
                        'creator_id'        => Auth::user()->id,
                        'is_active'         => $is_active,
                        'createdon'         => getLocalDatabaseDateTime(),
                        // 'createdby'         => Auth::user()->username ?? Auth::user()->email
                    );
                    array_push($insertApproval, $approvals);
                }
                insertOrUpdate($insertApproval,'document_approvals');
            }else{
                DB::rollBack();
                $doctype = DB::table('doctypes')->where('id', $req['doctype'])->first();
                // return Redirect::to("/transaction/document")
                return Redirect::to("/document/v2")
                ->withError('Approval Workflow Not Maintained Yet for user '. Auth::user()->username . ' in document type ' . $doctype->doctype);
            }

            // Insert Attchment Documents
            insertOrUpdate($insertFiles,'document_attachments');

            insertOrUpdate($docHistory,'document_historys');

            $impl   = '';
            $reason = '';

            if(isset($req['imp1'])){
                $impl = 'Y';
            }else{
                $impl = 'N';
            }

            if(isset($req['imp2'])){
                $impl = $impl.'Y';
            }else{
                $impl = $impl.'N';
            }

            if(isset($req['imp3'])){
                $impl = $impl.'Y';
            }else{
                $impl = $impl.'N';
            }

            if(isset($req['reason1'])){
                $reason = 'Y';
            }else{
                $reason = 'N';
            }

            if(isset($req['reason2'])){
                $reason = $reason.'Y';
            }else{
                $reason = $reason.'N';
            }

            if(isset($req['reason3'])){
                $reason = $reason.'Y';
            }else{
                $reason = $reason.'N';
            }

            if(isset($req['reason4'])){
                $reason = $reason.'Y';
            }else{
                $reason = $reason.'N';
            }

            $insertWiDoc = array();
            $wiDocData = array(
                'dcn_number'        => $dcnNumber,
                'doc_version'       => 1,
                'assy_code'         => $req['assycode'],
                'model_name'        => $req['model'],
                'scope'             => $req['scope'],
                'implementation'    => $impl,
                'reason'            => $reason,
                'createdon'         => getLocalDatabaseDateTime(),
                'createdby'         => Auth::user()->username ?? Auth::user()->email
            );
            array_push($insertWiDoc, $wiDocData);
            insertOrUpdate($insertWiDoc,'document_wi');
            // array_push($insertApproval, $wiDocData);
            // document_wi
            

            DB::commit();

            // v_workflow_assignments
            $mailTo = DB::table('v_workflow_assignments')
                      ->where('workflow_group', $wfgroup)
                      ->where('approval_level', 1)
                      ->pluck('approver_email');

            // return $mailTo;

            $mailData = [
                'email'    => 'husnulmub@gmail.com',
                'docID'    => $docID,
                'version'  => 1,
                'dcnNumb'  => $dcnNumber,
                'docTitle' => $req['doctitle'],
                'docCrdt'  => date('d-m-Y'),
                'docCrby'  => Auth::user()->name,
                'body'     => 'This is for testing email using smtp',
                'mailto'   => [
                    $mailTo
                ]
            ];

            // return $mailData;
            // $email = new MailNotif($this->data);
            Mail::to($mailTo)->queue(new MailNotif($mailData));
            // dispatch(new SendEmailJob($mailData, $mailTo));

            return Redirect::to("/document/v2")->withSuccess('New Document Created With Number '. $dcnNumber);
        } catch(\Exception $e){
            DB::rollBack();
            return Redirect::to("/document/v2")->withError($e->getMessage());
        }
    }
}
