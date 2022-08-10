<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class MenuSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('menugroups')->insert([
            'name'       => 'User',
            'route'      => 'setting/users',
            'menugroup'  => 4,
            'createdby'  => 'Seeder',
        ]);
        DB::table('menugroups')->insert([
            'name'       => 'Menu Groups',
            'route'      => 'setting/menugroups',
            'menugroup'  => 4,
            'createdby'  => 'Seeder',
        ]);
        DB::table('menugroups')->insert([
            'name'       => 'Menu',
            'route'      => 'setting/menus',
            'menugroup'  => 4,
            'createdby'  => 'Seeder',
        ]);
        DB::table('menugroups')->insert([
            'name'       => 'Roles',
            'route'      => 'setting/roles',
            'menugroup'  => 4,
            'createdby'  => 'Seeder',
        ]);
        DB::table('menugroups')->insert([
            'name'       => 'Menu Roles',
            'route'      => 'setting/menuroles',
            'menugroup'  => 4,
            'createdby'  => 'Seeder',
        ]);
        DB::table('menugroups')->insert([
            'name'       => 'User Roles',
            'route'      => 'setting/userroles',
            'menugroup'  => 4,
            'createdby'  => 'Seeder',
        ]);
    }
}
