@extends('layouts/App')

@section('title', 'Dashboard')

@section('content')
<div class="container-fluid">
    <div class="row">
        <div class="col-lg-3 col-md-6 col-sm-12">
            <div class="small-box bg-info">
                <div class="inner">
                    <h3>{{ $totalOpen }}</h3>
                    <p>Need to Approve</p>
                </div>
                <div class="icon">
                    <i class="ion ion-bag"></i>
                </div>
                <a href="{{ url('transaction/docapproval') }}" class="small-box-footer">
                    More info <i class="fas fa-arrow-circle-right"></i>
                </a>
            </div>
        </div>

        <div class="col-lg-3 col-md-6 col-sm-12">
            <div class="small-box bg-danger">
                <div class="inner">
                    <h3>{{ $totalRejected }}</h3>
                    <p>Rejected</p>
                </div>
                <div class="icon">
                    <i class="ion ion-pie-graph"></i>
                </div>
                <a href="#" class="small-box-footer">
                    More info <i class="fas fa-arrow-circle-right"></i>
                </a>
            </div>
        </div>

        <div class="col-lg-3 col-md-6 col-sm-12">
            <div class="small-box bg-success">
                <div class="inner">
                    <h3>{{ $totalApproved }}</h3>
                    <p>Approved</p>
                </div>
                <div class="icon">
                    <i class="ion ion-pie-graph"></i>
                </div>
                <a href="#" class="small-box-footer">
                    More info <i class="fas fa-arrow-circle-right"></i>
                </a>
            </div>
        </div>

        <div class="col-lg-3 col-md-6 col-sm-12">
            <div class="small-box bg-blue">
                <div class="inner">
                    <h3>{{ $totalObsolete }}</h3>
                    <p>Obsolete</p>
                </div>
                <div class="icon">
                    <i class="ion ion-pie-graph"></i>
                </div>
                <a href="#" class="small-box-footer">
                    More info <i class="fas fa-arrow-circle-right"></i>
                </a>
            </div>
        </div>
    </div>

</div>
@endsection