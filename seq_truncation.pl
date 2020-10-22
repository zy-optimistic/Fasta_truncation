#! /usr/bin/perl -w
use strict;

die(qq /[seq_truncation.pl]
Truncate part of a sequence and print with 60 bases a line.
*********************************************
Command :

perl seq_truncation.pl file1 file2 name_of_sequence num1:num2.

Parameters :
file1 ：input file ;
file2 : output file ;
name_of_sequence : name of the sequence that you want to Truncate ;
num1:num2 : start number and end number separate with a ":" .
/) if @ARGV != 4;

open IN , $ARGV[0] or die "There is something wrong : $!";
open OUT , "> $ARGV[1]";

my $id;
my $seq;
my %hash;

$/ = ">";
while (<IN>){
	chomp;
	
	if (/^($ARGV[2])/){
		$id = $1;
		$_ =~ s/($id)(.*?)\n|\n//g;
		$seq = $_;
	}
}

my @range = split /[-:~]/ , $ARGV[3];

if (defined $seq){
	my $str = substr ($seq , ($range[0] - 1) , ($range[1] - $range[0] + 1));
	
	print OUT ">$id\n";

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
