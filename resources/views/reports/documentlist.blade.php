@extends('layouts/App')

@section('title', 'Report Document List')

@section('additional-css')
    <!-- <link rel="stylesheet" href="http://localhost:8181/digidocu/css/lte/AdminLTE.min.css"> -->
    <link rel="stylesheet" href="{{ ('/assets/css/customstyle.css') }}">

    <style>
        td.details-control {
            background: url("{{ ('/assets/dist/img/show_detail.png') }}") no-repeat center center;
            cursor: pointer;
        }
        tr.shown td.details-control {
            background: url("{{ ('/assets/dist/img/close_detail.png') }}") no-repeat center center;
        }
    </style>
@endsection

@section('content')
<div class="container-fluid">
    <div class="row">
        <div class="col-lg-12">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Report Document List</h3>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-lg-2">
                            <label for="">From Date</label>
                            <input type="date" class="form-control" name="datefrom" id="datefrom" value="{{ $_GET['datefrom'] ?? '' }}">
                        </div>
                        <div class="col-lg-2">
                            <label for="">To Date</label>
                            <input type="date" class="form-control" name="dateto" id="dateto" value="{{ $_GET['dateto'] ?? '' }}">
                        </div>
                        <div class="col-lg-3">
                            <label for="">Document Type</label>
                            <select name="doctype" id="doctype" class="form-control">
                                <option value="All">All</option>
                                @foreach($doctypes as $key => $row)
                                <option value="{{ $row->id }}">{{ $row->doctype }}</option>
                                @endforeach
                            </select>
                        </div>
                        <div class="col-lg-3">
                            <label for="">Approval Status</label>
                            <select name="approvalStatus" id="approvalStatus" class="form-control">
                                <option value="All">All</option>
                                <option value="O">Open</option>
                                <option value="C">Obsolete</option>
                                <option value="R">Rejected</option>
                                <option value="A">Approved</option>
                                <!-- <option value="">Obsolete</option> -->
                            </select>
                        </div>
                        <div class="col-lg-2">
                            <br>
                            <button type="button" class="btn btn-default mt-2 btn-search"> 
                                <i class="fa fa-search"></i> Filter
                            </button>
                        </div>
                    </div>
                    <!-- <form action="" method="GET">
                    </form> -->
                    <hr>
                    <div class="row">
                        <div class="col-lg-12">
                            <table id="tbl-doclist" class="table table-bordered table-stripped table-sm">
                                <thead>
                                    <th style="width:30px;"></th>
                                    <th>No</th>
                                    <th>DCN Number</th>
                                    <th>Doc. Number</th>
                                    <th>Document Title</th>
                                    <th>Document Type</th>
                                    <th>Doc. Version</th>
                                    <th>Doc. Version Status</th>
                                    <th>Created Date</th>
                                    <th>Created By</th>
                                    <!-- <th></th> -->
                                </thead>
                                <tbody id="tbl-doclist-body">
                                
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
        // var _params = '';
        // ?datefrom=2022-08-02&dateto=2022-08-16
        $('.btn-search').on('click', function(){
            var param = '?datefrom='+ $('#datefrom').val() +'&dateto='+ $('#dateto').val()+'&doctype='+$('#doctype').val()+'&approvalstat='+$('#approvalStatus').val();
            loadDocument(param);
        })

        loadDocument('');

        function loadDocument(_params){
            $('#tbl-doclist').DataTable({
                // "dom": 'lBfrtip',
                "serverSide": true,
                    ajax: {
                        url: base_url+'/reports/loaddoclist'+_params,
                        data: function (data) {
                            data.params = {
                                sac: "sac"
                            }
                        }
                },
                "processing": true,
                "paging": true,
                "lengthChange": false,
                "searching": true,
                "ordering": true,
                "info": true,
                "autoWidth": false,
                "responsive": true,
                "bDestroy": true,
                // "processing": true,
                // "bDestroy": true,
                "bJQueryUI": true,
                columns: [
                    {
                        "className":      'details-control',
                        "orderable":      false,
                        "searchable": false,
                        "data":           null,
                        "defaultContent": '',
                        "width": "30px"
                    },
                    { "data": null,"sortable": false, "searchable": false,
                        render: function (data, type, row, meta) {
                            return meta.row + meta.settings._iDisplayStart + 1;
                        }  
                    },
                    {data: "dcn_number"},
                    {data: "document_number"},
                    {data: "document_title"},
                    {data: "doctype"},
                    {data: "doc_version"},
                    {data: "version_status"},
                    {data: "created_at",
                        render: function (data, type, row){
                            return `<i class="fa fa-clock"></i> `+ row.created_at.date1 + `<br>(`+ row.created_at.originaldate1 +`)`;
                        }
                    },
                    {data: "createdby"}
                ],
                "order": [[2, 'asc']]
            }); //.ajax.reload()
        }
        

        $('#tbl-doclist tbody').on('click', 'tr td.details-control', function () {
            let _token   = $('meta[name="csrf-token"]').attr('content');

            var tabledata = $('#tbl-doclist').DataTable();
            var tr = $(this).closest('tr');
            var row = tabledata.row( tr );
            var d = row.data();
            console.log(row.child.isShown())
            if ( row.child.isShown() ) {
                row.child.hide();
                tr.removeClass('shown');
            }else{
                $.ajax({
                    url: base_url+'/reports/documentlist/detail',
                    type: 'POST',
                    headers: {
                        'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                    },
                    data:{
                        docid: d.id,
                        version: d.doc_version,
                        _token: _token
                    },
                    dataType: 'json',
                    cache:false,
                    success: function(result){
                    },
                    error: function(err){
                        console.log(err)
                    }
                }).done(function(data){
                    
                    if ( row.child.isShown() ) {
                        row.child.hide();
                        tr.removeClass('shown');
                    }
                    else {
                        row.child( format(row.data(), data) ).show();
                        tr.addClass('shown');
                    }
                });
            }
        });

        $('#tbl-doclist tbody').on( 'click', '.button-view-detail', function () {                
            var table = $('#tbl-doclist').DataTable();
            selected_data = [];
            selected_data = table.row($(this).closest('tr')).data();
            window.location = base_url+"/transaction/doclist/detail/"+selected_data.id;
        });

        $('#tbl-doclist tbody').on( 'click', '.button-print', function () {                
            var table = $('#tbl-doclist').DataTable();
            selected_data = [];
            selected_data = table.row($(this).closest('tr')).data();
            // window.location = base_url+"/transaction/doclist/print/"+selected_data.id;
            window.open(
                base_url+"/transaction/doclist/print/"+selected_data.id,
                '_blank' // <- This is what makes it open in a new window.
            );
        });

        function format ( d, results ) {
            // console.log(results)
            var tdStyle = '';
            var appStat = '';
            var appNote = '';
            var appDate = '';
            var appBy   = '';
            
            var html = '';
            html = `<table class="table table-sm">
                   <thead>
                        <th>Approver Level</th>
                        <th>Approver Name</th>
                        <th>Approved By</th>
                        <th>Approver Remark</th>
                        <th>Approve/Reject Date</th>
                        <th>Status</th>
                   </thead>
                   <tbody>`;
                for(var i = 0; i < results.length; i++){
                    tdStyle = '';
                    appStat = '';
                    appNote = '';
                    appDate = '';
                    appBy   = '';

                    if(results[i].approval_status === 'A'){
                        tdStyle = "style='background-color:green; color:white;'";
                        appStat = 'Approved';
                    }else if(results[i].approval_status === 'R'){
                        tdStyle = "style='background-color:red; color:white;'";
                        appStat = 'Rejected';
                    }else if(results[i].approval_status === 'C'){
                        tdStyle = "style='background-color:#e08e13; color:white;'";
                        appStat = 'Obsolete';
                    }else{
                        tdStyle = "style='background-color:yellow;'";
                        appStat = 'Open';
                    }

                    if(results[i].approval_remark != null){
                        appNote = results[i].approval_remark;
                    }

                    if(results[i].approval_date != null){
                        appDate = results[i].approval_date;
                    }

                    if(results[i].approved_by != null){
                        appBy = results[i].approved_by;
                    }
                    
                    html +=`
                    <tr>
                            <td> `+ results[i].approver_level +` </td>
                            <td> `+ results[i].approver_name +` </td>
                            <td> `+ appBy +` </td>
                            <td> `+ appNote +` </td>
                            <td> `+ appDate +` </td>
                            <td `+ tdStyle +`> `+ appStat +` </td>
                    </tr>
                    `;
                }

            html +=`</tbody>
                    </table>`;
            return html;
        } 
    });
</script>
@endsection