<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateMenurolesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('menuroles', function (Blueprint $table) {
            $table->integer('menuid');
            $table->integer('roleid');
            $table->timestamps();
            $table->string('createdby',50);
            $table->string('updatedby',50);
            $table->primary(['menuid', 'roleid']);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('menuroles');
    }
}
