<?php

namespace App\Http\Controllers\Transaction;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use DataTables, Auth, DB;
use Validator,Redirect,Response;

class DocumentController extends Controller
{
    public function index(){
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

        $cdoctype  = DB::table('doctypes')->where('id', $documents->document_type)->first();
        $cdoclevel = DB::table('doclevels')->where('id', $documents->document_level)->first();

        $attachments = DB::table('document_attachments')->where('dcn_number', $documents->dcn_number)->get();
        $docareasAffected = DB::table('v_docarea_affected')->where('dcn_number', $documents->dcn_number)->get();

        $docHistory = DB::table('v_document_historys')->where('dcn_number', $documents->dcn_number)->get();

        $docHistorydateGroup = DB::table('v_document_historys')
                ->select('dcn_number', 'created_date')->distinct()    
                ->orderBy('created_date', 'asc')
                ->where('dcn_number', $documents->dcn_number)->get();

        return view('transaction.document.detail', [
            'documents'     => $documents,
            'doctypes'      => $doctypes, 
            'doclevels'     => $doclevels, 
            'docareas'      => $docareas, 
            'attachments'   => $attachments,
            'affected_area' => $docareasAffected,
            'dochistory'     => $docHistory,
            'dochistorydate' => $docHistorydateGroup,
            'cdoctype'       => $cdoctype,
            'cdoclevel'      => $cdoclevel
        ]);
    }

    public function documentlist(Request $req){
        // return count($req->all());

        $query   = DB::table('v_documents');
        if(count($req->all()) > 0){
            if(isset($req->approvalStatus)){
                if($req->approvalStatus === "O"){
                    $query->where('status', 'Open');
                }elseif($req->approvalStatus === "C"){
                    $query->where('status', 'Closed');                
                }        
            }
    
            if(isset($req->datefrom) && isset($req->dateto)){
                $query->whereBetween('crtdate', [$req->datefrom, $req->dateto]);
            }elseif(isset($req->datefrom)){
                $query->where('crtdate', $req->datefrom);
            }elseif(isset($req->dateto)){
                $query->where('crtdate', $req->dateto);
            }
    
            $documents  = $query->where('createdby', Auth::user()->email)
                          ->orderBy('created_at', 'DESC')
                          ->get();
        }else{
            $documents  = $query->where('createdby', Auth::user()->email)
                          ->limit(10)
                          ->orderBy('created_at', 'DESC')
                          ->get();
        }

        return view('transaction.document.doclist', ['documents' => $documents]);
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

            DB::table('documents')->insert([
                'dcn_number'      => $dcnNumber,
                'document_type'   => $req['doctype'],
                'document_level'  => $req['doclevel'],
                'document_number' => $req['docnumber'],
                'document_title'  => $req['doctitle'],
                'description'     => $req['docremark'],
                'workflow_group'  => $wfgroup,
                'effectivity_date'=> $req['effectivedate'],
                'created_at'      => getLocalDatabaseDateTime(),
                'createdby'       => Auth::user()->email ?? Auth::user()->username
            ]);

            // document_historys
            
            $insertHistory = array(
                'dcn_number'        => $dcnNumber,
                'activity'          => 'Document Created : ' . $req['doctitle'],
                'createdby'         => Auth::user()->email ?? Auth::user()->username,
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
                    'created_at' => getLocalDatabaseDateTime(),
                    'createdby'  => Auth::user()->email ?? Auth::user()->username
                );
                array_push($insertFiles, $upfiles);

                $efile->move(public_path().'/files/', $filename);  

                $insertHistory = array(
                    'dcn_number'        => $dcnNumber,
                    'activity'          => 'Document Attachment Created : ' . $filename,
                    'createdby'         => Auth::user()->email ?? Auth::user()->username,
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
                    'createdon'         => getLocalDatabaseDateTime(),
                    'createdby'         => Auth::user()->email ?? Auth::user()->username
                );
                array_push($insertAreas, $areas);
            }
            if(sizeof($insertAreas) > 0){
                insertOrUpdate($insertAreas,'document_affected_areas');
            }

            // Generate Document Approval Workflow
            $wfapproval = DB::table('v_workflow_assignments')
                ->where('workflow_group', $wfgroup)
                ->orderBy('approval_level', 'asc')
                ->get();

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
                    'is_active'         => $is_active,
                    'createdon'         => getLocalDatabaseDateTime(),
                    // 'createdby'         => Auth::user()->email ?? Auth::user()->username
                );
                array_push($insertApproval, $approvals);
            }
            insertOrUpdate($insertApproval,'document_approvals');

            // Insert Attchment Documents
            insertOrUpdate($insertFiles,'document_attachments');

            insertOrUpdate($docHistory,'document_historys');
            

            DB::commit();
            return Redirect::to("/transaction/document")->withSuccess('New Document Created With Number '. $dcnNumber);
        } catch(\Exception $e){
            DB::rollBack();
            return Redirect::to("/transaction/document")->withError($e->getMessage());
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
                'updatedby'       => Auth::user()->email ?? Auth::user()->username
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
                    'createdby'         => Auth::user()->email ?? Auth::user()->username
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
                'createdby'         => Auth::user()->email ?? Auth::user()->username,
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
                    'doc_version'=> 2,
                    'efile'      => $filename,
                    'created_at' => getLocalDatabaseDateTime(),
                    'createdby'  => Auth::user()->email ?? Auth::user()->username
                );
                array_push($insertFiles, $upfiles);

                $efile->move(public_path().'/files/', $filename);  

                $insertHistory = array(
                    'dcn_number'        => $dcnNumber,
                    'activity'          => 'Document Attachment Created : ' . $filename,
                    'createdby'         => Auth::user()->email ?? Auth::user()->username,
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
