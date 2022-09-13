@extends('layouts/App')

@section('title', 'Document Detail')

@section('additional-css')
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="{{ asset('/assets/css/customstyle.css') }}">
    <style type="text/css">
        .select2-container {
            display: block
        }

        .select2-container .select2-selection--single {
            height: 36px;
        }
    </style>
@endsection

@section('loader')
    
@endsection

@section('content')
<div class="container-fluid">
    <div class="row">
        <div class="col-lg-3">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Document Version</h3>
                    <div class="card-tools">
                        @if($documents->createdby == Auth::user()->username || userAllowChangeDocument() == 1)
                        <button type="button" class="btn btn-success btn-sm btnAddVersion">
                            <i class="fa fa-plus"></i> Add new revision
                        </button>
                        @endif
                    </div>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-lg-12" style="overflow-y: auto; height:600px;">
                            @foreach($docversions as $key => $row)
                            <div class="col-lg-12 col-md-12 col-sm-12 m-t-10 docVersion" style="cursor:pointer;" data-docid="{{ $documents->id }}" data-docversion="{{ $row->doc_version }}">
                                <div class="doc-box box box-widget widget-user-2">
                                    <div class="widget-user-header bg-gray bg-folder-shaper no-padding" style="border-top-left-radius: 20px !important; background-color:#265a91 !important;">
                                    <!-- #265a91 #0fa522-->
                                        <div class="box-header">
                                            <span style="margin-left: 0px; color:white;" data-toggle="tooltip" title="{{ $row->doc_version }}">
                                                Version : {{ $row->doc_version }} <br>
                                                {{ $documents->document_title }} <br>
                                                {{ $row->dcn_number }}
                                            </span>
                                            <span class="pull-right" style="margin-right: 15px; color:white;" data-toggle="tooltip" title="{{ $documents->document_number }}">
                                            {{ $documents->document_number }}
                                            </span>
                                        </div>
                                        <hr style="background-color:white; margin-top: 0px; margin-bottom: 2px;">
                                        <h5 class="widget-user-desc" style="font-size: 12px; margin-left: 10px; margin-top: 0px; margin-bottom: 0px;">
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
                    <h3 class="card-title">Document Detail <b id="hdr-version">Version {{ $docversions[0]->doc_version }}</b></h3>
                    <div class="card-tools">
                        <!-- <a href="{{ url('/transaction/doclist/print') }}/{{$documents->id}}" target="_blank" class='btn btn-success btn-sm button-print'> 
                            <i class='fa fa-print'></i> Print
                        </a> -->
                        <a href="{{ url('/transaction/doclist') }}" class="btn btn-default btn-sm">
                            <i class="fa fa-arrow-left"></i> Back
                        </a>
                    </div>
                </div>
                <div class="card-body">
                    <!-- <div class="row">
                        <div class="col-lg-12">
                            <div class="row">
                                <div class="col-lg-6 col-sm-12 form-group">
                                    <label for="doctitle">Document Title</label>
                                    <input type="text" class="form-control" name="doctitle" id="doctitle" placeholder="Document Title" value="{{ $documents->document_title }}" required>
                                </div>   
                                <div class="col-lg-6 col-sm-12 form-group">
                                    <label for="doctype">Document Type</label>
                                    <select name="doctype" id="doctype" class="form-control">
                                        <option value="{{ $cdoctype->id }}"> {{ $cdoctype->doctype }} </option>
                                    </select>
                                </div>    
                                
                                <div class="col-lg-3 col-sm-12 form-group">
                                    <label for="effectivedate">Effectivity Date</label>
                                    <input type="date" name="effectivedate" class="form-control" value="{{ $documents->effectivity_date }}" required>
                                </div>
                                <div class="col-lg-3 col-sm-12 form-group">
                                    <label for="docnumber">Document Number</label>
                                    <input type="text" name="docnumber" class="form-control" value="{{ $documents->document_number }}">
                                </div>
                                <div class="col-lg-6 col-sm-12 form-group">
                                    @if($documents->createdby == Auth::user()->username || userAllowChangeDocument() == 1)
                                    <button class="btn btn-primary btn-sm">
                                        <i class="fa fa-edit"></i> Update Document Info
                                    </button>
                                    @endif
                                </div>
                            </div>
                        </div>
                    </div> -->
                    <div class="row">
                        <div class="col-lg-12">
                            <ul class="nav nav-tabs" id="custom-content-above-tab" role="tablist">
                                <li class="nav-item">
                                    <a class="nav-link active" id="custom-content-above-home-tab" data-toggle="pill" href="#custom-content-above-home" role="tab" aria-controls="custom-content-above-home" aria-selected="true">Document Info</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="custom-content-above-attachment-tab" data-toggle="pill" href="#custom-content-above-attachment" role="tab" aria-controls="custom-content-above-attachment" aria-selected="false">Files</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="custom-content-above-history-tab" data-toggle="pill" href="#custom-content-above-history" role="tab" aria-controls="custom-content-above-history" aria-selected="false">Document Version History</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="custom-content-above-history-all-tab" data-toggle="pill" href="#custom-content-above-history-all" role="tab" aria-controls="custom-content-above-history-all" aria-selected="false">Document All History</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="custom-content-above-approval-tab" data-toggle="pill" href="#custom-content-above-approval" role="tab" aria-controls="custom-content-above-approval" aria-selected="false">Approval Status</a>
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
                                                    <div class="col-lg-12">
                                                        <div class="form-group">
                                                            <label for="doctitle">Document Title</label>
                                                            <input type="text" class="form-control" value="{{ $documents->document_title }}" readonly>
                                                        </div>  
                                                    </div>  
                                                    <div class="col-lg-6">
                                                        <div class="form-group">
                                                            <label for="doctitle">DCN Number</label>
                                                            <input type="text" class="form-control" value="{{ $documents->dcn_number }}" readonly>
                                                            <input type="hidden" id="dcnNumber" value="{{ $documents->dcn_number }}">
                                                        </div>   
                                                    </div>
                                                    <div class="col-lg-6">
                                                        <div class="form-group">
                                                            <label for="doctype">Document Type</label>
                                                            <input type="text" class="form-control" value="{{ $documents->doctype }}" readonly>
                                                        </div>   
                                                    </div>
                                                    <div class="col-lg-6">
                                                        <div class="form-group">
                                                            <label for="doclevel">Assy Code</label>
                                                            <input type="text" class="form-control" value="{{ $wiDocData->assy_code }}" readonly>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-6">
                                                        <div class="form-group">
                                                            <label for="model">Model</label>
                                                            <input type="text" class="form-control" value="{{ $wiDocData->model_name }}" readonly>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-12">
                                                        <div class="form-group">
                                                            <label for="model">Scope</label>
                                                            <input type="text" class="form-control" value="{{ $wiDocData->scope }}" readonly>
                                                        </div>                                                    
                                                    </div>
                                                    <div class="col-lg-6">
                                                        <div class="form-group">
                                                            <label for="establisheddate">Established Date</label>
                                                            <p>{{ formatDate($docVersionData->established_date) }}</p>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-6">
                                                        <div class="form-group">
                                                            <label for="ValidityDate">Validity Date</label>
                                                            <p>{{ formatDate($docVersionData->validity_date) }}</p>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-6">
                                                        <div class="form-group">
                                                            <label>Created By:</label> {{$documents->createdby}}<br>
                                                            <label>Created At:</label>
                                                            <p>{!! formatDateTime($documents->created_at) !!} 
                                                                ({{\Carbon\Carbon::parse($documents->created_at)->diffForHumans()}})
                                                            </p>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-6">
                                                        <div class="form-group">
                                                            <label>Last Updated:</label>
                                                            <p>{!! formatDateTime($documents->updated_at) !!} 
                                                                @if($documents->updated_at != null)
                                                                ({{\Carbon\Carbon::parse($documents->updated_at)->diffForHumans()}})
                                                                @endif
                                                            </p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-6">
                                                <div class="row">
                                                    <div class="col-lg-12">
                                                        <div class="card card-gray">
                                                            <div class="card-header">
                                                                <h3 class="card-title">IMPLEMENTATION</h3>
                                                            </div>
                                                        </div>
                                                        <div class="card-body">
                                                            <div class="row">
                                                                <div class="col-lg-6">
                                                                    <div class="form-group clearfix">
                                                                        <div class="icheck-primary d-inline">                                                                        
                                                                            @if(substr($wiDocData->implementation,0,1) === "Y")
                                                                                <input type="checkbox" id="imp1" name="imp1" checked disabled>
                                                                            @else
                                                                                <input type="checkbox" id="imp1" name="imp1" disabled>
                                                                            @endif
                                                                            <label for="imp1"> IMMEDIATE </label>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-lg-6">
                                                                    <div class="form-group clearfix">
                                                                        <div class="icheck-primary d-inline">
                                                                            @if(substr($wiDocData->implementation,1,1) === "Y")
                                                                                <input type="checkbox" id="imp2" name="imp2" checked disabled>
                                                                            @else
                                                                                <input type="checkbox" id="imp2" name="imp2" disabled>
                                                                            @endif
                                                                            <label for="imp2"> RUNNING CHANGE </label>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-lg-6">
                                                                    <div class="form-group clearfix">
                                                                        <div class="icheck-primary d-inline">
                                                                            @if(substr($wiDocData->implementation,2,1) === "Y")
                                                                                <input type="checkbox" id="imp3" name="imp3" checked disabled>
                                                                            @else
                                                                                <input type="checkbox" id="imp3" name="imp3" disabled>
                                                                            @endif
                                                                            <label for="imp3"> TEMPORARY </label>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-12">
                                                        <div class="card card-gray">
                                                            <div class="card-header">
                                                                <h3 class="card-title">REASON</h3>
                                                            </div>
                                                        </div>
                                                        <div class="card-body">
                                                            <div class="row">
                                                                <div class="col-lg-6">
                                                                    <div class="form-group clearfix">
                                                                        <div class="icheck-primary d-inline">
                                                                            @if(substr($wiDocData->reason,0,1) === "Y")
                                                                                <input type="checkbox" id="reason1" name="reason1" checked disabled>  
                                                                            @else
                                                                                <input type="checkbox" id="reason1" name="reason1" disabled>
                                                                            @endif
                                                                            <label for="reason1"> NEW </label>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-lg-6">
                                                                    <div class="form-group clearfix">
                                                                        <div class="icheck-primary d-inline">
                                                                            @if(substr($wiDocData->reason,1,1) === "Y")
                                                                                <input type="checkbox" id="reason2" name="reason2" checked disabled>  
                                                                            @else
                                                                                <input type="checkbox" id="reason2" name="reason2" disabled>
                                                                            @endif
                                                                            <label for="reason2"> ADDITION </label>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-lg-6">
                                                                    <div class="form-group clearfix">
                                                                        <div class="icheck-primary d-inline">
                                                                            @if(substr($wiDocData->reason,2,1) === "Y")
                                                                                <input type="checkbox" id="reason3" name="reason3" checked disabled>  
                                                                            @else
                                                                                <input type="checkbox" id="reason3" name="reason3" disabled>
                                                                            @endif
                                                                            <label for="reason3"> REVISION </label>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-lg-6">
                                                                    <div class="form-group clearfix">
                                                                        <div class="icheck-primary d-inline">
                                                                            @if(substr($wiDocData->reason,3,1) === "Y")
                                                                                <input type="checkbox" id="reason4" name="reason4" checked disabled>  
                                                                            @else
                                                                                <input type="checkbox" id="reason4" name="reason4" disabled>
                                                                            @endif
                                                                            <label for="reason4"> OTHERS </label>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                
                                <div class="tab-pane fade" id="custom-content-above-attachment" role="tabpanel" aria-labelledby="custom-content-above-attachment-tab">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <table class="table table-sm">
                                                <thead>
                                                    <th>No</th>
                                                    <th>File Name</th>
                                                    <th>Upload Date</th>
                                                    <th></th>
                                                </thead>
                                                <tbody id="tbl-attachment-body">
                                                @foreach($attachments as $key => $file)
                                                    <tr>
                                                        <td>{{ $key+1 }}</td>
                                                        <td>
                                                            {{ $file->efile }}
                                                        </td>
                                                        <td>
                                                            <i class="fa fa-clock"></i> {{\Carbon\Carbon::parse($file->created_at)->diffForHumans()}} - 
                                                            ({!! formatDateTime($file->created_at) !!})
                                                        </td>
                                                        <td>
                                                            <button type="button" onclick="previewFile('storage/files/{{$file->efile}}#toolbar=0')">Preview</button>
                                                            @if(checkIsLocalhost() == 1)
                                                            @else
                                                            <!-- <button type="button" onclick="previewFile('/main/public/files/{{$file->efile}}#toolbar=0')">Preview</button> -->
                                                            @endif
                                                        </td>
                                                    </tr>
                                                @endforeach
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    
                                </div>

                                <div class="tab-pane fade" id="custom-content-above-history" role="tabpanel" aria-labelledby="custom-content-above-history-tab">
                                    <div class="col-lg-12">
                                        <div class="timeline" id="timeline-version-history">
                                            @foreach($dochistorydate as $hstrdate => $hstrgrp)
                                                @if($latestVersion == $hstrgrp->doc_version)
                                                    <div class="time-label">
                                                        <span class="bg-red">{{ formatDate($hstrgrp->created_date) }}</span>
                                                    </div>
                                                    @foreach($dochistory as $hstrdtl => $dochstrdtl)
                                                        @if(formatDate($hstrgrp->created_date) == formatDate($dochstrdtl->created_date) && $latestVersion == $dochstrdtl->doc_version)
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
                                                @endif
                                            @endforeach
                                        </div>                                         
                                    </div>
                                </div>

                                <div class="tab-pane fade" id="custom-content-above-history-all" role="tabpanel" aria-labelledby="custom-content-above-history-all-tab">
                                    <div class="col-lg-12">
                                        <div class="timeline">
                                            @foreach($alldochistorydate as $hstrdate => $hstrgrp)
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

                                <div class="tab-pane fade" id="custom-content-above-approval" role="tabpanel" aria-labelledby="custom-content-above-approval-tab">
                                    <div class="col-lg-12">
                                        <table id="tbl-approval" class="table table-bordered table-hover table-striped table-sm" style="width:100%;">
                                            <thead>
                                                <th>Approver Name</th>
                                                <th>Approver Level</th>
                                                <th>Approval Status</th>
                                                <th>Approve/Reject Date</th>
                                                <th>Approver Note</th>
                                                <th>User</th>
                                            </thead>
                                            <tbody id="tbl-approval-body">
                                                @foreach($docapproval as $key => $row)
                                                <tr>
                                                    <td>{{ $row->approver_name }}</td>
                                                    <td>{{ $row->approver_level }} | {{ $row->wf_categoryname }}</td>
                                                    @if($row->approval_status == "A")
                                                    <td style="text-align:center; background-color:green; color:white;">
                                                        Approved
                                                    </td>
                                                    @elseif($row->approval_status == "R")
                                                    <td style="text-align:center; background-color:red; color:white;">
                                                        Rejected
                                                    </td>
                                                    @else
                                                    <td style="text-align:center; background-color:yellow; color:black;">
                                                        Open
                                                    </td>
                                                    @endif
                                                    
                                                    <td>
                                                        @if($row->approval_date != null)
                                                            <i class="fa fa-clock"></i> {{\Carbon\Carbon::parse($row->approval_date)->diffForHumans()}} <br>
                                                            ({{ formatDateTime($row->approval_date) }})
                                                        @endif
                                                    </td>
                                                    <td>{!! $row->approval_remark !!}</td>
                                                    <td>{{ $row->approved_by }}</td>
                                                </tr>
                                                @endforeach
                                            </tbody>
                                        </table>     
                                    </div>
                                    <div class="col-lg-12">
                                        <a href="{{ url('') }}/{{$approvalDoc->efile}}" target="_blank" class='btn btn-success btn-sm pull-right'> 
                                            <i class='fa fa-download'></i> Download Approval Document
                                        </a>
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

