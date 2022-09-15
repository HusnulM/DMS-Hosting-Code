<?php

namespace App\Http\Controllers\Transaction;

use App\Http\Controllers\Controller;
use App\Jobs\SendEmailJob;
use App\Mail\MailNotif;
use Illuminate\Http\Request;

use DataTables, Auth, DB;
use Validator,Redirect,Response;
use Mail;
use PDF;

class DocumentController extends Controller
{
    public function index(){
        // $filterdoctype = DB::
        $doctypes  = DB::table('doctypes')->get();
        $doclevels = DB::table('doclevels')->get();
        $docareas  = DB::table('docareas')->get();
        return view('transaction.document.index', ['doctypes' => $doctypes, 'doclevels' => $doclevels, 'docareas' => $docareas]);
    }

    public function documentDetail($id){
        $doctypes  = DB::table('doctypes')->get();
        $doclevels = DB::table('doclevels')->get();
        $docareas  = DB::table('docareas')->get();

        $documents  = DB::table('v_documents')
                      ->where('id', $id)
                      ->first();
        
        $docversions = DB::table('document_versions')->where('dcn_number', $documents->dcn_number)->orderBy('doc_version', 'DESC')->get();

        $latestVersion = $docversions[0]->doc_version;

        $cdoctype  = DB::table('doctypes')->where('id', $documents->document_type)->first();
        $cdoclevel = DB::table('doclevels')->where('id', $documents->document_level)->first();

        // return $cdoctype;

        $attachments = DB::table('document_attachments')
                        ->where('dcn_number', $documents->dcn_number)
                        ->where('doc_version', $latestVersion)
                        ->get();

        $docareasAffected = DB::table('v_docarea_affected')
                        ->where('dcn_number', $documents->dcn_number)
                        ->where('doc_version', $latestVersion)
                        ->get();

        $docHistory = DB::table('v_document_historys')
                        ->where('dcn_number', $documents->dcn_number)->orderBy('id', 'desc')->get();

        
        $wiDocData = DB::table('document_wi')
                        ->where('dcn_number', $documents->dcn_number)
                        ->where('doc_version', $latestVersion)
                        ->first();
                        if(!$wiDocData){
                            $wiDocData = null;
                        }

        $docHistorydateGroup = DB::table('v_document_historys')
                ->select('dcn_number', 'created_date','doc_version')->distinct()    
                ->orderBy('created_date', 'desc')
                ->where('dcn_number', $documents->dcn_number)->get();

        $docAllHistorydateGroup = DB::table('v_document_historys')
                ->select('dcn_number', 'created_date')->distinct()    
                ->orderBy('created_date', 'desc')
                ->where('dcn_number', $documents->dcn_number)->get();

        $docapproval = DB::table('v_document_approvals_v2')
                        ->where('dcn_number', $documents->dcn_number)
                        ->where('approval_version', $latestVersion)
                        ->get();
                        // return $docHistorydateGroup;
        $docVersionData = DB::table('document_versions')->where('dcn_number',  $documents->dcn_number)->where('doc_version', $latestVersion)->first();
        
        $approvalDoc = DB::table('approval_attachments')
                        ->where('dcn_number',  $documents->dcn_number)
                        ->where('doc_version', $latestVersion)
                        ->get();

        if($documents->doctype == 'Corporate Procedure'){            
                        // return $approvalDoc;

            return view('transaction.document.documentdetail', [
                'documents'     => $documents,
                'docversions'   => $docversions,
                'doctypes'      => $doctypes, 
                'doclevels'     => $doclevels, 
                'docareas'      => $docareas, 
                'attachments'   => $attachments,
                'affected_area' => $docareasAffected,
                'dochistory'     => $docHistory,
                'dochistorydate' => $docHistorydateGroup,
                'alldochistorydate' => $docAllHistorydateGroup,
                'cdoctype'       => $cdoctype,
                'cdoclevel'      => $cdoclevel,
                'latestVersion'  => $latestVersion,
                'docapproval'    => $docapproval,
                'approvalDoc'    => $approvalDoc
            ]);
        }elseif($documents->doctype == 'Work Instruction'){

            return view('transaction.document.documentdetailv2', [
                'documents'     => $documents,
                'docversions'   => $docversions,
                'doctypes'      => $doctypes, 
                'doclevels'     => $doclevels, 
                'docareas'      => $docareas, 
                'attachments'   => $attachments,
                'affected_area' => $docareasAffected,
                'dochistory'     => $docHistory,
                'dochistorydate' => $docHistorydateGroup,
                'alldochistorydate' => $docAllHistorydateGroup,
                'cdoctype'       => $cdoctype,
                'cdoclevel'      => $cdoclevel,
                'latestVersion'  => $latestVersion,
                'docapproval'    => $docapproval,
                'wiDocData'      => $wiDocData,
                'docVersionData'   => $docVersionData,
                'approvalDoc'      => $approvalDoc
            ]);
        }
        elseif($documents->doctype == 'Work Standard'){
            return view('transaction.document.documentdetailv3', [
                'documents'     => $documents,
                'docversions'   => $docversions,
                'doctypes'      => $doctypes, 
                'doclevels'     => $doclevels, 
                'docareas'      => $docareas, 
                'attachments'   => $attachments,
                'affected_area' => $docareasAffected,
                'dochistory'     => $docHistory,
                'dochistorydate' => $docHistorydateGroup,
                'alldochistorydate' => $docAllHistorydateGroup,
                'cdoctype'       => $cdoctype,
                'cdoclevel'      => $cdoclevel,
                'latestVersion'  => $latestVersion,
                'docapproval'    => $docapproval,
                'wiDocData'      => $wiDocData,
                'docVersionData'   => $docVersionData,
                'approvalDoc'      => $approvalDoc
            ]);
        }
    }

