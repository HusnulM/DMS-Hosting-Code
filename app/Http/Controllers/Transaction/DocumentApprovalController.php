<?php

namespace App\Http\Controllers\Transaction;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Barryvdh\DomPDF\Facade as PDF;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Str;
use Intervention\Image\Facades\Image;
use App\Jobs\SendEmailJob;
use App\Mail\MailNotif;

use DataTables, Auth, DB;
use Validator,Redirect,Response;
use Mail;

class DocumentApprovalController extends Controller
{
    public function index(){
        // return getLocalDatabaseDateTime();
        // dd(Auth::user()->id);
        $documents  = DB::table('v_doc_approval_list')
                      ->where('approver_id', Auth::user()->id)
                      ->where('doc_version_status', 'Open')
                      ->where('is_active', 'Y')
                      ->where('approval_status', 'N')
                      ->orderBy('created_at', 'DESC')
                      ->get();
                    //   return $documents;
        return view('transaction.documentapproval.index', ['documents' => $documents]);
    }

    public function approveDetail($id, $version){
        $documents  = DB::table('v_documents')
                      ->where('id', $id)
                    //   ->where('doc_version', $version)
                      ->first();
        if(!$documents){
            return Redirect::to("/transaction/docapproval")->withError("Document not found or alreday approved/rejected!");
        }

        $attachments = DB::table('document_attachments')
            ->where('dcn_number', $documents->dcn_number)
            ->where('doc_version', $version)
            ->get();

        $areas = DB::table('document_affected_areas')
                 ->select('document_affected_areas.dcn_number', 'document_affected_areas.docarea', 'docareas.docarea as docareaname', 'document_affected_areas.doc_version')
                 ->join('docareas', 'document_affected_areas.docarea', '=', 'docareas.id')
                 ->where('dcn_number', $documents->dcn_number)
                 ->where('doc_version', $version)
                 ->get();
        
        $approvalList = DB::table('v_document_approvals_v2')
                    ->where('dcn_number', $documents->dcn_number)
                    ->where('approval_version', $version)
                    ->orderBy('approver_level', 'asc')
                    ->get();

        $docHistory = DB::table('v_document_historys')
                    ->where('dcn_number', $documents->dcn_number)
                    ->where('doc_version', $version)
                    ->orderBy('id', 'desc')
                    ->get();

        $docHistorydateGroup = DB::table('v_document_historys')
                    ->select('dcn_number', 'created_date', 'doc_version')->distinct()    
                    ->orderBy('created_date', 'asc')
                    ->where('dcn_number', $documents->dcn_number)
                    ->where('doc_version', $version)
                    ->orderBy('created_date', 'desc')
                    ->get();

        $isApprovedbyUser = DB::table('v_document_approvals_v2')
                    ->where('dcn_number',  $documents->dcn_number)
                    ->where('approver_id', Auth::user()->id)
                    ->where('approval_version', $version)
                    ->where('doc_version_status', 'Open')
                    ->where('is_active', 'Y')
                    ->where('approval_version', $version)
                    ->where('approval_status', 'N')
                    ->first();

        $docremark = DB::table('document_versions')->where('dcn_number',  $documents->dcn_number)->where('doc_version', $version)->first();
        // return $docHistorydateGroup;
        // return $documents;
        if($isApprovedbyUser){
            return view('transaction.documentapproval.detail', [
                'document'    => $documents, 
                'attachments' => $attachments, 
                'areas'       => $areas, 
                'approvals'   => $approvalList,
                'dochistory'     => $docHistory,
                'dochistorydate' => $docHistorydateGroup,
                'isApprovedbyUser' => $isApprovedbyUser,
                'version'          => $version,
                'docremark'   => $docremark
            ]);   
        }else{
            return Redirect::to("/transaction/docapproval")->withError("Document not found or alreday approved/rejected!");
        }
    }

    public function showFile(Request $request, $dir = 'original', $file = null)
    {
        // $name = $file;
        // $attachment = 'inline';
        // if($request->has('force')){//for force download
        //     $attachment = 'attachment';
        // }
        // if (!empty($file)) {
        //     $fileModels = File::where('file', $file)->get();
        //     if ($fileModels->isNotEmpty()) {
        //         $fileModel = $fileModels[0];
        //         $name = Str::slug($fileModel->document->name). "_" .$fileModel->document->id . "_" . $dir . "_" . Str::slug($fileModel->name);
        //         $name .= "." . last(explode('.', $file));
        //     }
        // }
        // $file = storage_path('app/files/' . $dir . '/') . $file;
        // return response()->file($file, ['Content-disposition' => $attachment.'; filename="' . $name . '"']);
    }

