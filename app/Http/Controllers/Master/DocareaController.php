<?php

namespace App\Http\Controllers\Master;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use DataTables, Auth, DB;
use Validator,Redirect,Response;

class DocareaController extends Controller
{
    public function index(){
        $doctype = DB::table('v_doctype_wfgroup')->get();
        $data    = DB::table('docareas')->get();
        
        return view('master.docarea.index', ['doctype' => $doctype, 'docarea' => $data]);
        // return "Document Types";
        // return view('master.doctype.index');
    }

    public function getDocAreaEmail($docarea){
        $email   = DB::table('docarea_emails')->where('docareaid', $docarea)->get();
        return $email;
    }

    public function save(Request $req){
        DB::beginTransaction();
        try{
            $email = $req['email'];

            $docID = DB::table('docareas')->insertGetId([
                'docarea'   => $req['docarea'],
                // 'doctypeid' => $req['doctype'],
                'createdon' => getLocalDatabaseDateTime(),
                'createdby' => Auth::user()->email ?? Auth::user()->username
            ]);

            $insertData = array();
            for($i = 0; $i < sizeof($email); $i++){
                $insertEmail = array(
                    'docareaid'     => $docID,
                    'email'         => $email[$i],
                    'createdon'     => getLocalDatabaseDateTime(),
                    'createdby'     => Auth::user()->email ?? Auth::user()->username
                );
                array_push($insertData, $insertEmail);
            }
            insertOrUpdate($insertData,'docarea_emails');

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

    public function deleteEmail(Request $req){
        DB::beginTransaction();
        try{
            DB::table('docarea_emails')->where('id', $req['docemailid'])->delete();
            DB::commit();
            return response()->json(['success'=>'Document Area Receiver Deleted']);
            // return Redirect::to("/master/docarea")->withSuccess('Document Email Deleted');
        } catch(\Exception $e){
            DB::rollBack();
            return response()->json(['error'=>$e->getMessage()]);
            // return Redirect::to("/master/docarea")->withError($e->getMessage());
        }
    }
}
