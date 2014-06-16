#!/usr/bin/env perl
# vim:tabstop=2:autoindent:expandtab:shiftwidth=2
#
# Author: JLC
# Purpose:
#   Get hadoop benchmark runtime statistics
# Usage: Provide as parameter the name of the log file
# Return: 0 if success, 1 if error
#

use warnings;
use strict;
use Math::NumberCruncher;


#my $filename="run_benchmarks.log";
my $filename=$ARGV[0]; 
open(my $fh,$filename) or die "Could not open file '$filename' $!";

my $num_tt=0;
my $num_dn;
my @wc_time;
my $n;
my $nextline;

while (<$fh>) {
	
	/Datanodes available: (\d+)/ and do {
		$num_dn=$1;
	};

	/^tracker_hadoop/ and do {
		$num_tt++;
	};
	
	/^==> time hadoop / and do {
		
		WC: while (<$fh>) {
			/Run (\d)/ and do {
				$n=$1-1;
			};
			/real\s+(\d+)m(\d+\.\d+)s/ and do {
				#print "DEBUG: ".$_;
				$wc_time[$n]=$1*60+$2;
				#print "DEBUG: $wc_time[$n]\n";
			};
		}
	};

}

close($fh);

# Put
my $wc_avg = sprintf '%.1f', Math::NumberCruncher::Mean(\@wc_time);
my $wc_std = sprintf '%.1f', Math::NumberCruncher::StandardDeviation(\@wc_time);
print "Put time (avg / std): $wc_avg / $wc_std \n";


