@extends('layouts/App')

@section('title', 'Document Approval')

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
        <div class="col-lg-12">
            <div class="card">
                <div class="card-header">
                    <!-- <h3 class="card-title">Approve Document</h3> -->
                    <div class="row">
                        <ul class="nav nav-tabs" id="custom-content-above-tab" role="tablist">
                            <li class="nav-item">
                                <a class="nav-link active" id="custom-content-above-docinfo-tab" data-toggle="pill" href="#custom-content-above-docinfo" role="tab" aria-controls="custom-content-above-docinfo" aria-selected="true">Document Info <b>[ Versoin {{ $version }} ]</b></a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="custom-content-above-home-tab" data-toggle="pill" href="#custom-content-above-home" role="tab" aria-controls="custom-content-above-home" aria-selected="false">Files</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="custom-content-above-approval-tab" data-toggle="pill" href="#custom-content-above-approval" role="tab" aria-controls="custom-content-above-approval" aria-selected="false">Approval Status</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="custom-content-above-history-tab" data-toggle="pill" href="#custom-content-above-history" role="tab" aria-controls="custom-content-above-history" aria-selected="false">Document History</a>
                            </li>
                        </ul>
                    </div>
                    <div class="card-tools">
                        <a href="{{ url('/transaction/docapproval') }}" class="btn btn-default btn-sm">
                            <i class="fa fa-arrow-left"></i> Back
                        </a>
                    </div>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="tab-content" id="custom-content-above-tabContent">
                                <div class="tab-pane fade show active" id="custom-content-above-docinfo" role="tabpanel" aria-labelledby="custom-content-above-docinfo-tab">
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <div class="form-group">
                                                        <label for="doctitle">Document Title</label>
                                                        <input type="text" class="form-control" value="{{ $document->document_title }}" readonly>
                                                    </div>  
                                                </div>  
                                                <div class="col-lg-6">
                                                    <div class="form-group">
                                                        <label for="doctitle">DCN Number</label>
                                                        <input type="text" class="form-control" value="{{ $document->dcn_number }}" readonly>
                                                        <input type="hidden" id="dcnNumber" value="{{ $document->dcn_number }}">
                                                    </div>   
                                                </div>
                                                <div class="col-lg-6">
                                                    <div class="form-group">
                                                        <label for="doctype">Document Type</label>
                                                        <input type="text" class="form-control" value="{{ $document->doctype }}" readonly>
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
                                            </div>
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <div class="form-group">
                                                        <label>Created By:</label> {{$document->createdby}}<br>
                                                        <label>Created At:</label>
                                                        <p>{!! formatDateTime($document->created_at) !!} 
                                                            ({{\Carbon\Carbon::parse($document->created_at)->diffForHumans()}})
                                                        </p>
                                                        <label>Last Updated:</label>
                                                        <p>{!! formatDateTime($document->updated_at) !!} 
                                                            @if($document->updated_at != null)
                                                            ({{\Carbon\Carbon::parse($document->updated_at)->diffForHumans()}})
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
                                </div>

                                <div class="tab-pane fade" id="custom-content-above-home" role="tabpanel" aria-labelledby="custom-content-above-home-tab">
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
                                                            {{ $file->efile }}
                                                        </td>
                                                        <td>
                                                            <i class="fa fa-clock"></i> {{\Carbon\Carbon::parse($file->created_at)->diffForHumans()}} - 
                                                            ({!! formatDateTime($file->created_at) !!})
                                                        </td>
                                                        <td>
                                                            @if(checkIsLocalhost() == 1)
                                                            <button type="button" onclick="previewFile('/files/{{$file->efile}}#toolbar=0')">Preview</button>
                                                            @else
                                                            <button type="button" onclick="previewFile('/main/public/files/{{$file->efile}}#toolbar=0')">Preview</button>
                                                            @endif
                                                        </td>
                                                    </tr>
                                                @endforeach
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="custom-content-above-approval" role="tabpanel" aria-labelledby="custom-content-above-approval-tab">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <table id="tbl-approval" class="table table-bordered table-hover table-striped table-sm" style="width:100%;">
                                                <thead>
                                                    <th>Approver Name</th>
                                                    <th>Approver Level</th>
                                                    <th>Approval Status</th>
                                                    <th>Approve/Reject Date</th>
                                                    <th>Approver Note</th>
                                                </thead>
                                                <tbody>
                                                    @foreach($approvals as $key => $row)
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
                                                    </tr>
                                                    @endforeach
                                                </tbody>
                                            </table>                                                    
                                        </div>
                                    </div>
                                    @if($isApprovedbyUser)
                                        @if($isApprovedbyUser->approval_status <> "A")
                                        <div class="row">
                                            <div class="col-lg-12">
                                                <form id="form-approve-document" method="post" enctype="multipart/form-data">
                                                    @csrf
                                                    <div class="form-group">
                                                        <input type="hidden" name="version" id="docVersion" value="{{ $version }}">
                                                        <textarea name="approver_note" id="approver_note" class="form-control" cols="30" rows="3" placeholder="Approver Note"></textarea>
                                                    </div>
                                                    <div class="input-group mb-3">
                                                        <input type="file" class="form-control" name="approveddoc" required>
                                                        <div class="input-group-append">
                                                            <button class="btn btn-success btn-sm" type="submit">
                                                                <i class="fa fa-check"></i> APPROVE
                                                            </button>
                                                            <button type="button" class="btn btn-danger btn-sm mr-3" id="btn-reject">
                                                                <i class="fa fa-xmark"></i> REJECT
                                                            </button>
                                                        </div>
                                                    </div>
                                                </form>    
                                                <!-- <div class="form-group">
                                                    <button type="button" class="btn btn-success pull-right ml-1" id="btn-approve">
                                                        <i class="fa fa-check"></i> APPROVE
                                                    </button>
                                                    <button type="button" class="btn btn-danger pull-right" id="btn-reject">
                                                        <i class="fa fa-xmark"></i> REJECT
                                                    </button>
                                                </div>
                                                <form action="">
                                                </form> -->
                                            </div>
                                        </div>
                                        @endif
                                    @endif
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
            </div>
        </div>
        </form>
    </div>