@section('additional-modal')
<div class="modal fade bd-example-modal-xl" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" id="modalPreviewFile">
    <div class="modal-dialog modal-xl">
        <form class="form-horizontal">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalPreviewFileTitle">Preview Document</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="position-relative row form-group">
                    <div class="col-lg-12" id="fileViewer">
                        <!-- <div id="example1"></div> -->
                        
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal"> Close</button>
                @if(userAllowDownloadDocument() == 1)
                <a href="#" id="btnDownloadFile" class="btn btn-default btnDownloadFile" download="">
                    <i class="fa fa-download"></i> Download Document
                </a>
                <!-- <a href="http://localhost:8181/digidocu/admin/_files/original/2XSkOTza1MJ5H0TewEFQbjeeKXgCkyGcvM16Og0U.pdf?force=true" download="">Download
                                                                original</a> -->
                @endif
            </div>
        </div>
        </form>
    </div>
</div>   

<div class="modal fade bd-example-modal-xl" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" id="modalAddVersion">
    <div class="modal-dialog modal-xl">
        <form action="{{ url('/transaction/document/savenewversion') }}/{{ $documents->id }}" method="post" class="form-horizontal" enctype="multipart/form-data">
            @csrf
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalAddVersionTitle">Create New Document Revision</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="form-group">
                                <label for="docremark">Document Remark</label>
                                <textarea class="docremark form-control" name="docremark">
                                    
                                </textarea>
                            </div>   
                        </div>
                        <div class="col-lg-6">
                            <h5>Document Area</h5>
                            <table id="tbl-doc-area" class="table table-bordered table-stripped table-sm">
                                <thead>
                                    <th>Document Area</th>
                                    <th style="width: 150px; text-align:center;">
                                        <button type="button" class="btn btn-success btn-sm btn-add-new-docarea">
                                            <i class="fa fa-plus"></i>
                                        </button>
                                    </th>
                                </thead>
                                <tbody class="mainbodynpo" id="tbl-doc-area-new-body">
                                    
                                </tbody>
                            </table>
                        </div>
                        <div class="col-lg-3 col-md-6 col-sm-12 form-group">
                            <label for="docfiles">Add New Attachment</label>
                            <input type="file" name="docfiles[]" class="form-control" multiple="multiple" required>
                        </div>
                        <div class="col-lg-3 col-md-6 col-sm-12 form-group">
                            <label for="efectivitydate">Effectivity Date</label>
                            <input type="date" name="efectivitydate" class="form-control" required>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal"> Close</button>
                    <button type="submit" class="btn btn-primary"> Save</button>
                </div>
            </div>
        </form>
    </div>
