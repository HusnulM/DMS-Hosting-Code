@extends('layouts/App')

@section('title', 'Master Approval')

@section('additional-css')
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script> 
<script type="text/javascript" src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css">
@endsection

@section('content')
<div class="container-fluid">
    
</div>
@endsection

@section('additional-js')
<script>
    $(document).ready(function(){
        $("#tbl-users").DataTable({
                serverSide: true,
                ajax: {
                    url: base_url+'/master/approval/approvallist',
                    data: function (data) {
                        data.params = {
                            sac: "sac"
                        }
                    }
                },
                buttons: false,
                searching: true,
                scrollY: 500,
                scrollX: true,
                scrollCollapse: true,
                columns: [
                    {data: "user_id", className: 'uid'},
                    {data: "first_name", className: 'fname'},
                    {data: "username", className: 'uname'},
                    {data: "gender", className: 'gender'}
                
                ]  
        });
    });
</script>
@endsection