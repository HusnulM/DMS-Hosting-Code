<?php
    $firstApproval      = false;
    $secondApprocal     = false;
    $thirdApproval      = false;
    $firstApprvalName   = null;
    $firstApprovalSign  = null;
    $thirdApprovalSign  = null;
    $secondApprvalName  = null;
    $secondApprovalSign = null;
    $thirdApprovalName  = null;

    foreach($approval as $key => $row ){
        if($row->approver_level == 1 && $row->approval_status === 'A'){
            $firstApproval     = true;
            $firstApprvalName  = $row->approved_by;
            $firstApprovalSign = $row->esign;
        }elseif($row->approver_level == 2 && $row->approval_status === 'A'){
            $secondApprocal     = true;
            $secondApprvalName  = $row->approved_by;
            $secondApprovalSign = $row->esign;
        }elseif($row->approver_level == 3 && $row->approval_status === 'A'){
            $thirdApproval     = true;
            $thirdApprovalName = $row->approved_by;
            $thirdApprovalSign = $row->esign;
        }
    }
?>

<!DOCTYPE html>
<html>
<head>
	<title>Document Printout</title>
	<style>
        .customers {
            font-family: Arial, Helvetica, sans-serif;
            border-collapse: collapse;
            width: 100%;
            font-size:10px;
            margin-bottom:5px;
        }

        .customers td, .customers th {
            border: 1px solid #000;
            padding: 5px;
        }

        /* .customers tr:nth-child(even){background-color: #f2f2f2;}

        .customers tr:hover {background-color: #ddd;} */

        .customers th {
            padding-top: 12px;
            padding-bottom: 12px;
            text-align: left;
            color: black;
        }
    </style>
</head>
<body> 
    <table class="customers" style="margin-bottom: 20px !important;">
        <thead>
            <tr style="text-align:center;font-weight:bold;">
                <td style="width:120px;">
                <!-- LOGO -->
                </td>
                <td style="width:120px;">PREPARED</td>
                <td style="width:120px;">CHECKED</td>
                <td style="width:120px;">APPROVED</td>
                <td style="width:120px;">APPROVED</td>
            </tr>
            <tr style="text-align:center;">
                <td  style="height:60px;">
                <!-- $logo -->
                    @if($logo->setting_value != null)
                        <img src="{{ public_path($logo->setting_value ?? '') }}" class="img-thumbnail" alt="E-Logo" style="width:90px; height:60px;">
                    @endif
                </td>
                <td style="height:60px;">
                    <img src="{{ public_path($creatorSignature->s_signfile ?? '') }}" class="img-thumbnail" alt="E-sign" style="width:100px; height:100px;">
                </td>
                <td>
                    @if($firstApproval == true && $firstApprovalSign != null)
                        <img src="{{ public_path($firstApprovalSign) }}" class="img-thumbnail" alt="E-sign" style="width:100px; height:100px;">
                    @endif
                </td>
                <td>
                    @if($secondApprocal == true && $secondApprovalSign != null)
                        <img src="{{ public_path($secondApprovalSign) }}" class="img-thumbnail" alt="E-sign" style="width:100px; height:100px;">
                    @endif                    
                </td>
                <td>
                    @if($thirdApproval == true && $thirdApprovalSign != null)
                        <img src="{{ public_path($secondApprovalSign) }}" class="img-thumbnail" alt="E-sign" style="width:100px; height:100px;">
                    @endif
                </td>
            </tr>
            <tr style="text-align:center;font-weight:bold;">
                <td>&nbsp;</td>
                <td>
                    {{ $creatorSignature->name }}
                </td>
                <td>
                    @if($firstApproval == true)
                        {{ $firstApprvalName }}
                    @endif
                </td>
                <td>
                    @if($secondApprocal == true)
                        {{ $secondApprvalName }}
                    @endif
                </td>
                <td>
                    @if($thirdApproval == true)
                        {{ $thirdApprovalName }}
                    @endif
                </td>
            </tr>
        </thead>
        <tfoot style="font-weight:bold;">
            <tr>
                <td colspan="3">DOCUMENT NO : {{ $document->dcn_number }} - ({{ $document->document_number }})</td>
                <td></td>
                <td>REVISION NO : {{ $document->revision_number }}</td>
            </tr>
            <tr>
                <td colspan="3">DATE : {{ formatDate($document->created_at) }}</td>
                <td></td>
                <td></td>
            </tr>
            <tr>
                <td colspan="4">TITLE : {{ $document->document_title }}</td>
                <td></td>
            </tr>
        </tfoot>
    </table>
    
    <table class="customers">
        <thead>
            <td style="text-align:center;">
                REVISION HISTORY
            </td>
        </thead>
    </table>
    <!-- <br> -->
    <table class="customers">
        <thead style="font-weight:bold;">
            <td>REV #</td>
            <td>DCF NO.</td>
            <td>CHANGE DESCRIPTION</td>
            <td>REVISION DATE</td>
            <td>EFFECTIVITY</td>
        </thead>
        <tbody>
            @foreach($versions as $key => $row)
            <tr>
                <td>{{ $row->doc_version }}</td>
                <td></td>
                @if($row->doc_version == 1)
                <td>Origination</td>
                @else
                <td>{!! $row->remark !!}</td>
                @endif
                <td>{{ formatDate($row->createdon) }}</td>
                <td>{{ formatDate($row->effectivity_date) }}</td>
            </tr>
            @endforeach
        </tbody>
    </table>
</body>
</html>