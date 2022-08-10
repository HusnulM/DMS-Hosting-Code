<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('users')->insert([
            'name'  => 'Administrator',
            'email' => 'sys-admin@gmail.com',
            'username' => 'sys-admin',
            'password' => Hash::make('12345678'),
            'createdby' => 'Seeder',
        ]);
    }
}
