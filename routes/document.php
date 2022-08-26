<?php

use Illuminate\Support\Facades\Route;

Route::group(['middleware' => 'auth'], function () {
    Route::group(['prefix' => '/document/v1'], function () {
        Route::get('/',                         'Document\DocumentV1Controller@index')->middleware('checkAuth:document/v1');
        Route::post('/save',                    'Document\DocumentV1Controller@save')->middleware('checkAuth:document/v1');
        Route::post('/savenewversion/{p1}',     'Document\DocumentV1Controller@saveNewDocVersion')->middleware('checkAuth:document/v1');
        Route::post('/updateinfo/{p1}',         'Document\DocumentV1Controller@updatedocinfo')->middleware('checkAuth:document/v1');
        Route::post('/updatearea/{p1}',         'Document\DocumentV1Controller@updatearea')->middleware('checkAuth:document/v1');
        Route::post('/updatefiles/{p1}',        'Document\DocumentV1Controller@updatefiles')->middleware('checkAuth:document/v1');
    });

    Route::group(['prefix' => '/document/v2'], function () {
        Route::get('/',                         'Document\DocumentV2Controller@index')->middleware('checkAuth:document/v2');
        Route::post('/save',                    'Document\DocumentV2Controller@save')->middleware('checkAuth:document/v2');
        Route::post('/savenewversion/{p1}',     'Document\DocumentV2Controller@saveNewDocVersion')->middleware('checkAuth:document/v2');
        Route::post('/updateinfo/{p1}',         'Document\DocumentV2Controller@updatedocinfo')->middleware('checkAuth:document/v2');
        Route::post('/updatearea/{p1}',         'Document\DocumentV2Controller@updatearea')->middleware('checkAuth:document/v2');
        Route::post('/updatefiles/{p1}',        'Document\DocumentV2Controller@updatefiles')->middleware('checkAuth:document/v2');
    });

    Route::group(['prefix' => '/document/v3'], function () {
        Route::get('/',                         'Document\DocumentV3Controller@index')->middleware('checkAuth:document/v3');
        Route::post('/save',                    'Document\DocumentV3Controller@save')->middleware('checkAuth:document/v3');
        Route::post('/savenewversion/{p1}',     'Document\DocumentV3Controller@saveNewDocVersion')->middleware('checkAuth:document/v3');
        Route::post('/updateinfo/{p1}',         'Document\DocumentV3Controller@updatedocinfo')->middleware('checkAuth:document/v3');
        Route::post('/updatearea/{p1}',         'Document\DocumentV3Controller@updatearea')->middleware('checkAuth:document/v3');
        Route::post('/updatefiles/{p1}',        'Document\DocumentV3Controller@updatefiles')->middleware('checkAuth:document/v3');
    });

    Route::group(['prefix' => '/document/v4'], function () {
        Route::get('/',                         'Document\DocumentV4Controller@index')->middleware('checkAuth:document/v4');
        Route::post('/save',                    'Document\DocumentV4Controller@save')->middleware('checkAuth:document/v4');
        Route::post('/savenewversion/{p1}',     'Document\DocumentV4Controller@saveNewDocVersion')->middleware('checkAuth:document/v4');
        Route::post('/updateinfo/{p1}',         'Document\DocumentV4Controller@updatedocinfo')->middleware('checkAuth:document/v4');
        Route::post('/updatearea/{p1}',         'Document\DocumentV4Controller@updatearea')->middleware('checkAuth:document/v4');
        Route::post('/updatefiles/{p1}',        'Document\DocumentV4Controller@updatefiles')->middleware('checkAuth:document/v4');
    });
});