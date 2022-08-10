<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/tes', function () {
    return "tes";
});

Route::group(['middleware' => 'guest'], function(){
    Route::group(['middleware' => 'revalidate'], function () {
        Route::get('/',              'HomeController@index')->name('login');
        Route::post('authenticate',  'HomeController@login');
    });
});

Route::group(['middleware' => 'auth'], function () {
    Route::group(['middleware' => 'revalidate'], function () {
        Route::get('/dashboard', 'HomeController@dashboard');
        Route::post('logout',    'HomeController@logout')->name('logout');
        Route::get('logout2',    'HomeController@logout')->name('logout');
    });

    Route::group(['prefix' => '/transaction/document'], function () {
        Route::get('/',             'Transaction\DocumentController@index')->middleware('checkAuth:transaction/document');
        Route::post('/save',        'Transaction\DocumentController@save')->middleware('checkAuth:transaction/document');
        Route::post('/updateinfo/{p1}',         'Transaction\DocumentController@updatedocinfo')->middleware('checkAuth:transaction/document');
        Route::post('/updatearea/{p1}',         'Transaction\DocumentController@updatearea')->middleware('checkAuth:transaction/document');
        Route::post('/updatefiles/{p1}',        'Transaction\DocumentController@updatefiles')->middleware('checkAuth:transaction/document');
    });

    Route::group(['prefix' => '/transaction/doclist'], function () {
        Route::get('/',             'Transaction\DocumentController@documentlist')->middleware('checkAuth:transaction/doclist');
        Route::get('/detail/{p1}',  'Transaction\DocumentController@documentDetail')->middleware('checkAuth:transaction/doclist');
    });

    Route::group(['prefix' => '/transaction/docapproval'], function () {
        Route::get('/',                     'Transaction\DocumentApprovalController@index')->middleware('checkAuth:transaction/docapproval');
        Route::get('/approve/detail/{id}',  'Transaction\DocumentApprovalController@approveDetail')->middleware('checkAuth:transaction/docapproval');
        Route::post('/approve',             'Transaction\DocumentApprovalController@approveDocument')->middleware('checkAuth:transaction/docapproval');
        Route::post('/reject',              'Transaction\DocumentApprovalController@rejectDocument')->middleware('checkAuth:transaction/docapproval');

        // transaction/documentlist
        
        Route::get('/getNextApproval/{p1}',     'Transaction\DocumentApprovalController@getNextApproval')->middleware('checkAuth:transaction/docapproval');
    });

    Route::get('/_files/{dir?}/{file?}',    'Transaction\DocumentApprovalController@showFile')->name('files.showfile');

    // Route::group(['prefix' => '/config/users'], function () {
    //     Route::get('/',                       'Config\UserController@index')->middleware('checkAuth:config/users');
    //     Route::get('/create',                 'Config\UserController@create')->middleware('checkAuth:config/users');
    //     Route::get('/edit/{id}',              'Config\UserController@edit')->middleware('checkAuth:config/users');

    //     Route::post('/save',                  'Config\UserController@save')->middleware('checkAuth:config/users');
    //     Route::post('/update',                'Config\UserController@update')->middleware('checkAuth:config/users');
    //     Route::get('/delete/{id}',            'Config\UserController@delete')->middleware('checkAuth:config/users');
    //     Route::get('/userlist',               'Config\UserController@userlist')->middleware('checkAuth:config/users');
    // });

    // Route::group(['prefix' => '/config/roles'], function () {
    //     Route::get('/',                       'Config\RolesController@index')->middleware('checkAuth:config/roles');
    //     Route::get('/create',                 'Config\RolesController@create')->middleware('checkAuth:config/roles');
    //     Route::get('/assignment/{id}',        'Config\RolesController@assignment')->middleware('checkAuth:config/roles');

    //     Route::post('/save',                  'Config\RolesController@save')->middleware('checkAuth:config/roles');
    //     Route::post('/update',                'Config\RolesController@update')->middleware('checkAuth:config/roles');
    //     Route::get('/delete/{id}',            'Config\RolesController@delete')->middleware('checkAuth:config/roles');
    //     Route::get('/rolelist',               'Config\RolesController@rolelist')->middleware('checkAuth:config/roles');
    //     Route::get('/userroles/{p1}',         'Config\RolesController@userroles')->middleware('checkAuth:config/roles');
    //     Route::get('/rolemenus/{p1}',         'Config\RolesController@rolemenus')->middleware('checkAuth:config/roles');
    //     Route::get('/listuser/{p1}',          'Config\RolesController@dataadduser')->middleware('checkAuth:config/roles');
    //     Route::get('/listmenu/{p1}',          'Config\RolesController@dataaddmenu')->middleware('checkAuth:config/roles');
    //     Route::post('/saveroleuser',          'Config\RolesController@saveroleuser')->middleware('checkAuth:config/roles');
    //     Route::post('/saverolemenu',          'Config\RolesController@saverolemenu')->middleware('checkAuth:config/roles');

    //     Route::post('/deletemenuassignment',  'Config\RolesController@deleteMenuAssignment')->middleware('checkAuth:config/roles');
    //     Route::post('/deleteuserassignment',  'Config\RolesController@deleteUserAssignment')->middleware('checkAuth:config/roles');
    // });

    // Route::group(['prefix' => '/config/menus'], function () {
    //     Route::get('/',                       'Config\MenusController@index')->middleware('checkAuth:config/menus');
    //     Route::post('/savemenu',              'Config\MenusController@saveMenus')->middleware('checkAuth:config/menus');
    //     Route::post('/savegroup',             'Config\MenusController@saveGroup')->middleware('checkAuth:config/menus');
    //     Route::post('/updatemenu',            'Config\MenusController@updateMenu')->middleware('checkAuth:config/menus');
    //     Route::post('/updategroup',           'Config\MenusController@updateGroup')->middleware('checkAuth:config/menus');
    //     Route::get('/deletemenu/{id}',        'Config\MenusController@deleteMenu')->middleware('checkAuth:config/menus');
    //     Route::get('/deletegroup/{id}',       'Config\MenusController@deleteGroup')->middleware('checkAuth:config/menus');
    // });

    // Route::group(['prefix' => '/config/approval'], function () {
    //     Route::get('/',         'Master\ApprovalController@index')->middleware('checkAuth:config/approval');
    // });
});
