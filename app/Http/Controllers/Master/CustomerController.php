<?php

namespace App\Http\Controllers\Master;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use DataTables, Auth, DB;
use Validator, Redirect, Response;

class CustomerController extends Controller
{
    public function index(){
        return view('master.customer.index');
    }

    public function save(Request $req){
        DB::beginTransaction();
        try{
            $custname = $req['custname'];

            $insertData = array();
            for($i = 0; $i < sizeof($custname); $i++){
                $insertCust = array(
                    'customer_name' => $custname[$i],
                    'createdon'     => getLocalDatabaseDateTime(),
                    'createdby'     => Auth::user()->email ?? Auth::user()->username
                );
                array_push($insertData, $insertCust);
            }
            insertOrUpdate($insertData,'customers');

            DB::commit();
            return Redirect::to("/master/customer")->withSuccess('New Customer Created');
        } catch(\Exception $e){
            DB::rollBack();
            return Redirect::to("/master/customer")->withError($e->getMessage());
        }
    }

    public function update(Request $req){
        DB::beginTransaction();
        try{
            DB::table('customers')->where('customerid', $req['custid'])->update([
                'customer_name' => $req['custname']
            ]);

            DB::commit();
            return Redirect::to("/master/customer")->withSuccess('Customer Master Updated');
        } catch(\Exception $e){
            DB::rollBack();
            return Redirect::to("/master/customer")->withError($e->getMessage());
        }
    }

    public function delete($id){
        DB::beginTransaction();
        try{
            DB::table('customers')->where('customerid', $id)->delete();

            DB::commit();
            return Redirect::to("/master/customer")->withSuccess('Customer Master Deleted');
        } catch(\Exception $e){
            DB::rollBack();
            return Redirect::to("/master/customer")->withError($e->getMessage());
        }
    }

    public function customerlist(Request $req){
        $query = DB::table('customers');
        return DataTables::queryBuilder($query)->toJson();
    }

    public function findcustomer(Request $request){
        // $url    = parse_url($_SERVER['REQUEST_URI']);
        // $search = $url['query'];
        // $search = str_replace("searchName=","",$search);

        $query['data'] = DB::table('customers')->where('customer_name', 'like', '%'. $request->search . '%')->get();

        // return \Response::json($query);
        return $query;
        // return $this->successResponse('OK', $query);
    }
}
