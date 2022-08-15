<?php

namespace App\Jobs;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldBeUnique;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use App\Mail\MailNotif;
use Mail;

class SendEmailJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;
    protected $data;
    public $mailto = array();
    /**
     * Create a new job instance.
     *
     * @return void
     */
    public function __construct($data, $mailto = array())
    {
        $this->data   = $data;
        $this->mailto = $mailto;
    }

    /**
     * Execute the job.
     *
     * @return void
     */
    public function handle()
    {
        // dd($this->mailto);
        $email = new MailNotif($this->data);
        Mail::to($this->mailto)->send($email);
    }
}