    public function printOutDocument($docid)
    {
        // set_time_limit(300);
    	$doc  = DB::table('v_documents')->where('id', $docid)->first();
        $logo = DB::table('general_setting')->where('setting_name', 'COMPANY_LOGO')->first();
        $docversions = DB::table('document_versions')->where('dcn_number', $doc->dcn_number)->orderBy('doc_version', 'desc')->get();

        $latestVersion = DB::table('document_versions')->select('doc_version')
                        ->where('dcn_number', $doc->dcn_number)->orderBy('doc_version', 'DESC')->first();

                        // return $latestVersion;
        $approval    = DB::table('v_document_approvals_v2')
                        ->where('dcn_number', $doc->dcn_number)
                        ->where('approval_version', $latestVersion->doc_version)->get();

        $creatorSignature = DB::table('users')->where('username', $doc->createdby)->first();
        
        // $esignature = DB::table('document_approvals')
        // return view('transaction.document.printout', ['document'=>$doc, 'logo' => $logo, 'versions' => $docversions, 'approval' => $approval]);
    	$pdf = PDF::loadview('transaction.document.printout',['document'=>$doc, 'logo' => $logo, 'versions' => $docversions, 'approval' => $approval, 'creatorSignature' => $creatorSignature]);
    	// return $pdf->download('laporan-pegawai-pdf');
        return $pdf->stream();
    }

