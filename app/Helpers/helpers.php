<?php

use Illuminate\Support\Facades\DB;


function userMenu(){
    $mnGroups = DB::table('v_usermenus')
                ->select('menugroup', 'groupname', 'groupicon','group_idx')
                ->distinct()
                ->where('userid', Auth::user()->id)
                ->orderBy('group_idx','ASC')
                ->get();
    return $mnGroups;
}

function userSubMenu(){
    $mnGroups = DB::table('v_usermenus')
                ->select('menugroup', 'route', 'menu_desc','menu_idx')
                ->distinct()
                ->where('userid', Auth::user()->id)
                ->orderBy('menu_idx','ASC')
                ->get();
    return $mnGroups;
}

function getLocalDatabaseDateTime(){
    // SELECT now()
    $localDateTime = DB::select('SELECT fGetDatabaseLocalDatetime() as lcldate');
    return $localDateTime[0]->lcldate;
}

function formatDate($date, $format = "d-m-Y")
{
    if (is_null($date)) {
        return '-';
    }
    return date($format, strtotime($date));
}

function formatDateTime($dateTime, $format = "d-m-Y h:i A")
{
    if (is_null($dateTime)) {
        return '-';
    }
    return ($dateTime) ? date($format, strtotime($dateTime)) : $dateTime;
}

function generateDcnNumber($doctype){
    $dcnNumber = '';
    $prefix    = '';
    if($doctype === 'WS' || $doctype === 'WI'){
        $prefix = 'KEPI-';
    }else{
        $prefix = 'DCN-';
    }
    $getdata = DB::table('dcn_nriv')->where('year', date('Y'))->where('object',$doctype)->first();
    if($getdata){
        DB::beginTransaction();
        try{
            $leadingZero = '';
            if(strlen($getdata->current_number) == 5){
                $leadingZero = '0';
            }elseif(strlen($getdata->current_number) == 4){
                $leadingZero = '00';
            }elseif(strlen($getdata->current_number) == 3){
                $leadingZero = '000';
            }elseif(strlen($getdata->current_number) == 2){
                $leadingZero = '0000';
            }elseif(strlen($getdata->current_number) == 1){
                $leadingZero = '00000';
            }

            $lastnum = ($getdata->current_number*1) + 1;

            if($leadingZero == ''){
                $dcnNumber = $prefix . $doctype . '-' . substr($getdata->year,2) .'-'. $lastnum; 
            }else{
                $dcnNumber = $prefix . $doctype . '-' . substr($getdata->year,2) .'-'. $leadingZero . $lastnum; 
            }

            DB::table('dcn_nriv')->where('year',$getdata->year)->where('object',$doctype)->update([
                'current_number' => $lastnum
            ]);

            DB::commit();
            return $dcnNumber;
        }catch(\Exception $e){
            DB::rollBack();
            return null;
        }
    }else{
        $dcnNumber = $prefix . $doctype . '-' .substr(date('Y'),2).'-000001';
        DB::beginTransaction();
        try{
            DB::table('dcn_nriv')->insert([
                'year'            => date('Y'),
                'object'          => $doctype,
                'current_number'  => '1',
                'createdon'       => date('Y-m-d H:m:s'),
                'createdby'       => Auth::user()->email ?? Auth::user()->username
            ]);
            DB::commit();
            return $dcnNumber;
        }catch(\Exception $e){
            DB::rollBack();
            return null;
        }
    }
    
}

function getWfGroup($doctype){

    $wfgroup = DB::table('doctypes')->where('id', $doctype)->first();
    if($wfgroup){
        return $wfgroup->workflow_group;
    }else{
        return 0;
    }
}

function groupOpen($groupid){
    $routeName = \Route::current()->uri();
    $selectMenu = DB::table('menus')->where('route', $routeName)->first();
    if($selectMenu){
        return $groupid == $selectMenu->menugroup ? 'menu-open' : '';
    }
    // return request()->is("*".$groupname."*") ? 'menu-open' : '';
}

function currentURL(){
    $routeName = \Route::current()->uri();
    $selectMenu = DB::table('menus')->where('route', $routeName)->first();
    if($selectMenu){

    }
    dd(\Route::current()->uri());
}

function active($partialUrl){
    // return $partialUrl;
    return request()->is("*".$partialUrl."*") ? 'active' : '';
}

function insertOrUpdate(array $rows, $table){
    $first = reset($rows);

    $columns = implode(
        ',',
        array_map(function ($value) {
            return "$value";
        }, array_keys($first))
    );

    $values = implode(',', array_map(function ($row) {
            return '('.implode(
                ',',
                array_map(function ($value) {
                    return '"'.str_replace('"', '""', $value).'"';
                }, $row)
            ).')';
    }, $rows));

    $updates = implode(
        ',',
        array_map(function ($value) {
            return "$value = VALUES($value)";
        }, array_keys($first))
    );

    $sql = "INSERT INTO {$table}({$columns}) VALUES {$values} ON DUPLICATE KEY UPDATE {$updates}";

    return \DB::statement($sql);
}

function userAllowDownloadDocument(){
    $checkData = DB::table('user_object_auth')
                ->where('userid', Auth::user()->id)
                ->where('object_name', 'ALLOW_DOWNLOAD_DOC')
                ->first();
    if($checkData){
        if($checkData->object_val === "Y"){
            return 1;
        }else{
            return 0;
        }
    }else{
        return 0;
    }
}

function userAllowChangeDocument(){
    $checkData = DB::table('user_object_auth')
                ->where('userid', Auth::user()->id)
                ->where('object_name', 'ALLOW_CHANGE_DOC')
                ->first();
    if($checkData){
        if($checkData->object_val === "Y"){
            return 1;
        }else{
            return 0;
        }
    }else{
        return 0;
    }
}

function checkIsLocalhost(){
    if(request()->getHost() == "localhost"){
        return 1;
    }else{
        return 0;
    }
}

function getbaseurl(){
    $baseurl = env('APP_BASEURL');
    return $baseurl;
}

function allowUplodOrginalDoc(){
    $checkData = DB::table('user_object_auth')
    ->where('userid', Auth::user()->id)
    ->where('object_name', 'ALLOW_UPLOAD_ORIGINAL_DOC')
    ->first();
    if($checkData){
        if($checkData->object_val === "Y"){
            return 1;
        }else{
            return 0;
        }
    }else{
        return 0;
    }
}

function allowDownloadOrginalDoc(){
    $checkData = DB::table('user_object_auth')
    ->where('userid', Auth::user()->id)
    ->where('object_name', 'ALLOW_DOWNLOAD_ORIGINAL_DOC')
    ->first();
    if($checkData){
        if($checkData->object_val === "Y"){
            return 1;
        }else{
            return 0;
        }
    }else{
        return 0;
    }
}

function apiIpdApp(){
    $ipdapi    = DB::table('general_setting')->where('setting_name', 'IPD_MODEL_API')->first();
    return $ipdapi->setting_value;
}