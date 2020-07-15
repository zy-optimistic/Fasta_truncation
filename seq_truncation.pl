#! usr/bin/perl -w
use strict;
open IN , $ARGV[0] or die "There is something wrong : $!";
open OUT , "> $ARGV[1]";

my $id;
my %hash;

while (<IN>){
	chomp;
	if (/^>(.*?)\s+/){
		$id = $1;
	}else {
		$hash{$id} .= $_;
	}
}

my @range = split /:/ , $ARGV[3];

if (exists $hash{$ARGV[2]}){
	my $str = substr ($hash{$ARGV[2]} , ($range[0] - 1) , ($range[1] - $range[0] + 1));
	
	print OUT ">$ARGV[2]\n";

	my $start = 0;
	my $line;
	
	while ($start + 60 < length $str ){
		$line = substr ($str , $start , 60 );
		print OUT "$line\n";
		$start += 60;
	}
	
	if ($start + 60 >= length $str ){
		$line = substr ($str , $start , );
		print OUT "$line\n";
	}
	
}else {
	print "No $ARGV[2]!\n";
}

close IN;
close OUT;
