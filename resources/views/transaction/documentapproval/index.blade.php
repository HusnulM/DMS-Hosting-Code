@extends('layouts/App')

@section('title', 'Document Approval')

@section('additional-css')
    <!-- <link rel="stylesheet" href="http://localhost:8181/digidocu/css/lte/AdminLTE.min.css"> -->
    <link rel="stylesheet" href="{{ ('/assets/css/customstyle.css') }}">
@endsection

@section('content')
<div class="container-fluid">
    <div class="row">
        <div class="col-lg-12">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Document Approval List</h3>
                    <!-- <div class="card-tools">
                        <button type="submit" class="btn btn-primary btn-sm">
                            <i class="fas fa-save"></i> SAVE
                        </button>
                    </div> -->
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-lg-3">
                            <label for="">From Date</label>
                            <input type="date" class="form-control" name="datefrom" id="datefrom">
                        </div>
                        <div class="col-lg-3">
                            <label for="">To Date</label>
                            <input type="date" class="form-control" name="dateto" id="dateto">
                        </div>
                        <div class="col-lg-3">
                            <br>
                            <button type="button" class="btn btn-default mt-2"> 
                                <i class="fa fa-search"></i> Filter
                            </button>
                        </div>
                    </div>
                    <hr>
                    <div class="row">
                        @foreach($documents as $docs)
                        <a href="{{ url('/transaction/docapproval/approve/detail') }}/{{ $docs->docid }}">
                            <div class="col-lg-3 col-md-6 col-sm-12 m-t-20" style="cursor:pointer;">
                                <div class="doc-box box box-widget widget-user-2">
                                    <div class="widget-user-header bg-gray bg-folder-shaper no-padding">
                                        <div class="folder-shape-top bg-gray">
                                            <!-- <i class="fa fa-folder text-yellow" style="margin-left:12px;"></i> -->
                                        </div>
                                        <div class="box-header">
                                            <!-- <a href="#" style="color: black;">
                                                <h3 class="box-title"><i class="fa fa-folder text-yellow"></i></h3>
                                            </a> -->
                                            <span style="margin-left: 10px; color:white;" data-toggle="tooltip" title="{{ $docs->doctype }}">
                                                {{ $docs->doctype }}
                                            </span>
                                        </div>
                                        <a href="{{ url('/transaction/docapproval/approve/detail') }}/{{ $docs->docid }}" style="color: black;">
                                            <h4 style="color: white; font-weight:bold;" class="widget-user-username" title="{{ $docs->document_title }}" data-toggle="tooltip">
                                                {{ $docs->document_title }}
                                            </h4>
                                            <h5 class="widget-user-desc" style="font-size: 12px">
                                                <span class="time" data-toggle="tooltip" title="{{ $docs->dcn_number }}">
                                                {{ $docs->dcn_number }}
                                                </span>
                                                <span class="pull-right" style="margin-right: 15px;">
                                                    <i class="fa fa-folder text-yellow" style="font-size:20px;"></i>
                                                    <!-- <i title="Unverified" data-toggle="tooltip" class="fa fa-check-circle" style="color: #0e3bcf; font-size:20px;"></i> -->
                                                </span>
                                            </h5>
                                            <hr style="background-color:white;">
                                            <h5 class="widget-user-desc" style="font-size: 12px">
                                                <span class="time" data-toggle="tooltip" title="{{ $docs->createdby }}">
                                                    {{ $docs->createdby }}
                                                </span>
                                                <span class="pull-right" style="margin-right: 15px;" data-toggle="tooltip" title="{{ $docs->created_at }}">
                                                    <i class="fa fa-clock"></i> {{\Carbon\Carbon::parse($docs->created_at)->diffForHumans()}}
                                                </span>
                                            </h5>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </a>
                        @endforeach
                    </div>

                    
                </div>
            </div>   
        </div>
    </div>
</div>
@endsection