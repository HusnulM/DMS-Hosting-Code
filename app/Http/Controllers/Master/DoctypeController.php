<?php

namespace App\Http\Controllers\Master;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use DataTables, Auth, DB;
use Validator,Redirect,Response;

class DoctypeController extends Controller
{
    public function index(){
        $data = DB::table('v_doctype_wfgroup')->get();
        $groups = DB::table('workflow_groups')->orderBy('id', 'ASC')->get();
        return view('master.doctype.index', ['doctype' => $data, 'groups' => $groups]);
        // return "Document Types";
        // return view('master.doctype.index');
    }

    public function save(Request $req){
        DB::beginTransaction();
        try{
            DB::table('doctypes')->insert([
                'doctype'   => $req['doctype'],
                'workflow_group' => $req['workflowgoroup'],
                'createdon' => date('Y-m-d H:m:s'),
                'createdby' => Auth::user()->email ?? Auth::user()->username
            ]);
            DB::commit();
            return Redirect::to("/master/doctype")->withSuccess('New Document Type Created');
        } catch(\Exception $e){
            DB::rollBack();
            return Redirect::to("/master/doctype")->withError($e->getMessage());
        }
    }

    public function update(Request $req){
        DB::beginTransaction();
        try{
            if($req['workflowgoroup'] === "X"){
                DB::table('doctypes')->where('id', $req['doctypeid'])->update([
                    'doctype'   => $req['doctype'],
                ]);
            }else{
                DB::table('doctypes')->where('id', $req['doctypeid'])->update([
                    'doctype'   => $req['doctype'],
                    'workflow_group' => $req['workflowgoroup'],
                ]);
            }
            DB::commit();
            return Redirect::to("/master/doctype")->withSuccess('Document Type Updated');
        } catch(\Exception $e){
            DB::rollBack();
            return Redirect::to("/master/doctype")->withError($e->getMessage());
        }
    }

    public function delete($id){
        DB::beginTransaction();
        try{
            DB::table('doctypes')->where('id', $id)->delete();
            DB::commit();
            return Redirect::to("/master/doctype")->withSuccess('Document Type Deleted');
        } catch(\Exception $e){
            DB::rollBack();
            return Redirect::to("/master/doctype")->withError($e->getMessage());
        }
    }
}
