#!/usr/bin/perl
use warnings;
use strict;
use Tie::Handle::CSV;
use JSON;
binmode(STDOUT, ":utf8");

my $json = JSON->new;

my %sepchar_options = ( 'colon' => ":",
                        'comma' => ",",
                        'tab'   => "\t",
                        'pipe'  => "|",
                      );
                      
my $sepchar = $sepchar_options{ $ARGV[2] } || ",";

my $infile = $ARGV[0] || 'Example.csv';
my $IN = Tie::Handle::CSV->new($infile, header => 1, sep_char => $sepchar);

my $outfile = $ARGV[1] ||  'Example.json';
open my $OUT, ">$outfile" or die "Can't open $outfile: $!\n";

print "... Converting '$infile' to '$outfile'\n";

my @fields = @{$IN->header};
my @data;
   
while (my $line = <$IN>) {

    my %hash;
    
    foreach my $field(@fields) {
        
        my $value = $line->{$field} || '';
            
        $hash{$field} = $value;
        
        };

    push @data, \%hash;   

    }

my $data_json = encode_json \@data;

say $OUT $data_json;