</div>   
@endsection

@section('additional-js')
<script src="{{ ('/assets/ckeditor/ckeditor.js') }}"></script>
<script src="{{ ('/assets/ckeditor/adapters/jquery.js') }}"></script>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
<!-- <script src="https://cdn.scaleflex.it/plugins/filerobot-image-editor/3/filerobot-image-editor.min.js"></script> -->

<script type="text/javascript">
    function previewFile(files){         
        if(files !== ""){
            $('#fileViewer').html('');
            $('#fileViewer').append(`
                <embed src="`+ files +`" frameborder="0" width="100%" height="500px">
            
            `);
            $('#modalPreviewFile').modal('show');
        } else{
            swal("File Not Found", "", "warning");
        }
    }

    $(document).ready(function () { 
        $('#tbl-doc-area').DataTable();

        $('#btn-approve').on('click', function(){
            $('#btn-approve').prop('disabled', true);
            $('#btn-reject').prop('disabled', true);
            approveDocument('A');
        });

        $('#btn-reject').on('click', function(){
            $('#btn-approve').prop('disabled', true);
            $('#btn-reject').prop('disabled', true);
            approveDocument('R');
        });

        function approveDocument(_action){
            let _token   = $('meta[name="csrf-token"]').attr('content');
            $.ajax({
                url: base_url+'/transaction/docapproval/approve',
                type:"POST",
                data:{
                    dcnNumber: $('#dcnNumber').val(),
                    action:_action,
                    version: {{ $version }},
                    approvernote:$('#approver_note').val(),
                    _token: _token
                },
                success:function(response){
                    console.log(response);
                    if(response){
                        if(_action === "A"){
                            toastr.success('Document Approved')
                        }else if(_action === "R"){
                            toastr.success('Document Rejected')
                        }                        

                        setTimeout(function(){ 
                            // location.reload();
                            window.location.href = base_url+'/transaction/docapproval';
                        }, 2000);
                    }
                },
                error: function(error) {
                    console.log(error);
                    toastr.error(error)

                    setTimeout(function(){ 
                        location.reload();
                    }, 2000);
                }
            });
        }

        $('#form-approve-document').on('submit', function(event){
            event.preventDefault();
                
            var formData = new FormData(this);
            console.log($(this).serialize())
            $.ajax({
                url:base_url+'/handworkprocess/saveshandwork',
                method:'post',
                data:formData,
                dataType:'JSON',
                contentType: false,
                cache: false,
                processData: false,
                beforeSend:function(){
                    // showBasicMessage();
                },
                success:function(data)
                {
                    console.log(data);
                },
                error:function(err){
                    // showErrorMessage(JSON.stringify(err))
                }
            }).done(function(result){
                console.log(result);
                
            });
        });

        $('.docremark').ckeditor();
    });
</script>
@endsection