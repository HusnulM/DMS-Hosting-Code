@extends('layouts/App')

@section('title', 'Create Work Standard Document')

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
            <form action="{{ url('/document/v3/save') }}" method="post" enctype="multipart/form-data">
                @csrf
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">Create Work Standard Document</h3>
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
                                    <div class="col-lg-12 col-md-6 col-sm-12 form-group">
                                        <label for="doctitle">Document Title</label>
                                        <input type="text" class="form-control" name="doctitle" id="doctitle" placeholder="Document Title" required>
                                    </div>   
                                    <div class="col-lg-6 col-md-6 col-sm-12 form-group">
                                        <label for="processname">Process Name</label>
                                        <input type="text" class="form-control" name="processname" id="processname" placeholder="Process Name" required>
                                    </div>   
                                    <div class="col-lg-6 col-md-6 col-sm-12 form-group">
                                        <label for="product">Product Name</label>
                                        <input type="text" class="form-control" name="product" id="product" placeholder="Product Name" required>
                                    </div>   
                                    <div class="col-lg-12 col-md-6 col-sm-12 form-group">
                                        <label for="customer">Customer</label>
                                        <select name="customer" id="find-customer" class="form-control"></select>
                                    </div>   
                                    <div class="col-lg-6 col-md-6 col-sm-12 form-group">
                                        <label for="doctype">Document Type</label>
                                        <select name="doctype" id="doctype" class="form-control">
                                            @foreach($doctypes as $key => $row)
                                                <option value="{{ $row->id }}">{{ $row->doctype }}</option>
                                            @endforeach
                                        </select>
                                    </div>    
                                    <div class="col-lg-6 col-md-6 col-sm-12 form-group">
                                        <label for="model">Model</label>
                                        <select name="model" id="find-model" class="form-control"></select>
                                    </div>
                                    <div class="col-lg-6 col-sm-12 form-group">
                                        <label for="assycode">Assy Code</label>
                                        <input type="text" name="assycode" id="assycode" class="form-control" required>
                                    </div>
                                    <div class="col-lg-6 col-sm-12 form-group">
                                        <label for="section">Section</label>
                                        <input type="text" name="section" class="form-control" required>
                                    </div>
                                    <div class="col-lg-6 col-sm-12 form-group">
                                        <label for="estabdate">Established Date</label>
                                        <input type="date" name="estabdate" class="form-control" required>
                                    </div>
                                    <div class="col-lg-6 col-sm-12 form-group">
                                        <label for="effectdate">Effectivity Date</label>
                                        <input type="date" name="effectdate" class="form-control" required>
                                    </div>
                                    <div class="col-lg-12 col-sm-12 form-group">
                                        <label for="docfiles">Document Attachment</label>
                                        <input type="file" name="docfiles[]" class="form-control" multiple="multiple" required>
                                    </div>
                                </div>
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

<script src="{{ asset('/assets/js/select2.min.js') }}"></script>
<!-- <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script> -->
<script type="text/javascript">
    $(document).ready(function () {        
        var count = 0;

        let _token   = $('meta[name="csrf-token"]').attr('content');
       
        $(document).on('select2:open', (event) => {
            const searchField = document.querySelector(
                `.select2-search__field`,
            );
            if (searchField) {
                searchField.focus();
            }
        });

        $('#find-customer').select2({ 
            placeholder: 'Type Customer Name',
            width: '100%',
            minimumInputLength: 0,
            ajax: {
                url: base_url + '/master/customer/findcustomer',
                dataType: 'json',
                delay: 250,
                method: 'POST',
                headers: {
                    'X-CSRF-TOKEN': _token
                },
                data: function (params) {
                    var query = {
                        search: params.term,
                        // custname: $('#find-customer').val()
                    }
                    return query;
                },
                processResults: function (data) {
                    // return {
                    //     results: response
                    // };
                    console.log(data)
                    return {
                        results: $.map(data.data, function (item) {
                            return {
                                text: item.customer_name,
                                slug: item.customer_name,
                                id: item.customer_name,
                                ...item
                            }
                        })
                    };
                },
                cache: true
            }
        });

        $('#find-model').select2({ 
            placeholder: 'Type Model Name',
            width: '100%',
            minimumInputLength: 3,
            ajax: {
                // url: 'https://ipdsystem.toekangketik.com/ipdfordms/searchAssycode',
                url: '{{ $ipdapi->setting_value ?? '' }}',
                dataType: 'json',
                delay: 250,
                data: function(data){
                    return{
                        searchName: data.term
                    }
                },
                processResults: function (data) {
                    return {
                        results: $.map(data.data, function (item) {                            
                            return {
                                text: item.matdesc,
                                slug: item.material,
                                id: item.matdesc,
                                ...item
                            }
                        })
                    };
                },
            }
        });

        $('#find-model').on('change', function(){
            // alert(this.value)
            
            var data = $('#find-model').select2('data')
            console.log(data);

            // alert(data[0].material);
            $('#assycode').val(data[0].material);
        });
    });
</script>
@endsection