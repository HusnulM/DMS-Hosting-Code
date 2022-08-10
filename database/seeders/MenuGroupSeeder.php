<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class MenuGroupSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('menugroups')->insert([
            'rolename'   => 'Master Data',
            'rolestatus' => null,
            '_index'     => 1,
            'createdby'  => 'Seeder',
        ]);

        DB::table('menugroups')->insert([
            'rolename'   => 'Documents',
            'rolestatus' => null,
            '_index'     => 2,
            'createdby'  => 'Seeder',
        ]);

        DB::table('menugroups')->insert([
            'rolename'   => 'Approval Document',
            'rolestatus' => null,
            '_index'     => 3,
            'createdby'  => 'Seeder',
        ]);

        DB::table('menugroups')->insert([
            'rolename'   => 'Settings',
            'rolestatus' => null,
            '_index'     => 4,
            'createdby'  => 'Seeder',
        ]);
    }
}
