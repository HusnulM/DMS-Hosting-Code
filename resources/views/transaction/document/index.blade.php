@extends('layouts/App')

@section('title', 'Create Document')

@section('additional-css')
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
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
            <form action="{{ url('transaction/document/save') }}" method="post" enctype="multipart/form-data">
                @csrf
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">Create Document</h3>
                        <div class="card-tools">
                            <button type="submit" class="btn btn-primary btn-sm">
                                <i class="fas fa-save"></i> SAVE
                            </button>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-lg-6">
                                <div class="row">
                                    <div class="col-lg-12 col-sm-12 form-group">
                                        <label for="doctitle">Document Title</label>
                                        <input type="text" class="form-control" name="doctitle" id="doctitle" placeholder="Document Title" required>
                                    </div>   
                                    <div class="col-lg-6 col-sm-12 form-group">
                                        <label for="doctype">Document Type</label>
                                        <select name="doctype" id="doctype" class="form-control">
                                            @foreach($doctypes as $key => $row)
                                                <option value="{{ $row->id }}">{{ $row->doctype }}</option>
                                            @endforeach
                                        </select>
                                    </div>    
                                    <div class="col-lg-6 col-sm-12 form-group">
                                        <label for="doclevel">Document Level</label>
                                        <select name="doclevel" id="doclevel" class="form-control">
                                            @foreach($doclevels as $key => $row)
                                                <option value="{{ $row->id }}">{{ $row->doclevel }}</option>
                                            @endforeach
                                        </select>
                                    </div>
                                    <div class="col-lg-6 col-sm-12 form-group">
                                        <label for="effectivedate">Effectivity Date</label>
                                        <input type="date" name="effectivedate" class="form-control" required>
                                    </div>
                                    <div class="col-lg-6 col-sm-12 form-group">
                                        <label for="docnumber">Document Number</label>
                                        <input type="text" name="docnumber" class="form-control">
                                    </div>
                                    <div class="col-lg-12 col-sm-12 form-group">
                                        <label for="docfiles">Document Attachment</label>
                                        <input type="file" name="docfiles[]" class="form-control" multiple="multiple" required>
                                    </div>
                                </div>
                            </div>      
                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label for="docremark">Document Remark</label>
                                    <textarea class="docremark form-control" name="docremark"></textarea>
                                </div>   
                            </div>
                        </div>
                        <hr>
                        <div class="row">
                            <div class="col-lg-6">
                                <h5>Document Area</h5>
                                <table id="tbl-doc-area" class="table table-bordered table-stripped table-sm">
                                    <thead>
                                        <th>Document Area</th>
                                        <th style="width: 100px; text-align:center;">
                                            <button type="button" class="btn btn-success btn-sm btn-select-docarea">
                                                <i class="fa fa-plus"></i>
                                            </button>
                                        </th>
                                    </thead>
                                    <tbody class="mainbodynpo" id="tbl-doc-area-body">

                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
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

        $('.docremark').ckeditor();
    });
</script>
@endsection