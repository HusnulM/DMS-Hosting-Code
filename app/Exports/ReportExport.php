<?php

namespace App\Exports;

use Illuminate\Http\Request;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithMapping;
use DB;

class ReportExport implements FromCollection, WithHeadings, WithMapping
{
    /**
    * @return \Illuminate\Support\Collection
    */
    // use Exportable;
    protected $req;

    function __construct($req) {
        $this->req = $req;
    }

    public function collection()
    {
        $query   = DB::table('v_document_report');
        if(count($this->req->all()) > 0){
            if(isset($this->req->approvalstat)){
                if($this->req->approvalstat === "O"){
                    $query->where('version_status', 'Open');
                }elseif($this->req->approvalstat === "C"){
                    $query->where('version_status', 'Obsolete');                
                }elseif($this->req->approvalstat === "R"){
                    $query->where('version_status', 'Rejected');                
                }elseif($this->req->approvalstat === "A"){
                    $query->where('version_status', 'Approved');                
                }
            }
    
            if(isset($this->req->datefrom) && isset($this->req->dateto)){
                $query->whereBetween('crtdate', [$this->req->datefrom, $this->req->dateto]);
            }elseif(isset($this->req->datefrom)){
                $query->where('crtdate', $this->req->datefrom);
            }elseif(isset($this->req->dateto)){
                $query->where('crtdate', $this->req->dateto);
            }

            if(isset($this->req->doctype)){
                if($this->req->doctype == 'All'){

                }else{
                    $query->where('document_type', $this->req->doctype);
                }
            }
        }

        // $query->orderBy('created_at', 'DESC');

        return $query->get();
            //     DB::table('v_document_report')
            //    ->get();
    }

    public function map($row): array{
        $fields = [
           $row->dcn_number,
           $row->doctype,
           $row->document_number,
           $row->document_title,
           $row->doc_version,
           $row->effectivity_date,
           $row->established_date,
           $row->validity_date,
           $row->createdby,
           $row->created_at,
           $row->version_status,
        ];

        return $fields;
    }

    public function headings(): array
    {
        return [
                "DCN Number",
                "Document Type",
                "Document Number",
                "Document Title",
                "Document Version",
                "Effectivity Date",
                "Established Date",
                "Validity Date",
                "Created By",
                "Created Date",
                "Status"
        ];
    }
}
