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

            $docversion = 0;

            DB::table('document_versions')->insert([
                'dcn_number'  => $dcnNumber,
                'doc_version' => $docversion,
                'remark'      => null,
                'established_date' => $req['estabdate'],
                'validity_date'    => $req['validitydate'],
                'createdon'        => getLocalDatabaseDateTime(),
                'createdby'        => Auth::user()->username ?? Auth::user()->email
            ]);
            // document_historys
            
            $insertHistory = array(
                'dcn_number'        => $dcnNumber,
                'doc_version'       => $docversion,
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
                    'doc_version'=> $docversion,
                    'efile'      => $filename,
                    'pathfile'   => 'storage/files/'. $filename,
                    'created_at' => getLocalDatabaseDateTime(),
                    'createdby'  => Auth::user()->username ?? Auth::user()->email
                );
                array_push($insertFiles, $upfiles);

                $efile->move('storage/files/', $filename);  

                $insertHistory = array(
                    'dcn_number'        => $dcnNumber,
                    'doc_version'       => $docversion,
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
                ->where('creatorid', Auth::user()->id)
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
                        'approval_version'  => $docversion,
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
                'doc_version'       => $docversion,
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
                      ->where('creatorid', Auth::user()->id)
                      ->where('approval_level', 1)
                      ->pluck('approver_email');

            // return $mailTo;

            $mailData = [
                'email'    => 'husnulmub@gmail.com',
                'docID'    => $docID,
                'subject'  => 'Approval Request ' . $dcnNumber,
                'version'  => $docversion,
                'dcnNumb'  => $dcnNumber,
                'docTitle' => $req['doctitle'],
                'docCrdt'  => date('d-m-Y'),
                'docCrby'  => Auth::user()->name,
                'body'     => 'A New document has been created for your review and approval',
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

    public function uploadapprovaldoc(Request $req){
        $document = DB::table('documents')->where('dcn_number', $req['dcnNumber'])->first();
        DB::beginTransaction();
        try{
            
            $approvalfile     = $req->file('approveddoc');
            $filename         = $approvalfile->getClientOriginalName();
            $approvalfilepath = 'storage/files/approvaldocs/'. $filename;  

            if($approvalfile){
                $approvalfile->move('storage/files/approvaldocs/', $filename);  
            }

            $AppDocData = array();
            $insertAppDoc = array(
                'dcn_number'        => $req['dcnNumber'],
                'doc_version'       => $req['docVersion'],
                'efile'             => $approvalfilepath,
                'filename'          => $filename ?? null,
                'createdby'         => Auth::user()->email ?? Auth::user()->username,
                'createdon'         => getLocalDatabaseDateTime()
            );
            array_push($AppDocData, $insertAppDoc);
            insertOrUpdate($AppDocData,'approval_attachments');

            // DB::table('approval_attachments')
            //     ->where('dcn_number', $req['dcnNumber'])
            //     ->where('doc_version', '!=', $req['docVersion'])
            //     ->update([
            //         'isactive'          => 'N'
            //     ]);

            DB::commit();
            return Redirect::to("/transaction/doclist/detail/".$document->id)->withSuccess('Upload Original Document Success');
        }catch(\Exception $e){
            DB::rollBack();
            return Redirect::to("/transaction/doclist/detail/".$document->id)->withError($e->getMessage());
        }        
    }

    public function saveNewDocVersion($id, Request $req){
        // return generateDcnNumber();
        // return public_path();

        DB::beginTransaction();
        try{
            $this->validate($req, [
                'docfiles'   => 'required',
                // 'filename.*' => 'mimes:doc,pdf,docx,zip'
            ]);

            $files = $req['docfiles'];

            $document = DB::table('documents')->where('id', $id)->first();
            $docVersi = DB::table('document_versions')->where('dcn_number', $document->dcn_number)->orderBy('doc_version', 'DESC')->first();
            $dcnNumber = $document->dcn_number;
            $docVersion = $docVersi->doc_version + 1;

            // return $docVersion;

            $docHistory = array();
            $insertFiles = array();

            DB::table('documents')->where('id', $id)->update([
                'revision_number' => $document->revision_number + 1,
                'updated_at'      => getLocalDatabaseDateTime(),
                'updatedby'       => Auth::user()->username ?? Auth::user()->email
            ]);

            DB::table('document_versions')->insert([
                'dcn_number'  => $dcnNumber,
                'doc_version' => $docVersion,
                'remark'      => $req['docremark'],
                'effectivity_date' => $req['efectivitydate'],
                'createdon'   => getLocalDatabaseDateTime(),
                'createdby'       => Auth::user()->username ?? Auth::user()->email
            ]);
            // document_historys
            
            $insertHistory = array(
                'dcn_number'        => $dcnNumber,
                'doc_version'       => $docVersion,
                'activity'          => 'New Document Version Created : ' . $document->document_title,
                'createdby'         => Auth::user()->username ?? Auth::user()->email,
                'createdon'         => getLocalDatabaseDateTime(),
                'updatedon'         => getLocalDatabaseDateTime()
            );
            array_push($docHistory, $insertHistory);

            foreach ($files as $efile) {
                $filename = $dcnNumber.'V'.$docVersion.'-'.$efile->getClientOriginalName();
                $upfiles = array(
                    'dcn_number' => $dcnNumber,
                    'doc_version'=> $docVersion,
                    'efile'      => $filename,
                    'pathfile'   => 'storage/files/'. $filename,
                    'created_at' => getLocalDatabaseDateTime(),
                    'createdby'  => Auth::user()->username ?? Auth::user()->email
                );
                array_push($insertFiles, $upfiles);

                $efile->move('storage/files/', $filename);  

                $insertHistory = array(
                    'dcn_number'        => $dcnNumber,
                    'doc_version'       => $docVersion,
                    'activity'          => 'Document Attachment Created : ' . $filename,
                    'createdby'         => Auth::user()->username ?? Auth::user()->email,
                    'createdon'         => getLocalDatabaseDateTime(),
                    'updatedon'         => getLocalDatabaseDateTime()
                );
                array_push($docHistory, $insertHistory);
            }

            // Document Affected Areas | document_affected_areas
            $insertAreas = array();
            if(isset($req['docareas'])){
                $docareas = $req['docareas'];
                for($i = 0; $i < sizeof($docareas); $i++){
                    $areas = array(
                        'dcn_number'        => $dcnNumber,
                        'docarea'           => $docareas[$i],
                        'doc_version'       => $docVersion,
                        'createdon'         => getLocalDatabaseDateTime(),
                        'createdby'         => Auth::user()->username ?? Auth::user()->email
                    );
                    array_push($insertAreas, $areas);
                }
                if(sizeof($insertAreas) > 0){
                    insertOrUpdate($insertAreas,'document_affected_areas');
                }
            }else{
                $AffectedDocarea = DB::table('document_affected_areas')
                                   ->where('dcn_number',  $dcnNumber)
                                   ->where('doc_version', 1)
                                   ->get();
                foreach($AffectedDocarea as $data => $row){
                    $areas = array(
                        'dcn_number'        => $dcnNumber,
                        'docarea'           => $row->docarea,
                        'doc_version'       => $docVersion,
                        'createdon'         => getLocalDatabaseDateTime(),
                        'createdby'         => Auth::user()->username ?? Auth::user()->email
                    );
                    array_push($insertAreas, $areas);
                }
                if(sizeof($insertAreas) > 0){
                    insertOrUpdate($insertAreas,'document_affected_areas');
                }
            }

            // Generate Document Approval Workflow
            $wfapproval = DB::table('v_workflow_assignments')
                ->where('workflow_group', $document->workflow_group)
                ->where('creatorid', Auth::user()->id)
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
                        'approval_version'  => $docVersion,
                        'workflow_group'    => $document->workflow_group,
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
                $doctype = DB::table('doctypes')->where('id', $document->document_type)->first();
                return Redirect::to("/transaction/doclist/detail/".$id)
                    ->withError('Approval Workflow Not Maintained Yet for user '. Auth::user()->username . ' in document type ' . $doctype->doctype);
            }

            DB::table('document_approvals')
                ->where('dcn_number', $dcnNumber)
                ->where('approval_version', '!=', $docVersion)
                ->update([
                    'is_active'         => 'N',
                    'approval_status'   => 'C',
                    'approval_remark'   => 'Auto Closed by New Version',
                    'approval_date'     => getLocalDatabaseDateTime()
            ]);

            DB::table('document_versions')
            ->where('dcn_number', $dcnNumber)
            ->where('doc_version', '!=', $docVersion)
            ->update([
                'status'         => 'Obsolete',
            ]);

            
            // Insert Attchment Documents
            insertOrUpdate($insertFiles,'document_attachments');

            insertOrUpdate($docHistory,'document_historys');
            
            DB::commit();

            $mailTo = DB::table('v_workflow_assignments')
                      ->where('workflow_group', $document->workflow_group)
                      ->where('approval_level', 1)
                      ->pluck('approver_email');

            $mailData = [
                'email'    => 'husnulmub@gmail.com',
                'docID'    => $id,
                'subject'  => 'Approval Request ' . $dcnNumber,
                'version'  => $docVersion,
                'dcnNumb'  => $dcnNumber,
                'docTitle' => $document->document_title,
                'docCrdt'  => date('d-m-Y'),
                'docCrby'  => Auth::user()->name,
                'body'     => 'A New document has been created for your review and approval'
            ];
            
            // dispatch(new SendEmailJob($mailData));
            Mail::to($mailTo)->queue(new MailNotif($mailData));

            return Redirect::to("/transaction/doclist/detail/".$id)->withSuccess('New Version of Document '. $dcnNumber .' Created');
        } catch(\Exception $e){
            DB::rollBack();
            return Redirect::to("/transaction/doclist/detail/".$id)->withError($e->getMessage());
        }
    }

    public function updatedocversion($docversion, Request $req){
        // return $req;
        DB::beginTransaction();
        try{
            $this->validate($req, [

                'docfiles'   => 'required',
                // 'filename.*' => 'mimes:doc,pdf,docx,zip'

            ]);

            $files = $req['docfiles'];
            
            $dcnNumber = $req['dcnNumber'];
            $wfgroup   = getWfGroup($req['doctype']);
            
            $docGenOldData = DB::table('documents')->where('dcn_number', $dcnNumber)->first();
            $docVerOldData = DB::table('document_versions')
                            ->where('dcn_number', $dcnNumber)
                            ->where('doc_version', $docversion)
                            ->first();

            // return $docVerOldData;
            $docHistory  = array();
            $insertFiles = array();
            $docID = $docGenOldData->id;
            
            DB::table('documents')->where('dcn_number', $dcnNumber)->update([
                // 'dcn_number'      => $dcnNumber,
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

            DB::table('document_versions')->where('dcn_number', $dcnNumber)
            ->where('doc_version', $docversion)->update([
                // 'remark'           => null,
                'established_date' => $req['establisheddate'],
                'validity_date'    => $req['ValidityDate'],
                'changeon'         => getLocalDatabaseDateTime(),
                'status'           => 'Open'
            ]);
            // document_historys
            
            $insertHistory = array(
                'dcn_number'        => $dcnNumber,
                'doc_version'       => $docversion,
                'activity'          => 'Document Updated : ' . $req['doctitle'],
                'createdby'         => Auth::user()->username ?? Auth::user()->email,
                'createdon'         => getLocalDatabaseDateTime(),
                'updatedon'         => getLocalDatabaseDateTime()
            );
            array_push($docHistory, $insertHistory);

            foreach ($files as $efile) {
                $filename = $dcnNumber.'-'.$efile->getClientOriginalName();
                $upfiles = array(
                    'dcn_number' => $dcnNumber,
                    'doc_version'=> $docversion,
                    'efile'      => $filename,
                    'pathfile'   => 'storage/files/'. $filename,
                    'created_at' => getLocalDatabaseDateTime(),
                    'createdby'  => Auth::user()->username ?? Auth::user()->email
                );
                array_push($insertFiles, $upfiles);

                $efile->move('storage/files/', $filename);  

                $insertHistory = array(
                    'dcn_number'        => $dcnNumber,
                    'doc_version'       => $docversion,
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
                ->where('creatorid', Auth::user()->id)
                ->orderBy('approval_level', 'asc')
                ->get();

            if(sizeof($wfapproval) > 0){
                DB::table('document_approvals')
                    ->where('dcn_number', $dcnNumber)
                    ->where('approval_version', $docversion)
                    ->delete();

                $insertApproval = array();
                foreach($wfapproval as $key => $row){
                    $is_active = 'N';
                    if($row->approval_level == $wfapproval[0]->approval_level){
                        $is_active = 'Y';
                    }
                    $approvals = array(
                        'dcn_number'        => $dcnNumber,
                        'approval_version'  => $docversion,
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
                'doc_version'       => $docversion,
                'assy_code'         => $req['assycode'],
                'model_name'        => $req['model'],
                'scope'             => $req['scope'],
                'implementation'    => $impl,
                'reason'            => $reason,
                // 'createdon'         => getLocalDatabaseDateTime(),
                // 'createdby'         => Auth::user()->username ?? Auth::user()->email
            );
            array_push($insertWiDoc, $wiDocData);
            insertOrUpdate($insertWiDoc,'document_wi');
            // array_push($insertApproval, $wiDocData);
            // document_wi
            

            DB::commit();

            // v_workflow_assignments
            $mailTo = DB::table('v_workflow_assignments')
                      ->where('workflow_group', $wfgroup)
                      ->where('creatorid', Auth::user()->id)
                      ->where('approval_level', 1)
                      ->pluck('approver_email');

            // return $mailTo;

            $mailData = [
                'email'    => 'husnulmub@gmail.com',
                'docID'    => $docID,
                'subject'  => 'Approval Request ' . $dcnNumber,
                'version'  => $docversion,
                'dcnNumb'  => $dcnNumber,
                'docTitle' => $req['doctitle'],
                'docCrdt'  => date('d-m-Y'),
                'docCrby'  => Auth::user()->name,
                'body'     => 'A New document has been created for your review and approval',
                'mailto'   => [
                    $mailTo
                ]
            ];

            // return $mailData;
            // $email = new MailNotif($this->data);
            Mail::to($mailTo)->queue(new MailNotif($mailData));
            // dispatch(new SendEmailJob($mailData, $mailTo));

            return Redirect::to("/document/rejectedlist")->withSuccess('Document '. $dcnNumber .' Version '. $docversion . ' updated!');
        } catch(\Exception $e){
            DB::rollBack();
            return Redirect::to("/document/rejectedlist")->withError($e->getMessage());
        }
    }
}
