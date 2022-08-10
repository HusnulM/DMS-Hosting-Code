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

    public function userlist(Request $request){
        $params = $request->params;        
        $whereClause = $params['sac'];
        $query = DB::table('users')->orderBy('id');
        return DataTables::queryBuilder($query)->toJson();
    }
}
