<?php

namespace App\Http\Controllers\Master;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use DataTables, Auth, DB;
use Validator,Redirect,Response;

class DocareaController extends Controller
{
    public function index(){
        $data = DB::table('docareas')->get();
        return view('master.docarea.index', ['docarea' => $data]);
        // return "Document Types";
        // return view('master.doctype.index');
    }

    public function save(Request $req){
        DB::beginTransaction();
        try{
            DB::table('docareas')->insert([
                'docarea'   => $req['docarea'],
                'mail'      => $req['email'],
                'createdon' => date('Y-m-d H:m:s'),
                'createdby' => Auth::user()->email ?? Auth::user()->username
            ]);
            DB::commit();
            return Redirect::to("/master/docarea")->withSuccess('New Document Areas Created');
        } catch(\Exception $e){
            DB::rollBack();
            return Redirect::to("/master/docarea")->withError($e->getMessage());
        }
    }

    public function update(Request $req){
        DB::beginTransaction();
        try{
            DB::table('docareas')->where('id', $req['docareaid'])->update([
                'docarea'   => $req['docarea'],
                'mail'      => $req['email'],
            ]);
            DB::commit();
            return Redirect::to("/master/docarea")->withSuccess('Document Areas Updated');
        } catch(\Exception $e){
            DB::rollBack();
            return Redirect::to("/master/docarea")->withError($e->getMessage());
        }
    }

    public function delete($id){
        DB::beginTransaction();
        try{
            DB::table('docareas')->where('id', $id)->delete();
            DB::commit();
            return Redirect::to("/master/docarea")->withSuccess('Document Areas Deleted');
        } catch(\Exception $e){
            DB::rollBack();
            return Redirect::to("/master/docarea")->withError($e->getMessage());
        }
    }
}
