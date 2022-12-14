@extends('layouts/App')

@section('title', 'Rejected Document List')

@section('additional-css')
    <!-- <link rel="stylesheet" href="http://localhost:8181/digidocu/css/lte/AdminLTE.min.css"> -->
    <link rel="stylesheet" href="{{ asset('/assets/css/customstyle.css') }}">
@endsection

@section('content')
<div class="container-fluid">
    <div class="row">
        <div class="col-lg-12">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Rejected Document List</h3>
                </div>
                <div class="card-body">
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
                            <label for="">Document Type</label>
                            <select name="doctype" id="doctype" class="form-control">
                                <option value="All">All</option>
                                @foreach($doctypes as $key => $row)
                                <option value="{{ $row->id }}">{{ $row->doctype }}</option>
                                @endforeach
                            </select>
                        </div>
                        <div class="col-lg-3">
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
                                    <th>No</th>
                                    <th>DCN Number</th>
                                    <th>Document Title</th>
                                    <th>Document Type</th>
                                    <th>Doc. Number</th>
                                    <th>Created Date</th>
                                    <th>Last Change Date</th>
                                    <th>Created By</th>
                                    <th></th>
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
        // ?datefrom=2022-08-02&dateto=2022-08-16
        $('.btn-search').on('click', function(){
            $('#tbl-doclist-body').html('');
            var param = '?datefrom='+ $('#datefrom').val() +'&dateto='+ $('#dateto').val()+'&doctype='+$('#doctype').val();
            loadDocument(param);
        })

        loadDocument('');

        function loadDocument(_params){
            $('#tbl-doclist').DataTable({
                "serverSide": true,
                    ajax: {
                        url: base_url+'/document/rejectedlist/rejecteddoclist'+_params,
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
                columns: [
                    { "data": null,"sortable": false,  "searchable": false,
                        render: function (data, type, row, meta) {
                            return meta.row + meta.settings._iDisplayStart + 1;
                        }  
                    },
                    {data: "dcn_number"},
                    {data: "document_title"},
                    {data: "doctype"},
                    {data: "document_number"},
                    {data: "created_at",
                        render: function (data, type, row){
                            return `<i class="fa fa-clock"></i> `+ row.created_at.date1 + `<br>(`+ row.created_at.originaldate1 +`)`;
                        }
                    },
                    {data: "updated_at",
                        render: function (data, type, row){
                            return `<i class="fa fa-clock"></i> `+ row.updated_at.date2 + `<br>(`+ row.updated_at.originaldate2 +`)`;
                        }
                    },
                    {data: "createdby"},
                    {"defaultContent": 
                        `<button class='btn btn-primary btn-sm button-change'> <i class='fa fa-edit'></i> Change</button>
                        `
                    }
                ]  
            });
    
            $('#tbl-doclist tbody').on( 'click', '.button-change', function () {                
                var table = $('#tbl-doclist').DataTable();
                selected_data = [];
                selected_data = table.row($(this).closest('tr')).data();
                console.log(selected_data)
                window.location = base_url+"/document/rejectedlist/rejectdetail/"+selected_data.id+'/'+selected_data.latest_version;
                
            });
        }

    });
</script>
@endsection