<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class UserRoleSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('menugroups')->insert([
            'userid'     => '1',
            'roleid'     => '1',
            'createdby'  => 'Seeder',
        ]);
    }
}
