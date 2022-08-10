<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class MenuRoleSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('menugroups')->insert([
            'menuid'     => '1',
            'roleid'     => '1',
            'createdby'  => 'Seeder',
        ]);
        DB::table('menugroups')->insert([
            'menuid'     => '2',
            'roleid'     => '1',
            'createdby'  => 'Seeder',
        ]);
        DB::table('menugroups')->insert([
            'menuid'     => '3',
            'roleid'     => '1',
            'createdby'  => 'Seeder',
        ]);
        DB::table('menugroups')->insert([
            'menuid'     => '4',
            'roleid'     => '1',
            'createdby'  => 'Seeder',
        ]);
        DB::table('menugroups')->insert([
            'menuid'     => '5',
            'roleid'     => '1',
            'createdby'  => 'Seeder',
        ]);
        DB::table('menugroups')->insert([
            'menuid'     => '6',
            'roleid'     => '1',
            'createdby'  => 'Seeder',
        ]);
    }
}
