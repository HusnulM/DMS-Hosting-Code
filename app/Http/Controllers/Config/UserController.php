<?php

namespace App\Http\Controllers\Config;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use DataTables, Auth, DB;
use Validator,Redirect,Response;

class UserController extends Controller
{
    public function index(){
        return view('config.users.index');
    }

    public function create(){
        return view('config.users.create');
    }

    public function objectauth($userid){
        $datauser = DB::table('users')->where('id', $userid)->first();
        $objauth  = DB::table('object_auth')->get();
        $uobjauth = DB::table('v_user_obj_auth')->where('userid', $userid)->get();
        return view('config.users.objectauth', ['datauser' => $datauser, 'objauth' => $objauth, 'uobjauth' => $uobjauth]); 
    }

    public function edit($id){
        $data = DB::table('users')->where('id', $id)->first();
        return view('config.users.edit', ['datauser' => $data]);
    }

    public function save(Request $request){
        $validated = $request->validate([
            'email'    => 'required|unique:users|max:255',
            'name'     => 'required',
            'username' => 'required',
            'password' => 'required',
        ]);

        $options = [
            'cost' => 12,
        ];
        $password = password_hash($request['password'], PASSWORD_BCRYPT, $options);

        $output = array();

        DB::beginTransaction();
        try{
            DB::table('users')->insert([
                'name'        => $request['name'],
                'email'       => $request['email'],
                'username'    => $request['username'],
                'password'    => $password,
                'created_at'  => date('Y-m-d H:m:s'),
                'createdby'   => Auth::user()->email ?? Auth::user()->username
            ]);

            DB::commit();
            return Redirect::to("/config/users")->withSuccess('New user created');
        }catch(\Exception $e){
            DB::rollBack();
            return Redirect::to("/config/users")->withError($e->getMessage());
        }
    }

    public function update(Request $request){
        $validated = $request->validate([
            'email'    => 'required|max:255',
            'name'     => 'required',
            'username' => 'required',
        ]);

        
        DB::beginTransaction();
        try{
            if(isset($request['password'])){
                $options = [
                    'cost' => 12,
                ];
                $password = password_hash($request['password'], PASSWORD_BCRYPT, $options);
        
                $output = array();
    
                DB::table('users')->where('id',$request['iduser'])->update([
                    'name'        => $request['name'],
                    'email'       => $request['email'],
                    'username'    => $request['username'],
                    'password'    => $password
                ]);
            }else{
                DB::table('users')->where('id',$request['iduser'])->update([
                    'name'        => $request['name'],
                    'email'       => $request['email'],
                    'username'    => $request['username']
                ]);
            }
            
            DB::commit();
            return Redirect::to("/config/users")->withSuccess('User updated');
        }catch(\Exception $e){
            DB::rollBack();
            return Redirect::to("/config/users")->withError($e->getMessage());
        }
    }

    public function saveObjectauth(Request $req){
        DB::beginTransaction();
        try{
            $objname  = $req['objauth'];
            $objval   = $req['objval'];

            $insertData = array();
            for($i = 0; $i < sizeof($objname); $i++){
                $menus = array(
                    'userid'        => $req['userid'],
                    'object_name'   => $objname[$i],
                    'object_val'    => $objval[$i],
                    'createdon'     => date('Y-m-d H:m:s'),
                    'createdby'     => Auth::user()->username ?? Auth::user()->email
                );
                array_push($insertData, $menus);
            }
            insertOrUpdate($insertData,'user_object_auth');
            DB::commit();

            // DB::table('user_object_auth')->where('id', $id)->delete();

            DB::commit();
            return Redirect::to("/config/users/objectauth/".$req['userid'])->withSuccess('User Object Authorization Added');
        }catch(\Exception $e){
            DB::rollBack();
            return Redirect::to("/config/users/objectauth/".$req['userid'])->withError($e->getMessage());
        }
    }

    public function delete($id){
        DB::beginTransaction();
        try{
            DB::table('users')->where('id', $id)->delete();

            DB::commit();
            return Redirect::to("/config/users")->withSuccess('User deleted');
        }catch(\Exception $e){
            DB::rollBack();
            return Redirect::to("/config/users")->withError($e->getMessage());
        }
    }

    public function deleteObjectauth($uid, $objname){
        DB::beginTransaction();
        try{
            DB::table('user_object_auth')
            ->where('userid', $uid)
            ->where('object_name', $objname)
            ->delete();

            DB::commit();
            return Redirect::to("/config/users/objectauth/".$uid)->withSuccess('User Object Authorization deleted');
        }catch(\Exception $e){
            DB::rollBack();
            return Redirect::to("/config/users/objectauth/".$uid)->withError($e->getMessage());
        }
    }

    public function userlist(Request $request){
        $params = $request->params;        
        $whereClause = $params['sac'];
        $query = DB::table('users')->orderBy('id');
        return DataTables::queryBuilder($query)->toJson();
    }
}