    public function documentDetailVersion($version, $docid){

        $document  = DB::table('v_documents')
                      ->where('id', $docid)
                      ->first();

        $data['docversions'] = DB::table('document_versions')
                                ->where('dcn_number', $document->dcn_number)
                                ->where('doc_version', $version)
                                ->first();
        
        $data['affected_area'] = DB::table('v_docarea_affected')
                                ->where('dcn_number', $document->dcn_number)
                                ->where('doc_version', $version)
                                ->get();

        $data['attachments']   = DB::table('document_attachments')
                                ->where('dcn_number', $document->dcn_number)
                                ->where('doc_version', $version)
                                ->get();

        $data['docHistory'] = DB::table('v_document_historys')
                                ->where('dcn_number', $document->dcn_number)
                                ->where('doc_version', $version)
                                ->get();
        
        $data['docHistorydateGroup'] = DB::table('v_document_historys')
                        ->select('dcn_number', 'created_date')->distinct()    
                        ->orderBy('created_date', 'desc')
                        ->where('dcn_number', $document->dcn_number)
                        ->where('doc_version', $version)
                        ->get();

        $data['docapproval'] = DB::table('v_document_approvals_v2')
                        ->where('dcn_number', $document->dcn_number)
                        ->where('approval_version', $version)
                        ->get();      
        

        $data['approvalDoc'] = DB::table('approval_attachments')
                        ->where('dcn_number', $document->dcn_number)
                        ->where('doc_version', $version)
                        // ->where('isactive', 'Y')
                        ->get();

        $data['docVersionData'] = DB::table('document_versions')->where('dcn_number',  $document->dcn_number)->where('doc_version', $version)->first();      
        
        $htmlApproval = '';
        foreach($data['docapproval'] as $key => $row){
            $appStatus = '';
            $appStyle  = '';
            if($row->approval_status == "A"){
                $appStatus = 'Approved';
                $appStyle  = 'text-align:center; background-color:green; color:white;';
            }elseif($row->approval_status == "R"){
                $appStatus = 'Rejected';
                $appStyle  = 'text-align:center; background-color:red; color:white;';
            }else{
                $appStatus = 'Open';
                $appStyle  = 'text-align:center; background-color:yellow; color:black;';
            }
            $htmlApproval .= "
            <tr>    
                <td> $row->approver_name </td>
                <td> $row->approver_level | $row->wf_categoryname</td>
                <td style='$appStyle'>
                    $appStatus
                </td>                
                <td>";
                    if($row->approval_date != null){
                        $htmlApproval .= "<i class='fa fa-clock'></i> ".\Carbon\Carbon::parse($row->approval_date)->diffForHumans(). " <br>
                        (".formatDateTime($row->approval_date).")";
                    }else{
                        $htmlApproval .="";
                    }
            $htmlApproval .="</td>
                <td>$row->approval_remark</td>
            </tr>
            ";    
        }
        $data['htmlApproval'] = $htmlApproval;
                                                

        $htmlAttachment = '';
        foreach($data['attachments'] as $key => $file){
            $counter = $key+1;
            $htmlAttachment .= "
                <tr>
                    <td>". $counter . "</td>
                    <td>
                        $file->efile
                    </td>
                    <td>
                        <i class='fa fa-clock'></i> ".\Carbon\Carbon::parse($file->created_at)->diffForHumans()." - 
                        (".formatDateTime($file->created_at).")
                    </td>
                    <td>
                        <button type='button' class='btn-preview' data-filepath='$file->pathfile#toolbar=0'>Preview</button>
                    </td>
                </tr>";
        }

        // return $htmlAttachment;
        $data['htmlAttachment'] = $htmlAttachment;

        $html = '';
        foreach($data['docHistorydateGroup'] as $hdr => $vlhdr){
            $html .= "<div class='time-label'>
                        <span class='bg-red'>".formatDate($vlhdr->created_date)."</span>
                    </div>";
            foreach($data['docHistory'] as $dtl => $vldtl){
                if($vlhdr->created_date == $vldtl->created_date){
                    $html .="
                    <div>
                        <i class='fas fa-user bg-green' title='$vldtl->createdby'></i>
                        <div class='timeline-item'>
                            <span class='time'>
                                <i class='fas fa-clock'></i>
                                ".\Carbon\Carbon::parse(".$vldtl->createdon.")->diffForHumans()." <br>
                                ($vldtl->createdon)
                            </span>
                            <h3 class='timeline-header no-border'>
                                <b>".$vldtl->createdby."</b> <br>
                                $vldtl->activity
                            </h3>
                        </div>
                    </div>";
                }
            }
        }

        $data['timeline'] = $html;
        // return $html;

        return $data;

    }

    public function documentlist(Request $req){
        // return count($req->all());

        // $query   = DB::table('v_documents');
        // if(count($req->all()) > 0){
        //     if(isset($req->approvalStatus)){
        //         if($req->approvalStatus === "O"){
        //             $query->where('status', 'Open');
        //         }elseif($req->approvalStatus === "C"){
        //             $query->where('status', 'Closed');                
        //         }        
        //     }
    
        //     if(isset($req->datefrom) && isset($req->dateto)){
        //         $query->whereBetween('crtdate', [$req->datefrom, $req->dateto]);
        //     }elseif(isset($req->datefrom)){
        //         $query->where('crtdate', $req->datefrom);
        //     }elseif(isset($req->dateto)){
        //         $query->where('crtdate', $req->dateto);
        //     }
    
        //     $documents  = $query
        //                 //   ->where('createdby', Auth::user()->username)
        //                   ->orderBy('created_at', 'DESC')
        //                   ->get();
        // }else{
        //     $documents  = $query
        //                 //   ->where('createdby', Auth::user()->username)
        //                   ->limit(10)
        //                   ->orderBy('created_at', 'DESC')
        //                   ->get();
        // }

        // return view('transaction.document.doclist', ['documents' => $documents]);
        $doctypes  = DB::table('doctypes')->get();

        return view('transaction.document.doclist', ['doctypes' => $doctypes]);
    }

