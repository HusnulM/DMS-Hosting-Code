<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateMenugroupsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('menugroups', function (Blueprint $table) {
            $table->id();
            $table->string('menugroup',50);
            $table->string('groupicon',50);
            $table->integer('_index');
            $table->timestamps();
            $table->string('createdby',50);
            $table->string('updatedby',50);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('menugroups');
    }
}
