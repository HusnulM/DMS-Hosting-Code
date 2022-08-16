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
                <td style="width:120px;"></td>
                <td style="width:120px;">PREPARED</td>
                <td style="width:120px;">CHECKED</td>
                <td style="width:120px;">APPROVED</td>
                <td style="width:120px;">APPROVED</td>
            </tr>
            <tr style="text-align:center;">
                <td rowspan="2">&nbsp;</td>
                <td style="height:60px;">
                    <img src="{{ public_path('/files/e_signature/esign1.png') }}" class="img-thumbnail" alt="E-sign" style="width:100px; height:100px;">
                </td>
                <td>
                    <img src="{{ public_path('/files/e_signature/esign1.png') }}" class="img-thumbnail" alt="E-sign" style="width:100px; height:100px;">
                </td>
                <td>
                    <img src="{{ public_path('/files/e_signature/esign1.png') }}" class="img-thumbnail" alt="E-sign" style="width:100px; height:100px;">
                </td>
                <td>
                    <img src="{{ public_path('/files/e_signature/esign1.png') }}" class="img-thumbnail" alt="E-sign" style="width:100px; height:100px;">
                </td>
            </tr>
            <tr style="text-align:center;font-weight:bold;">
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>
                    Approver1
                </td>
                <td>
                    Approver2
                </td>
            </tr>
        </thead>
        <tfoot style="font-weight:bold;">
            <tr>
                <td colspan="3">DOCUMENT NO : {{ $document->document_number }}</td>
                <td></td>
                <td>REVISION NO : {{ $document->revision_number }}</td>
            </tr>
            <tr>
                <td colspan="3">DATE</td>
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
            <tr>
                <td>00</td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
        </tbody>
    </table>
</body>
</html>