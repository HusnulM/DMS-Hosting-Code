<?php

namespace App\Http\Controllers\Config;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use DataTables, Auth, DB;
use Validator,Redirect,Response;

class GeneralSettingController extends Controller
{
    public function index(){
        $data = DB::table('general_setting')->where('setting_name', 'COMPANY_LOGO')->first();
        return view('config.generalsetting', ['complogo' => $data]);
    }

    public function save(Request $request){
        DB::beginTransaction();
        try{
            $companyLogo = $request->file('companylogo');
            $filename    = $companyLogo->getClientOriginalName();
            $filepath    = '/files/companylogo/'. $filename;  
            $companyLogo->move(public_path().'/files/companylogo/', $filename);  

            $check = DB::table('general_setting')->where('setting_name', 'COMPANY_LOGO')->first();
            if($check){
                DB::table('general_setting')->where('setting_name', 'COMPANY_LOGO')->update([
                    'setting_value' => $filepath
                ]);
            }else{
                DB::table('general_setting')->insert([
                    'setting_name'  => 'COMPANY_LOGO',
                    'setting_value' => $filepath,
                    'createdby'     => Auth::user()->username,
                    'createdon'     => getLocalDatabaseDateTime()
                ]);
            }
            DB::commit();
            return Redirect::to("/general/setting")->withSuccess('Company Logo Saved!');
        }catch(\Exception $e){
            DB::rollBack();
            return Redirect::to("/general/setting")->withError($e->getMessage());
        }
    }
}