    public function loadDocList(Request $req){
        $params = $req->params;
        $whereClause = $params['sac'];

        $query   = DB::table('v_documents');
        if(count($req->all()) > 0){
            // if(isset($req->approvalStatus)){
            //     if($req->approvalStatus === "O"){
            //         $query->where('status', 'Open');
            //     }elseif($req->approvalStatus === "C"){
            //         $query->where('status', 'Closed');                
            //     }        
            // }
    
            if(isset($req->datefrom) && isset($req->dateto)){
                $query->whereBetween('crtdate', [$req->datefrom, $req->dateto]);
            }elseif(isset($req->datefrom)){
                $query->where('crtdate', $req->datefrom);
            }elseif(isset($req->dateto)){
                $query->where('crtdate', $req->dateto);
            }

            if(isset($req->doctype)){
                if($req->doctype == 'All'){

                }else{
                    $query->where('document_type', $req->doctype);
                }
            }
        }

        $query->orderBy('created_at', 'DESC');

        return DataTables::queryBuilder($query)
                    ->editColumn('created_at', function ($query){
                        return [
                            'date1' => \Carbon\Carbon::parse($query->created_at)->diffForHumans(),
                            'originaldate1' => \Carbon\Carbon::parse($query->created_at)->format('d-m-Y H:m:s')
                            // $query->created_at->format('d-m-Y H:m:s')
                         ];
                    })->editColumn('updated_at', function ($query){
                        return [
                            'date2' => \Carbon\Carbon::parse($query->updated_at)->diffForHumans(),
                            'originaldate2' => \Carbon\Carbon::parse($query->updated_at)->format('d-m-Y H:m:s')
                         ];
                    })
                    ->toJson();
    }

    public function save(Request $req){
        // return generateDcnNumber();
        // return public_path();
        DB::beginTransaction();
        try{
            $this->validate($req, [

                'docfiles'   => 'required',
                // 'filename.*' => 'mimes:doc,pdf,docx,zip'

            ]);

            $files = $req['docfiles'];
            
            $dcnNumber = generateDcnNumber();
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
                'effectivity_date'=> $req['effectivedate'],
                'created_at'      => getLocalDatabaseDateTime(),
                'createdby'       => Auth::user()->username ?? Auth::user()->email
            ]);