    public function getNextApproval($dcnNum){
        $userLevel = DB::table('document_approvals')
                    ->where('approver_id', Auth::user()->id)
                    ->first();

        $nextApproval = DB::table('document_approvals')
                        ->where('dcn_number', $dcnNum)
                        ->where('approver_level', '>', $userLevel->approver_level)
                        ->orderBy('approver_level', 'ASC')
                        ->first();

        // return $userLevel;
        if($nextApproval){
            return $nextApproval->approver_level;
        }else{
            return null;
        }
    }

    public function approveDocument(Request $req){
        // return $req;
        DB::beginTransaction();
        try{
            $docHistory = array();

            $document = DB::table('documents')->where('dcn_number', $req['dcnNumber'])->first();
            $userAppLevel = DB::table('v_document_approvals_v2')
                            ->select('approver_level')
                            ->where('dcn_number',  $req['dcnNumber'])
                            ->where('approval_version',  $req['version'])
                            ->where('approver_id', Auth::user()->id)
                            ->first();

            DB::table('document_approvals')
            ->where('dcn_number',        $req['dcnNumber'])
            ->where('approval_version',  $req['version'])
            // ->where('approver_id', Auth::user()->id)
            ->where('approver_level',$userAppLevel->approver_level)
            ->update([
                'approval_status' => $req['action'],
                'approval_remark' => $req['approvernote'],
                'approved_by'     => Auth::user()->username,
                'approval_date'   => getLocalDatabaseDateTime()
            ]);

            $nextApprover = $this->getNextApproval($req['dcnNumber']);

            $docStat = '';
            if($req['action'] === "A"){
                $docStat = 'Document Approved';
                if($nextApprover  != null){
                    DB::table('document_approvals')
                    ->where('dcn_number', $req['dcnNumber'])
                    ->where('approval_version',  $req['version'])
                    ->where('approver_level', $nextApprover)
                    ->update([
                        'is_active' => 'Y'
                    ]);
                }
            }elseif($req['action'] === "R"){
                $docStat = 'Document Rejected';
            }

            $insertHistory = array(
                'dcn_number'        => $req['dcnNumber'],
                'activity'          => $docStat,
                'doc_version'       => $req['version'],
                'createdby'         => Auth::user()->email ?? Auth::user()->username,
                'createdon'         => getLocalDatabaseDateTime(),
                'updatedon'         => getLocalDatabaseDateTime()
            );
            array_push($docHistory, $insertHistory);
            insertOrUpdate($docHistory,'document_historys');

            DB::table('documents')->where('dcn_number', $req['dcnNumber'])->update([
                'updated_at' => getLocalDatabaseDateTime()
            ]);

            DB::commit();

            if($nextApprover  != null){
                $mailTo = DB::table('v_workflow_assignments')
                          ->where('workflow_group', $document->workflow_group)
                          ->where('approval_level', $nextApprover)
                          ->pluck('approver_email');
                
                $mailData = [
                            'email'    => 'husnulmub@gmail.com',
                            'docID'    => $document->id,
                            'version'  => $req['version'],
                            'dcnNumb'  => $document->dcn_number,
                            'docTitle' => $document->document_title,
                            'docCrdt'  => formatDate($document->created_at),
                            'docCrby'  => $document->createdby,
                            'body'     => 'This is for testing email using smtp'
                ];
                        
                        // dispatch(new SendEmailJob($mailData));
                Mail::to($mailTo)->queue(new MailNotif($mailData));
            }

            $result = array(
                'msgtype' => '200',
                'message' => 'Success'
            );

            return $result;
        }catch(\Exception $e){
            DB::rollBack();
            // return Redirect::to("/transaction/document")->withError($e->getMessage());
            $result = array(
                'msgtype' => '401',
                'message' => $e->getMessage()
            );

            return $result;
        }
    }

    public function rejectDocument(){

    }
}
