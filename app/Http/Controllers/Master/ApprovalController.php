<?php

namespace App\Http\Controllers\Master;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

use DataTables, Auth, DB;
use Validator,Redirect,Response;

class ApprovalController extends Controller
{
    public function index(){
        return view('master.approval.index');
    }

    public function approvallist(Request $request){
        // $params = $request->params;        
        // $whereClause = $params['sac'];
        $query = DB::table('v_usermenus')->orderBy('menugroup');
        return DataTables::queryBuilder($query)->toJson();
    }
}
