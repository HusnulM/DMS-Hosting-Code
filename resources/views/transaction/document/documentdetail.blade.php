@extends('layouts/App')

@section('title', 'Document Detail')

@section('additional-css')
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="{{ ('/assets/css/customstyle.css') }}">
    <style type="text/css">
        .select2-container {
            display: block
        }

        .select2-container .select2-selection--single {
            height: 36px;
        }
    </style>
@endsection

@section('content')
<div class="container-fluid">
    <div class="row">
        <div class="col-lg-3">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Document Version</h3>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-lg-12" style="overflow-y: auto; height:560px;">
                            @foreach($docversions as $key => $row)
                            <div class="col-lg-12 col-md-12 col-sm-12 m-t-10" style="cursor:pointer;">
                                <div class="doc-box box box-widget widget-user-2">
                                    <div class="widget-user-header bg-gray bg-folder-shaper no-padding" style="border-top-left-radius: 20px !important;">
                                        
                                        <div class="box-header">
                                            <span style="margin-left: 10px; color:white;" data-toggle="tooltip" title="{{ $row->doc_version }}">
                                                Version : {{ $row->doc_version }}
                                            </span>
                                        </div>
                                        <h4 style="color: white; font-weight:bold;" class="widget-user-username" title="{{ $documents->document_title }}" data-toggle="tooltip">
                                            {{ $documents->document_title }}
                                        </h4>
                                        <h5 class="widget-user-desc" style="font-size: 12px">
                                            <span class="time" data-toggle="tooltip" title="{{ $row->dcn_number }}">
                                            {{ $row->dcn_number }}
                                            </span>
                                            <span class="pull-right" style="margin-right: 15px;">
                                                <i class="fa fa-folder text-yellow" style="font-size:20px;"></i>
                                            </span>
                                        </h5>
                                        <hr style="background-color:white;">
                                        <h5 class="widget-user-desc" style="font-size: 12px">
                                            <span class="time" data-toggle="tooltip" title="{{ $row->createdby }}">
                                                {{ $row->createdby }}
                                            </span>
                                            <span class="pull-right" style="margin-right: 15px;" data-toggle="tooltip" title="{{ $row->createdon }}">
                                                <i class="fa fa-clock"></i> {{\Carbon\Carbon::parse($row->createdon)->diffForHumans()}}
                                            </span>
                                        </h5>
                                    </div>
                                </div>
                            </div>
                            @endforeach
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-9">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Document Detail</h3>
                    <div class="card-tools">
                        <a href="{{ url('/transaction/doclist') }}" class="btn btn-default">
                            <i class="fa fa-arrow-left"></i> Back
                        </a>
                    </div>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-lg-12">
                            <ul class="nav nav-tabs" id="custom-content-above-tab" role="tablist">
                                <li class="nav-item">
                                    <a class="nav-link active" id="custom-content-above-home-tab" data-toggle="pill" href="#custom-content-above-home" role="tab" aria-controls="custom-content-above-home" aria-selected="true">Document Info</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="custom-content-above-profile-tab" data-toggle="pill" href="#custom-content-above-profile" role="tab" aria-controls="custom-content-above-profile" aria-selected="false">Document Affected Area</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="custom-content-above-approval-tab" data-toggle="pill" href="#custom-content-above-approval" role="tab" aria-controls="custom-content-above-approval" aria-selected="false">Files</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="custom-content-above-history-tab" data-toggle="pill" href="#custom-content-above-history" role="tab" aria-controls="custom-content-above-history" aria-selected="false">Document History</a>
                                </li>
                            </ul>
                        </div>
                        <div class="col-lg-12">
                            <br>
                            <div class="tab-content" id="custom-content-above-tabContent">
                                <div class="tab-pane fade show active" id="custom-content-above-home" role="tabpanel" aria-labelledby="custom-content-above-home-tab">
                                    <form action="{{ url('transaction/document/updateinfo') }}/{{ $documents->id }}" method="post" enctype="multipart/form-data">
                                        @csrf
                                        <div class="row">
                                            <div class="col-lg-6">
                                                <div class="row">
                                                    <div class="col-lg-12 col-sm-12 form-group">
                                                        <label for="doctitle">Document Title</label>
                                                        <input type="text" class="form-control" name="doctitle" id="doctitle" placeholder="Document Title" value="{{ $documents->document_title }}" required>
                                                    </div>   
                                                    <div class="col-lg-6 col-sm-12 form-group">
                                                        <label for="doctype">Document Type</label>
                                                        <select name="doctype" id="doctype" class="form-control">
                                                            <option value="{{ $cdoctype->id }}"> {{ $cdoctype->doctype }} </option>
                                                            <!-- @foreach($doctypes as $key => $row)
                                                                <option value="{{ $row->id }}">{{ $row->doctype }}</option>
                                                            @endforeach -->
                                                        </select>
                                                    </div>    
                                                    <div class="col-lg-6 col-sm-12 form-group">
                                                        <label for="doclevel">Document Level</label>
                                                        <select name="doclevel" id="doclevel" class="form-control">
                                                            <option value="{{ $cdoclevel->id }}"> {{ $cdoclevel->doclevel }} </option>
                                                            @foreach($doclevels as $key => $row)
                                                                <option value="{{ $row->id }}">{{ $row->doclevel }}</option>
                                                            @endforeach
                                                        </select>
                                                    </div>
                                                    <div class="col-lg-6 col-sm-12 form-group">
                                                        <label for="effectivedate">Effectivity Date</label>
                                                        <input type="date" name="effectivedate" class="form-control" value="{{ $documents->effectivity_date }}" required>
                                                    </div>
                                                    <div class="col-lg-6 col-sm-12 form-group">
                                                        <label for="docnumber">Document Number</label>
                                                        <input type="text" name="docnumber" class="form-control" value="{{ $documents->document_number }}">
                                                    </div>
                                                </div>
                                            </div>      
                                            <div class="col-lg-6">
                                                <div class="form-group">
                                                    <label for="docremark">Document Remark</label>
                                                    <textarea class="docremark form-control" name="docremark">
                                                        {!! $documents->description !!}
                                                    </textarea>
                                                </div>   
                                            </div>
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <button class="btn btn-primary btn-sm">
                                                        <i class="fa fa-edit"></i> Update Document Info
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                <div class="tab-pane fade" id="custom-content-above-profile" role="tabpanel" aria-labelledby="custom-content-above-profile-tab">
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <h5>Document Area</h5>
                                            <form action="{{ url('transaction/document/updatearea') }}/{{ $documents->id }}" method="post" enctype="multipart/form-data">
                                                @csrf
                                                <table id="tbl-doc-area" class="table table-bordered table-stripped table-sm">
                                                    <thead>
                                                        <th>Document Area</th>
                                                        <th style="width: 150px; text-align:center;">
                                                            <button type="button" class="btn btn-success btn-sm btn-select-docarea">
                                                                <i class="fa fa-plus"></i>
                                                            </button>
                                                        </th>
                                                    </thead>
                                                    <tbody class="mainbodynpo" id="tbl-doc-area-body">
                                                        @foreach($affected_area as $key => $row)
                                                        <tr>
                                                            <td>
                                                                <select name="docareas[]" class="form-control docareas">
                                                                    <option value="{{ $row->docarea }}">{{ $row->docareaname }}</option>
                                                                </select>
                                                            </td>
                                                            <td style="text-align:center;">
                                                                <button type="button" class="btn btn-danger btn-sm btnRemoveArea" data-docareaid="{{ $row->docarea }}">
                                                                    <i class="fa fa-trash"></i>
                                                                </button>
                                                            </td>
                                                        </tr>
                                                        @endforeach
                                                    </tbody>
                                                    <tfoot>
                                                        <tr>
                                                            <td></td>
                                                            <td style="width: 150px; text-align:center;">
                                                                <button type="submit" class="btn btn-primary btn-sm">
                                                                    <i class="fa fa-edit"></i> Update Area
                                                                </button>
                                                            </td>
                                                        </tr>
                                                    </tfoot>
                                                </table>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="custom-content-above-approval" role="tabpanel" aria-labelledby="custom-content-above-approval-tab">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <table class="table table-sm">
                                                <thead>
                                                    <th>No</th>
                                                    <th>File Name</th>
                                                    <th>Upload Date</th>
                                                    <th></th>
                                                </thead>
                                                <tbody>
                                                @foreach($attachments as $key => $file)
                                                    <tr>
                                                        <td>{{ $key+1 }}</td>
                                                        <td>
                                                            <a href="/files/{{ $file->efile }}" target="_blank">{{ $file->efile }}</a>
                                                        </td>
                                                        <td>
                                                            <i class="fa fa-clock"></i> {{\Carbon\Carbon::parse($file->created_at)->diffForHumans()}} - 
                                                            ({!! formatDateTime($file->created_at) !!})
                                                        </td>
                                                        <td>
                                                            
                                                        </td>
                                                    </tr>
                                                @endforeach
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <hr>
                                    <form action="{{ url('transaction/document/updatefiles') }}/{{ $documents->id }}" method="post" enctype="multipart/form-data">
                                        @csrf
                                        <div class="row">
                                            <div class="col-lg-12 col-sm-12 form-group">
                                                <label for="docfiles">Add New Attachment</label>
                                                <input type="file" name="docfiles[]" class="form-control" multiple="multiple" required>
                                            </div>
                                            <div class="col-lg-12">
                                                <label for="">Attachment Notes</label>
                                                <textarea name="attachmentNote" id="attachmentNote" cols="30" rows="3" class="form-control"></textarea>
                                            </div>
                                            <div class="col-lg-12">
                                                <button type="submit" class="btn btn-primary btn-sm">
                                                    <i class="fa fa-upload"></i> Upload New Files
                                                </button>
                                            </div>
                                        </div>
                                    </form>
                                </div>

                                <div class="tab-pane fade" id="custom-content-above-history" role="tabpanel" aria-labelledby="custom-content-above-history-tab">
                                    <div class="col-lg-12">
                                        <div class="timeline">
                                            @foreach($dochistorydate as $hstrdate => $hstrgrp)
                                                <div class="time-label">
                                                    <span class="bg-red">{{ formatDate($hstrgrp->created_date) }}</span>
                                                </div>
                                                @foreach($dochistory as $hstrdtl => $dochstrdtl)
                                                    @if(formatDate($hstrgrp->created_date) == formatDate($dochstrdtl->created_date))
                                                    <div>
                                                        <i class="fas fa-user bg-green" title="{{$dochstrdtl->createdby}}"></i>
                                                        <div class="timeline-item">
                                                            <span class="time">
                                                                <i class="fas fa-clock"></i>
                                                                {{\Carbon\Carbon::parse($dochstrdtl->createdon)->diffForHumans()}} <br>
                                                                ({{$dochstrdtl->createdon}})
                                                            </span>
                                                            <h3 class="timeline-header no-border">
                                                                <b>{{$dochstrdtl->createdby}}</b> <br>
                                                                {{ $dochstrdtl->activity }}
                                                            </h3>
                                                        </div>
                                                    </div>
                                                    @endif
                                                @endforeach
                                            @endforeach
                                        </div>                                         
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection

@section('additional-js')
<script src="{{ ('/assets/ckeditor/ckeditor.js') }}"></script>
<script src="{{ ('/assets/ckeditor/adapters/jquery.js') }}"></script>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
<script type="text/javascript">
    $(document).ready(function () {        
        var count = 0;
        $('.btn-select-docarea').on('click', function(){
            $('#tbl-doc-area-body').append(`
                <tr>
                    <td>
                        <select name="docareas[]" class="form-control docareas">
                            <option value="">Select Document Area</option>
                            @foreach($docareas as $key => $row)
                                <option value="{{ $row->id }}">{{ $row->docarea }}</option>
                            @endforeach
                        </select>
                    </td>
                    <td style="text-align:center;">
                        <button type="button" class="btn btn-danger btn-sm btnRemove">
                            <i class="fa fa-trash"></i>
                        </button>
                    </td>
                <tr>
            `);

            $('.btnRemove').on('click', function(e){
                e.preventDefault();
                $(this).closest("tr").remove();
            });

            $(".docareas").select2();

        });


        $('.btnRemoveArea').on('click', function(e){
            e.preventDefault();
            $(this).closest("tr").remove();
        });

        $('.docremark').ckeditor();
    });
</script>
@endsection