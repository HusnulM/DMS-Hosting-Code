@extends('layouts/App')

@section('title', 'Document Areas')

@section('content')
<div class="container-fluid">
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Document Areas List</h3>
                    <div class="card-tools">
                        <button type="button" class="btn btn-success btn-sm btn-add-doctype">
                            <i class="fas fa-plus"></i> Create Document Areas
                        </button>
                        <!-- <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                            <i class="fas fa-minus"></i>
                        </button>
                        <button type="button" class="btn btn-tool" data-card-widget="remove" title="Remove">
                            <i class="fas fa-times"></i>
                        </button> -->
                    </div>
                </div>
                <div class="card-body">
                    <table id="tbl-doctype" class="table table-bordered table-hover table-striped table-sm" style="width:100%;">
                        <thead>
                            <th style="width:100px;">No</th>
                            <th>Document Areas</th>
                            <th>Email</th>
                            <th style="width:240px; text-align:center;"></th>
                        </thead>
                        <tbody>
                            @foreach($docarea as $key => $row)
                            <tr>
                                <td>{{$key+1}}</td>
                                <td>{{ $row->docarea }}</td>
                                <td>{{ $row->mail }}</td>
                                <td style="text-align:center;">
                                    <a href="{{ url('master/docarea/delete') }}/{{$row->id}}" class="btn btn-danger btn-sm button-delete"> <i class='fa fa-trash'></i> DELETE</a> 
                                    <button type="button" class="btn btn-primary btn-sm button-edit" data-docareaid="{{$row->id}}" data-docarea="{{$row->docarea}}" data-email="{{$row->mail}}"> <i class='fa fa-edit'></i> EDIT</button>
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
@endsection

@section('additional-modal')
<div class="modal fade" id="modal-add-doctype">
    <form action="{{ url('master/docarea/save') }}" method="post">
        @csrf
        <div class="modal-dialog modal-md">
          <div class="modal-content">
            <div class="modal-header">
              <h4 class="modal-title">Create Document Areas</h4>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-lg-12">
                         <label for="docarea">Document Areas</label>
                         <input type="text" name="docarea" class="form-control" autocomplete="off" required>
                    </div> 
                    <div class="col-lg-12">
                         <label for="email">Email</label>
                         <input type="email" name="email" class="form-control" autocomplete="off" required>
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

<div class="modal fade" id="modal-edit-doctype">
    <form action="{{ url('master/docarea/update') }}" method="post">
        @csrf
        <div class="modal-dialog modal-md">
          <div class="modal-content">
            <div class="modal-header">
              <h4 class="modal-title">Edit Document Areas</h4>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-lg-12">
                         <label for="docarea">Document Areas</label>
                         <input type="text" name="docarea" id="docarea" class="form-control" autocomplete="off" required>
                         <input type="hidden" name="docareaid" id="docareaid" class="form-control" autocomplete="off">
                    </div> 
                    <div class="col-lg-12">
                         <label for="email">Email</label>
                         <input type="email" name="email" id="email" class="form-control" autocomplete="off" required>
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
    $(document).ready(function(){
        $('#tbl-doctype').DataTable();

        $('.btn-add-doctype').on('click', function(){
            $('#modal-add-doctype').modal('show');
        });

        $('.button-edit').on('click', function(){
            var _data = $(this).data();
            $('#docareaid').val(_data.docareaid);
            $('#docarea').val(_data.docarea);
            $('#email').val(_data.email);
            $('#modal-edit-doctype').modal('show');
        });

        // $('#tbl-roles tbody').on( 'click', '.button-delete', function () {
        //     var table = $('#tbl-users').DataTable();
        //     selected_data = [];
        //     selected_data = table.row($(this).closest('tr')).data();
        //     window.location = base_url+"/config/users/delete/"+selected_data.id;
        // });
        // $('#tbl-roles tbody').on( 'click', '.button-edit', function () {
        //     var table = $('#tbl-users').DataTable();
        //     selected_data = [];
        //     selected_data = table.row($(this).closest('tr')).data();
        //     window.location = base_url+"/config/users/edit/"+selected_data.id;
        // });
    });
</script>
@endsection