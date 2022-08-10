<?php

namespace App\Http\Controllers\Master;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use DataTables, Auth, DB;
use Validator,Redirect,Response;

class DoclevelController extends Controller
{
    public function index(){
        $data = DB::table('doclevels')->get();
        return view('master.doclevel.index', ['doclevel' => $data]);
        // return "Document Types";
        // return view('master.doctype.index');
    }

    public function save(Request $req){
        DB::beginTransaction();
        try{
            DB::table('doclevels')->insert([
                'doclevel'  => $req['doclevel'],
                'createdon' => date('Y-m-d H:m:s'),
                'createdby' => Auth::user()->email ?? Auth::user()->username
            ]);
            DB::commit();
            return Redirect::to("/master/doclevel")->withSuccess('New Document Level Created');
        } catch(\Exception $e){
            DB::rollBack();
            return Redirect::to("/master/doclevel")->withError($e->getMessage());
        }
    }

    public function update(Request $req){
        DB::beginTransaction();
        try{
            DB::table('doclevels')->where('id', $req['doclevelid'])->update([
                'doclevel'   => $req['doclevel']
            ]);
            DB::commit();
            return Redirect::to("/master/doclevel")->withSuccess('Document Level Updated');
        } catch(\Exception $e){
            DB::rollBack();
            return Redirect::to("/master/doclevel")->withError($e->getMessage());
        }
    }

    public function delete($id){
        DB::beginTransaction();
        try{
            DB::table('doclevels')->where('id', $id)->delete();
            DB::commit();
            return Redirect::to("/master/doclevel")->withSuccess('Document Level Deleted');
        } catch(\Exception $e){
            DB::rollBack();
            return Redirect::to("/master/doclevel")->withError($e->getMessage());
        }
    }
}
