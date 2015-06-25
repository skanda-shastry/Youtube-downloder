#!/usr/bin/perl 

use CGI;
use strict;
use warnings;
use WWW::YouTube::Download;
use WWW::YouTube::Info::Simple;
use Data::Dumper;

print qq(Content-type: text/plain\n\n);
my $cgi = CGI->new;
my $url = $cgi->param("url");

if ($url) {
	my $tube = WWW::YouTube::Download->new;
	my $video_id =  $tube->video_id($url);
	my $yt = WWW::YouTube::Info::Simple->new($video_id);
	my $info = $yt->get_info();
	if($info->{status} eq 'fail')	
	{
		print "Requested Resource not available in Server \n";
	}	 
	else
	{
		$tube->download($video_id, { filename => '{title}.{suffix}' });
		print "Sucessfully download the video.\n";
	}	
}
else
{
	print "Enter the  valid Video URL in the above box \n";
}	

