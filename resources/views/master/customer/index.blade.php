@extends('layouts/App')

@section('title', 'Customer Master')

@section('additional-css')
    <!-- <link rel="stylesheet" href="http://localhost:8181/digidocu/css/lte/AdminLTE.min.css"> -->
    <link rel="stylesheet" href="{{ asset('/assets/css/customstyle.css') }}">

    <style>
        td.details-control {
            background: url("{{ asset('/assets/dist/img/show_detail.png') }}") no-repeat center center;
            cursor: pointer;
        }
        tr.shown td.details-control {
            background: url("{{ asset('/assets/dist/img/close_detail.png') }}") no-repeat center center;
        }
    </style>
@endsection

@section('content')
<div class="container-fluid">
    <div class="row">
        <div class="col-lg-12">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Customer Master</h3>
                    <div class="card-tools">
                        <button type="button" class="btn btn-success btn-sm btn-add-customer">
                            <i class="fa fa-plus"></i> Add New Customer
                        </button>
                    </div>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-lg-12">
                            <table id="tbl-customer" class="table table-bordered table-stripped table-sm">
                                <thead>
                                    <th style="width:50px;">No</th>
                                    <th>Customer Name</th>
                                    <th style="width:150px;"></th>
                                </thead>
                                <tbody id="tbl-customer-body">
                                
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

@section('additional-modal')
<div class="modal fade" id="modal-add-customer">
    <form action="{{ url('master/customer/save') }}" method="post">
        @csrf
        <div class="modal-dialog modal-lg">
          <div class="modal-content">
            <div class="modal-header">
              <h4 class="modal-title">Add New Customer</h4>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-lg-12">
                        <table id="tbl-email-rec" class="table">
                            <thead>
                                <th>Customer Name</th>
                                <th style="text-align:center; width:80px;">
                                    <button type="button" class="btn btn-success btn-sm btnAddCust">
                                        <i class="fa fa-plus"></i>
                                    </button>
                                </th>
                            </thead>
                            <tbody id="tbl-cust-data">

                            </tbody>
                        </table>
                        <!-- <label for="email">Email</label>
                        <input type="email" name="email" class="form-control" autocomplete="off" required> -->
                    </div> 
                </div>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="submit" class="btn btn-primary">
                    <i class="fa fa-save"></i> Save
                </button>
            </div>
          </div>
        </div>
    </form>
</div>

<div class="modal fade" id="modal-update-customer">
    <form action="{{ url('master/customer/update') }}" method="post">
        @csrf
        <div class="modal-dialog modal-lg">
          <div class="modal-content">
            <div class="modal-header">
              <h4 class="modal-title">Update Customer</h4>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-lg-12">
                        <input type="hidden" name="custid" id="custid">
                        <input type="text" name="custname" id="custname" class="form-control">
                    </div> 
                </div>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="submit" class="btn btn-primary">
                    <i class="fa fa-save"></i> Save
                </button>
            </div>
          </div>
        </div>
    </form>
</div>
@endsection

@section('additional-js')
<script>
    $(function(){       
        
        $('.btn-add-customer').on('click', function(){
            $('#modal-add-customer').modal('show');
        });

        $('.btnAddCust').on('click', function(){
           $('#tbl-cust-data').append(`
                <tr>
                    <td>
                        <input type="text" name="custname[]" class="form-control" autocomplete="off" required style="height: calc(2rem + 2px) !important;">
                    </td>
                    <td style="text-align:center;">
                        <button type="button" class="btn btn-danger btn-sm btnRemove">
                            <i class="fa fa-trash"></i>
                        </button>
                    </td>
                </tr>
           `); 

           $('.btnRemove').on('click', function(e){
                e.preventDefault();
                $(this).closest("tr").remove();
            });
        });

        loadDocument('');

        function loadDocument(_params){
            $('#tbl-customer').DataTable({
                // "dom": 'lBfrtip',
                "serverSide": true,
                    ajax: {
                        url: base_url+'/master/customer/lists'+_params,
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
                    
                    { "data": null,"sortable": false, "searchable": false,
                        render: function (data, type, row, meta) {
                            return meta.row + meta.settings._iDisplayStart + 1;
                        }  
                    },
                    {data: "customer_name"},
                    {"defaultContent": 
                        `<button class='btn btn-primary btn-sm button-edit'> <i class='fa fa-edit'></i> Edit</button>
                         <button class='btn btn-danger btn-sm button-delete'> <i class='fa fa-trash'></i> Delete</button>
                        `
                    }
                ]
            }); //.ajax.reload()
        }

        $('#tbl-customer tbody').on( 'click', '.button-edit', function () {
            var table = $('#tbl-customer').DataTable();
            selected_data = [];
            selected_data = table.row($(this).closest('tr')).data();
            // window.location = base_url+"/master/customer/delete/"+selected_data.customerid;
            $('#custid').val(selected_data.customerid);
            $('#custname').val(selected_data.customer_name);
            $('#modal-update-customer').modal('show');
        });

        $('#tbl-customer tbody').on( 'click', '.button-delete', function () {
            var table = $('#tbl-customer').DataTable();
            selected_data = [];
            selected_data = table.row($(this).closest('tr')).data();
            window.location = base_url+"/master/customer/delete/"+selected_data.customerid;
        });
    });
</script>
@endsection