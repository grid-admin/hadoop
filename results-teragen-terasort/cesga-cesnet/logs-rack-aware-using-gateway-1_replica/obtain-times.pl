#!/usr/bin/env perl
use warnings;
use strict;
use autodie;
use Carp;
use 5.012;

my @logs;

my $tail;
my $time;
my %results;

#@logs = <teragen*.log>;
@logs = <*.log>;
FILE:
for my $log (@logs) {
    my $ok = 1;
    open my $fh, '<', $log;
    while (<$fh>) {
        /mapred.JobClient: Job Failed:/ and do {
            $ok = 0;
        };
        /^real\W+(\d+)m(\d+\.\d+)s/ and do {
            # Skip if the job did not finish correctly
            next FILE if not $ok;

            $time = sprintf '%0.f', $1 * 60 + $2;
            if ($log =~ /(teragen|terasort)-(\d+)G-\d+-(\d)\.log/) {
                $1 eq "teragen" ? $results{$2}->[0][$3]=$time : $results{$2}->[1][$3]=$time;
            } else {
                croak "Error parsing filename $log to assign values";
            }
            next FILE;
        };
    }
    close $fh ;
}

for my $replicas (3, 2, 1) {
    for my $size (sort keys %results) {
        say $size . 'GB'
            . ' & ' . $replicas
            . ' & ' . ( $results{$size}->[0][$replicas] || 'Failed' )
            . ' & ' . ( $results{$size}->[1][$replicas] || 'Failed' )
            . ' \\\\';
    }
}