            DB::table('document_versions')->insert([
                'dcn_number'  => $dcnNumber,
                'doc_version' => 1,
                'remark'      => 'Test Remark',
                'effectivity_date' => $req['effectivedate'],
                'createdon'   => getLocalDatabaseDateTime(),
                'createdby'       => Auth::user()->username ?? Auth::user()->email
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
                    'pathfile'   => '/files/'. $filename,
                    'created_at' => getLocalDatabaseDateTime(),
                    'createdby'  => Auth::user()->username ?? Auth::user()->email
                );
                array_push($insertFiles, $upfiles);

                $efile->move(public_path().'/files/', $filename);  

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

            // Document Affected Areas | document_affected_areas
            if(isset($req['docareas'])){
                $docareas = $req['docareas'];
                $insertAreas = array();
                for($i = 0; $i < sizeof($docareas); $i++){
                    $areas = array(
                        'dcn_number'        => $dcnNumber,
                        'docarea'           => $docareas[$i],
                        'doc_version'       => 1,
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
                return Redirect::to("/transaction/document")
                ->withError('Approval Workflow Not Maintained Yet for user '. Auth::user()->username . ' in document type ' . $doctype->doctype);
            }

            // Insert Attchment Documents
            insertOrUpdate($insertFiles,'document_attachments');

            insertOrUpdate($docHistory,'document_historys');
            

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

            return Redirect::to("/transaction/document")->withSuccess('New Document Created With Number '. $dcnNumber);
        } catch(\Exception $e){
            DB::rollBack();
            return Redirect::to("/transaction/document")->withError($e->getMessage());
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
                    'pathfile'   => '/files/'. $filename,
                    'created_at' => getLocalDatabaseDateTime(),
                    'createdby'  => Auth::user()->username ?? Auth::user()->email
                );
                array_push($insertFiles, $upfiles);

                $efile->move(public_path().'/files/', $filename);  

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
            $docareas = $req['docareas'];
            $insertAreas = array();
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
                'version'  => $docVersion,
                'dcnNumb'  => $dcnNumber,
                'docTitle' => $document->document_title,
                'docCrdt'  => date('d-m-Y'),
                'docCrby'  => Auth::user()->name,
                'body'     => 'This is for testing email using smtp'
            ];
            
            // dispatch(new SendEmailJob($mailData));
            Mail::to($mailTo)->queue(new MailNotif($mailData));

            return Redirect::to("/transaction/doclist/detail/".$id)->withSuccess('New Version of Document '. $dcnNumber .' Created');
        } catch(\Exception $e){
            DB::rollBack();
            return Redirect::to("/transaction/doclist/detail/".$id)->withError($e->getMessage());
        }
    }

    public function updatedocinfo($id, Request $req){
        DB::beginTransaction();
        try{
            $document = DB::table('documents')->where('id', $id)->first();
            $dcnNumber = $document->dcn_number;

            DB::table('documents')->where('id', $id)->update([
                'document_type'   => $req['doctype'],
                'document_level'  => $req['doclevel'],
                'document_number' => $req['docnumber'],
                'document_title'  => $req['doctitle'],
                'description'     => $req['docremark'],
                // 'workflow_group'  => $wfgroup,
                'effectivity_date'=> $req['effectivedate'],
                'updated_at'      => getLocalDatabaseDateTime(),
                'updatedby'       => Auth::user()->username ?? Auth::user()->email
            ]);
            DB::commit();
            return Redirect::to("/transaction/doclist")->withSuccess('Document '. $dcnNumber .' Updated ');
        }catch(\Exception $e){
            DB::rollBack();
            return Redirect::to("/transaction/doclist")->withError($e->getMessage());
        }
    }

    public function updatearea($id, Request $req){
        DB::beginTransaction();
        try{
            $document = DB::table('documents')->where('id', $id)->first();
            $dcnNumber = $document->dcn_number;

            $docareas = $req['docareas'];
            $insertAreas = array();
            for($i = 0; $i < sizeof($docareas); $i++){
                $areas = array(
                    'dcn_number'        => $dcnNumber,
                    'docarea'           => $docareas[$i],
                    'createdon'         => getLocalDatabaseDateTime(),
                    'createdby'         => Auth::user()->username ?? Auth::user()->email
                );
                array_push($insertAreas, $areas);
            }
            if(sizeof($insertAreas) > 0){
                insertOrUpdate($insertAreas,'document_affected_areas');
            }

            $docHistory = array();
            $insertHistory = array(
                'dcn_number'        => $dcnNumber,
                'activity'          => 'Affected Document Area Updated',
                'createdby'         => Auth::user()->username ?? Auth::user()->email,
                'createdon'         => getLocalDatabaseDateTime(),
                'updatedon'         => getLocalDatabaseDateTime()
            );
            array_push($docHistory, $insertHistory);

            DB::commit();
            return Redirect::to("/transaction/doclist")->withSuccess('Document '. $dcnNumber .' Affected Area Updated ');
        }catch(\Exception $e){
            DB::rollBack();
            return Redirect::to("/transaction/doclist")->withError($e->getMessage());
        }
    }

    public function updatefiles($id, Request $req){
        DB::beginTransaction();
        try{
            $this->validate($req, [
                'docfiles'   => 'required',
            ]);

            $files = $req['docfiles'];
            
            $document = DB::table('documents')->where('id', $id)->first();
            $dcnNumber = $document->dcn_number;

            $docHistory = array();
            $insertFiles = array();

            foreach ($files as $efile) {
                $filename = $dcnNumber.'-'.$efile->getClientOriginalName();
                $upfiles = array(
                    'dcn_number' => $dcnNumber,
                    'doc_version'=> 1,
                    'efile'      => $filename,
                    'created_at' => getLocalDatabaseDateTime(),
                    'createdby'  => Auth::user()->username ?? Auth::user()->email
                );
                array_push($insertFiles, $upfiles);

                $efile->move(public_path().'/files/', $filename);  

                $insertHistory = array(
                    'dcn_number'        => $dcnNumber,
                    'activity'          => 'Document Attachment Created : ' . $filename,
                    'doc_version'       => 1,
                    'createdby'         => Auth::user()->username ?? Auth::user()->email,
                    'createdon'         => getLocalDatabaseDateTime(),
                    'updatedon'         => getLocalDatabaseDateTime()
                );
                array_push($docHistory, $insertHistory);
            }
            // Insert Attchment Documents
            insertOrUpdate($insertFiles,'document_attachments');

            insertOrUpdate($docHistory,'document_historys');
            

            DB::commit();
            return Redirect::to("/transaction/doclist")->withSuccess('Document '. $dcnNumber .' Attachment Updated ');
        } catch(\Exception $e){
            DB::rollBack();
            return Redirect::to("/transaction/doclist")->withError($e->getMessage());
        }
    }
}
