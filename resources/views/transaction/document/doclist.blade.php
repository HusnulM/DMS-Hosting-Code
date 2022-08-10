@extends('layouts/App')

@section('title', 'Document List')

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
                    <h3 class="card-title">Document List</h3>
                </div>
                <div class="card-body">
                    <form action="" method="GET">
                        <div class="row">
                            <div class="col-lg-3">
                                <label for="">From Date</label>
                                <input type="date" class="form-control" name="datefrom" id="datefrom" value="{{ $_GET['datefrom'] ?? '' }}">
                            </div>
                            <div class="col-lg-3">
                                <label for="">To Date</label>
                                <input type="date" class="form-control" name="dateto" id="dateto" value="{{ $_GET['dateto'] ?? '' }}">
                            </div>
                            <div class="col-lg-3">
                                <label for="">Document Status</label>
                                <select name="approvalStatus" id="approvalStatus" class="form-control">
                                    <option value="All">All</option>
                                    <option value="O">Open</option>
                                    <option value="C">Close</option>
                                </select>
                            </div>
                            <div class="col-lg-3">
                                <br>
                                <button type="submit" class="btn btn-default mt-2"> 
                                    <i class="fa fa-search"></i> Filter
                                </button>
                            </div>
                        </div>
                    </form>
                    <hr>
                    <div class="row">
                        <div class="col-lg-12">
                            <table id="tbl-doclist" class="table table-bordered table-stripped table-sm">
                                <thead>
                                    <th>No</th>
                                    <th>DCN Number</th>
                                    <th>Document Title</th>
                                    <th>Document Type</th>
                                    <th>Created Date</th>
                                    <th>Created By</th>
                                    <th></th>
                                </thead>
                                <tbody>
                                @foreach($documents as $key => $row)
                                    <tr>
                                        <td>{{ $key+1 }}</td>
                                        <td>{{ $row->dcn_number }}</td>
                                        <td>{{ $row->document_title }}</td>
                                        <td>{{ $row->doctype }}</td>
                                        <td>
                                            <i class="fa fa-clock"></i> {{\Carbon\Carbon::parse($row->created_at)->diffForHumans()}} ({{ formatDateTime($row->created_at) }})
                                        </td>
                                        <td>{{ $row->createdby }}</td>
                                        <td style="text-align:center;">
                                            <a href="{{ url('/transaction/doclist/detail') }}/{{ $row->id }}" class="btn btn-primary btn-sm">
                                                View Detail
                                            </a>
                                        </td>
                                    </tr>
                                @endforeach
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>   
        </div>
    </div>
</div>
@endsection

@section('additional-js')
<script>
    $(function(){
        $('#tbl-doclist').DataTable();
    });
</script>
@endsection