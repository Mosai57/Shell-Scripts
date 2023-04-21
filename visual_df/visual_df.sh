#!/usr/bin/env perl
use strict;
use warnings;

my @results = `df -h`;
my %data;

my $border = "+";
for(1..100){
	$border .= "-";
}
$border .= "+\n";


foreach (@results) {
	next if $_ =~ /Use%/;

	$_ =~ s/%//;

	my @exp = split(/\s+/, $_);


	$data{$exp[5]}->{cap} = $exp[1];
	$data{$exp[5]}->{used} = $exp[2];
	$data{$exp[5]}->{free} = $exp[3];
	$data{$exp[5]}->{pctg} = $exp[4];
}

my @keys = keys %data;
@keys = sort @keys;


foreach(@keys){
	my $stat_bar = "";
	my $len = $data{$_}->{pctg};
        for(my $ctr = 0; $ctr < $len; $ctr++){
                $stat_bar .= "■";
        }

        $data{$_}->{bar} = " " . sprintf("%-100s", $stat_bar) . "";
}

foreach(@keys){
	print sprintf("Drive: %-20s Size: %-8s Used: %-8s Free: %-8s", $_, $data{$_}->{cap}, $data{$_}->{used}, $data{$_}->{free}) . "\n";;
	print $border;
	print $data{$_}->{bar} . "\n";
	print $border . "\n";
}