</div>   


<div class="modal fade bd-example-modal-xl" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" id="modalLoader">
    <div class="modal-dialog modal-xl">
        <form class="form-horizontal">
            <div class="modal-content">
                <div class="preloader flex-column justify-content-center align-items-center LoadingData">
                    <img class="animation__wobble" src="{{ ('/assets/dist/img/loading1.gif') }}" alt="AdminLTELogo" height="60" width="60">
                </div>
            </div>
        </form>
    </div>
</div>   
@endsection

@section('additional-js')
<script src="{{ asset('/assets/ckeditor/ckeditor.js') }}"></script>
<script src="{{ asset('/assets/ckeditor/adapters/jquery.js') }}"></script>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
<script type="text/javascript">

    function previewFile(files){
        var pathfile = base_url+'/'+files;         
        if(files !== ""){
            $('#fileViewer').html('');
            $('#fileViewer').append(`
                <embed src="`+ pathfile +`" frameborder="0" width="100%" height="500px">
            
            `);
            // var options = {
            //     height: "500px",
            //     pdfOpenParams: {view: 'FitV'},
            //     fallbackLink: 'Your browser does not support pdf'
            // }
            // PDFObject.embed(files, "#example1", options);
            // $('#print').hide();
            // $('#viewBookmark').hide();
            // $('#openFile').hide();
            // $('#exd-logo').hide();
            var fileUri = files;
            fileUri = fileUri.replace("#toolbar=0", "?force=true");
            @if(userAllowDownloadDocument() == 1)
                document.getElementById("btnDownloadFile").href=base_url+fileUri; 
            @endif
            $('#modalPreviewFile').modal('show');
        } else{
            swal("File Not Found", "", "warning");
        }
    }
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
                        @if(userAllowChangeDocument() == 1)
                        <button type="button" class="btn btn-danger btn-sm btnRemove">
                            <i class="fa fa-trash"></i>
                        </button>
                        @endif
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

        

        $('.docVersion').on('click', function(e){
            var selData = $(this).data();
            console.log(selData);
            let _token   = $('meta[name="csrf-token"]').attr('content');
            $('#tbl-doc-area-body, #timeline-version-history, #hdr-version').html('');
            $('#tbl-attachment-body, #tbl-approval-body').html('');
            $.ajax({
                url: base_url+'/transaction/doclist/detailversion/'+selData.docversion+'/'+selData.docid,
                beforeSend: function(){
                    $('#modalLoader').modal('show');
                },
                success:function(response){
                    console.log(response);
                    if(response){
                        $('#docareaContent').val(response.docversions.remark);

                        $('#hdr-version').html('Version '+ selData.docversion);

                        var _areas         = response.affected_area;
                        var _historyGroup  = response.docHistorydateGroup;
                        var _historyDetail = response.docHistory;                        

                        $('#tbl-attachment-body').append(response.htmlAttachment);

                        $('.btn-preview').on('click', function(){
                            var _dataFile = $(this).data();
                            console.log(_dataFile)
                            if(_dataFile.filepath !== ""){
                                $('#fileViewer').html('');
                                @if(checkIsLocalhost() == 1)
                                    $('#fileViewer').append(`
                                        <embed src="`+ _dataFile.filepath +`" frameborder="0" width="100%" height="500px">
                                    `);
                                @else
                                    $('#fileViewer').append(`
                                        <embed src="/main/public`+ _dataFile.filepath +`" frameborder="0" width="100%" height="500px">
                                    `);
                                @endif
                                $('#modalPreviewFile').modal('show');
                            } else{
                                swal("File Not Found", "", "warning");
                            }
                        })
                        // Append Selected Version Document History
                        $('#timeline-version-history').append(response.timeline);
                        $('#tbl-approval-body').append(response.htmlApproval);
                    }
                },
                complete: function(){
                    // $('#modalLoader').modal('hide');
                },
                error: function(error) {
                    console.log(error);
                    toastr.error(error)
                }
            }).done(function(result){
                setTimeout(function () { 
                    $('#modalLoader').modal('hide'); 
                }, 1000);
                // $('#loading01').hide();
            });
        });

        $('.btnAddVersion').on('click', function(){
            $('#modalAddVersion').modal('show');
        });

        $('.btn-add-new-docarea').on('click', function(){
            $('#tbl-doc-area-new-body').append(`
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
                        <button type="button" class="btn btn-danger btn-sm btnRemoveNewArea">
                            <i class="fa fa-trash"></i>
                        </button>
                    </td>
                <tr>
            `);

            $('.btnRemoveNewArea').on('click', function(e){
                e.preventDefault();
                $(this).closest("tr").remove();
            });

            $(".docareas").select2();
        });

        $('.docremark').ckeditor();
    });
</script>
@endsection