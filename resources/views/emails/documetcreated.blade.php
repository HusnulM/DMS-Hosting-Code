<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document Created {{ $data['dcnNumb'] }}</title>

    <style>
        #customers {
            font-family: Arial, Helvetica, sans-serif;
            border-collapse: collapse;
            width: 100%;
        }

        #customers td, #customers th {
            border: 1px solid #ddd;
            padding: 8px;
        }

        #customers tr:nth-child(even){background-color: #f2f2f2;}

        #customers tr:hover {background-color: #ddd;}

        #customers th {
            padding-top: 12px;
            padding-bottom: 12px;
            text-align: left;
            background-color: #04AA6D;
            color: white;
        }
    </style>
</head>
<body>
    <b>Good day!,</b><br>

    <p>A New document has been created for your review and approval.</p>
    <table id="customers">
        <thead>
            <th>DCN Number</th>
            <th>Document Title</th>
            <th>Date Created</th>
            <th>Originator</th>
        </thead>
        <tbody>
            <tr>
                <td>
                    <a href="{{ url('/transaction/docapproval/approve/detail') }}/{{ $data['docID'] }}" target="_blank">{{ $data['dcnNumb'] }}</a> 
                </td>
                <td>{{ $data['docTitle'] }}</td>
                <td>{{ $data['docCrdt'] }}</td>
                <td>{{ $data['docCrby'] }}</td>
            </tr>
        </tbody>
    </table>
   
    <p><b>Thank you.</b></p>
    <p>***This is system generated e-mail, please do not reply***</p>
</body>
</html>