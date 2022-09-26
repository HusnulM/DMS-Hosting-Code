<?php

namespace App\Http\Controllers\Reports;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Maatwebsite\Excel\Facades\Excel;

use App\Exports\ReportExport;
use DataTables, Auth, DB;
use Validator,Redirect,Response;
use Mail;
use PDF;

class DocumentReportController extends Controller
{
    public function index(){
        $doctypes  = DB::table('doctypes')->get();
        $doclevels = DB::table('doclevels')->get();
        $docareas  = DB::table('docareas')->get();
        return view('reports.documentlist', ['doctypes' => $doctypes, 'doclevels' => $doclevels, 'docareas' => $docareas]);
    }

    public function exportdata(Request $req){
        return Excel::download(new ReportExport($req), 'Document-Reports.xlsx');
        // ->only('dcn_number','doctype','document_number','document_title','doc_version','effectivity_date','established_date','validity_date','createdby','created_at','crtdate')
    }

    public function loadReportDocList(Request $req){
        $params = $req->params;
        

        // $whereClause = $params['sac'];

        $query   = DB::table('v_report_doclist');
        if(count($req->all()) > 0){
            if(isset($req->approvalstat)){
                if($req->approvalstat === "O"){
                    $query->where('version_status', 'Open');
                }elseif($req->approvalstat === "C"){
                    $query->where('version_status', 'Obsolete');                
                }elseif($req->approvalstat === "R"){
                    $query->where('version_status', 'Rejected');                
                }elseif($req->approvalstat === "A"){
                    $query->where('version_status', 'Approved');                
                }
            }
    
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

    public function loadDocVersionDetail(Request $req){
        $data = DB::table('v_document_approvals_v2')
                ->where('docid', $req->docid)
                ->where('approval_version', $req->version)
                ->get();
        return $data;
    }
}
