<?php
use Illuminate\Support\Facades\Route;

Route::get('/coba', function () {
    echo "Coba";
});

Route::group(['middleware' => 'auth'], function () {
    Route::group(['prefix' => '/master/doctype'], function () {
        Route::get('/',           'Master\DoctypeController@index')->middleware('checkAuth:master/doctype');
        Route::post('/save',      'Master\DoctypeController@save')->middleware('checkAuth:master/doctype');
        Route::post('/update',    'Master\DoctypeController@update')->middleware('checkAuth:master/doctype');
        Route::get('/delete/{id}','Master\DoctypeController@delete')->middleware('checkAuth:master/doctype');  
    });

    Route::group(['prefix' => '/master/docarea'], function () {
        Route::get('/',           'Master\DocareaController@index')->middleware('checkAuth:master/docarea');  
        Route::post('/save',      'Master\DocareaController@save')->middleware('checkAuth:master/docarea');
        Route::post('/update',    'Master\DocareaController@update')->middleware('checkAuth:master/docarea');
        Route::get('/delete/{id}','Master\DocareaController@delete')->middleware('checkAuth:master/docarea');  
    });

    Route::group(['prefix' => '/master/doclevel'], function () {
        Route::get('/',           'Master\DoclevelController@index')->middleware('checkAuth:master/doclevel');  
        Route::post('/save',      'Master\DoclevelController@save')->middleware('checkAuth:master/doclevel');
        Route::post('/update',    'Master\DoclevelController@update')->middleware('checkAuth:master/doclevel');
        Route::get('/delete/{id}','Master\DoclevelController@delete')->middleware('checkAuth:master/doclevel');  
    });
});