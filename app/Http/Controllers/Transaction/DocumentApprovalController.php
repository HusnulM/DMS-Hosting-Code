<?php

namespace App\Http\Controllers\Transaction;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Barryvdh\DomPDF\Facade as PDF;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Str;
use Intervention\Image\Facades\Image;

use DataTables, Auth, DB;
use Validator,Redirect,Response;

class DocumentApprovalController extends Controller
{
    public function index(){
        // return getLocalDatabaseDateTime();
        $documents  = DB::table('v_document_approvals')
                      ->where('approver_id', Auth::user()->id)
                    //   ->where('approval_status', 'N')
                      ->where('is_active', 'Y')
                      ->orderBy('created_at', 'DESC')
                      ->get();
        return view('transaction.documentapproval.index', ['documents' => $documents]);
    }

    public function approveDetail($id){
        $documents  = DB::table('v_documents')
                      ->where('id', $id)
                      ->first();

        $attachments = DB::table('document_attachments')->where('dcn_number', $documents->dcn_number)->get();

        $areas = DB::table('document_affected_areas')
                 ->select('document_affected_areas.dcn_number', 'document_affected_areas.docarea', 'docareas.docarea as docareaname')
                 ->join('docareas', 'document_affected_areas.docarea', '=', 'docareas.id')
                 ->where('dcn_number', $documents->dcn_number)
                 ->get();
        
        $approvalList = DB::table('v_document_approvals')
                    ->where('dcn_number', $documents->dcn_number)
                    ->orderBy('approver_level', 'asc')
                    ->get();

        $docHistory = DB::table('v_document_historys')->where('dcn_number', $documents->dcn_number)->get();

        $docHistorydateGroup = DB::table('v_document_historys')
                ->select('dcn_number', 'created_date')->distinct()    
                ->orderBy('created_date', 'asc')
                ->where('dcn_number', $documents->dcn_number)->get();

        $isApprovedbyUser = DB::table('document_approvals')
                ->where('dcn_number',  $documents->dcn_number)
                ->where('approver_id', Auth::user()->id)
                ->first();
        // return $docHistorydateGroup;
        // return $documents;
        return view('transaction.documentapproval.detail', [
            'document'    => $documents, 
            'attachments' => $attachments, 
            'areas'       => $areas, 
            'approvals'   => $approvalList,
            'dochistory'     => $docHistory,
            'dochistorydate' => $docHistorydateGroup,
            'isApprovedbyUser' => $isApprovedbyUser
        ]);   
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

            DB::table('document_approvals')
            ->where('dcn_number',  $req['dcnNumber'])
            ->where('approver_id', Auth::user()->id)
            ->update([
                'approval_status' => $req['action'],
                'approval_remark' => $req['approvernote'],
                'approval_date'   => getLocalDatabaseDateTime()
            ]);

            $docStat = '';
            if($req['action'] === "A"){
                $docStat = 'Document Approved';
                $nextApprover = $this->getNextApproval($req['dcnNumber']);
                if($nextApprover  != null){
                    DB::table('document_approvals')
                    ->where('dcn_number', $req['dcnNumber'])
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
