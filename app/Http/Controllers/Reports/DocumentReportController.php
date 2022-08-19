<?php

namespace App\Http\Controllers\Reports;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

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

    public function loadReportDocList(Request $req){
        $params = $req->params;
        

        // $whereClause = $params['sac'];

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
}
