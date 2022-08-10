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
        <div class="col-lg-3">
            <form action="{{ url('transaction/document/save') }}" method="post" enctype="multipart/form-data">
                @csrf
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">Approve Document</h3>
                        <div class="card-tools">
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="form-group">
                                    <label for="doctitle">Document Title</label>
                                    <p>{{ $document->document_title }}</p>
                                </div>  
                                <div class="form-group">
                                    <label for="doctitle">DCN Number</label>
                                    <p>{{ $document->dcn_number }}</p>
                                    <input type="hidden" id="dcnNumber" value="{{ $document->dcn_number }}">
                                </div>   
                                <div class="form-group">
                                    <label for="doctype">Document Type</label>
                                    <p>{{ $document->doctype }}</p>
                                </div>    
                                <div class="form-group">
                                    <label for="doclevel">Document Level</label>
                                    <p>{{ $document->document_level }}</p>
                                </div>
                                <div class="form-group">
                                    <label for="effectivedate">Effectivity Date</label>
                                    <p>{{ formatDate($document->effectivity_date) }}</p>
                                </div>
                                <div class="form-group">
                                    <label for="docnumber">Document Number</label>
                                    <p>{{ $document->document_number }}</p>
                                </div>
                                <div class="form-group">
                                    <label>Created By:</label> {{$document->createdby}}
                                </div>
                                <div class="form-group">
                                    <label>Created At:</label>
                                    <p>{!! formatDateTime($document->created_at) !!} <br>
                                        ({{\Carbon\Carbon::parse($document->created_at)->diffForHumans()}})
                                    </p>
                                </div>
                                <div class="form-group">
                                    <label>Last Updated:</label>
                                    <p>{!! formatDateTime($document->updated_at) !!} <br>
                                        @if($document->updated_at != null)
                                        ({{\Carbon\Carbon::parse($document->updated_at)->diffForHumans()}})
                                        @endif
                                    </p>
                                </div>
                                <div class="row">
                                </div>
                            </div>  
                        </div>
                    </div>
                </div>
            </form>
        </div>
        <div class="col-lg-9">
            <div class="card">
                <div class="card-header">
                    <!-- <h3 class="card-title">Approve Document</h3> -->
                    <div class="row">
                        <ul class="nav nav-tabs" id="custom-content-above-tab" role="tablist">
                            <li class="nav-item">
                                <a class="nav-link active" id="custom-content-above-home-tab" data-toggle="pill" href="#custom-content-above-home" role="tab" aria-controls="custom-content-above-home" aria-selected="true">Files</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="custom-content-above-profile-tab" data-toggle="pill" href="#custom-content-above-profile" role="tab" aria-controls="custom-content-above-profile" aria-selected="false">Document Affected Area</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="custom-content-above-approval-tab" data-toggle="pill" href="#custom-content-above-approval" role="tab" aria-controls="custom-content-above-approval" aria-selected="false">Approval Status</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="custom-content-above-description-tab" data-toggle="pill" href="#custom-content-above-description" role="tab" aria-controls="custom-content-above-description" aria-selected="false">Description</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="custom-content-above-history-tab" data-toggle="pill" href="#custom-content-above-history" role="tab" aria-controls="custom-content-above-history" aria-selected="false">Document History</a>
                            </li>
                        </ul>
                    </div>
                    <div class="card-tools">
                        <a href="#" class="btn btn-default btn-sm">
                            <i class="fa fa-download"></i> Download All Files
                        </a>
                        <a href="{{ url('/transaction/docapproval') }}" class="btn btn-default btn-sm">
                            <i class="fa fa-arrow-left"></i> Back
                        </a>
                    </div>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="tab-content" id="custom-content-above-tabContent">
                                <div class="tab-pane fade show active" id="custom-content-above-home" role="tabpanel" aria-labelledby="custom-content-above-home-tab">
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
                                </div>
                                <div class="tab-pane fade" id="custom-content-above-profile" role="tabpanel" aria-labelledby="custom-content-above-profile-tab">
                                    <div class="col-lg-12">
                                        <table id="tbl-doc-area" class="table table-bordered table-hover table-striped table-sm" style="width:100%;">
                                            <thead>
                                                <th>Document Affected Area</th>
                                            </thead>
                                            <tbody>
                                                @foreach($areas as $key => $row)
                                                <tr>
                                                    <td>{{ $row->docareaname }}</td>
                                                </tr>
                                                @endforeach
                                            </tbody>
                                        </table>                                                    
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
                                                <form action="">
                                                    <div class="form-group">
                                                        <textarea name="approver_note" id="approver_note" class="form-control" cols="30" rows="3" placeholder="Approver Note"></textarea>
                                                    </div>
                                                    <div class="form-group">
                                                        <button type="button" class="btn btn-success pull-right ml-1" id="btn-approve">
                                                            <i class="fa fa-check"></i> APPROVE
                                                        </button>
                                                        <button type="button" class="btn btn-danger pull-right" id="btn-reject">
                                                            <i class="fa fa-xmark"></i> REJECT
                                                        </button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                        @endif
                                    @endif
                                </div>

                                <div class="tab-pane fade" id="custom-content-above-description" role="tabpanel" aria-labelledby="custom-content-above-description-tab">
                                    <div class="col-lg-12">
                                        <textarea class="docremark form-control" name="docremark">
                                            {!! $document->description !!}
                                        </textarea>                                      
                                    </div>
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
<!-- <script src="https://cdn.scaleflex.it/plugins/filerobot-image-editor/3/filerobot-image-editor.min.js"></script> -->

<script type="text/javascript">
    $(document).ready(function () { 
        $('#tbl-doc-area').DataTable();

        $('#btn-approve').on('click', function(){
            approveDocument('A');
        });

        $('#btn-reject').on('click', function(){
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
                            location.reload();
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

        $('.docremark').ckeditor();
    });
</script>
@endsection