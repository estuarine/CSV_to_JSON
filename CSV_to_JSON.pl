#!/usr/bin/perl
use warnings;
use strict;
use Tie::Handle::CSV;
use JSON;
binmode(STDOUT, ":utf8");

my $json = JSON->new;

my ($IN, $infile, $OUT, $outfile) = process_input(@ARGV); 

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

print $OUT $data_json;

exit;

####################################

sub process_input {

    my @ARGV = @_;

    my %sepchar_options = ( "colon" => ":",
                            "comma" => ",",
                            "pipe"  => "|",
                            "tab"   => "\t",
                           );
                      
    my $sepchar_input = $ARGV[2] || "comma";
    my $sepchar = $sepchar_options{$sepchar_input} || ",";

    my $infile = $ARGV[0] || 'Example.csv';
    my $IN = Tie::Handle::CSV->new($infile, header => 1, sep_char => $sepchar);

    my $outfile = $ARGV[1] || 'Example.json';
    open my $OUT, ">$outfile" or die "Can't open $outfile: $!\n";

    return ($IN, $infile, $OUT, $outfile);

    }
