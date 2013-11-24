#!/usr/bin/perl
package CSV_to_JSON_class;
use Modern::Perl;
use Moose;
use Tie::Handle::CSV;
use JSON;
use Data::Dumper;
use List::MoreUtils qw(natatime);
binmode(STDOUT, ":utf8");

# Object-oriented version of CSV_to_JSON.pl for use in other scripts

has [qw/ inputfile outputfile sepchar /] => ( is => 'rw', isa => 'Str' );

# Make the class immutable to speed up Moose's performance
__PACKAGE__->meta->make_immutable;


###############################################################

sub convert {

    my $self = shift;
    
    if (@_) {

        my $it = natatime 2, @_;

        while (my ($key, $value) = $it->() ) {
            $self->{$key} = $value;
            }
    
        }

    my $json = JSON->new;
   
    my ($IN, $OUT) = process_params($self);

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

    print $OUT $data_json if $OUT;
    
    return $data_json;

    }


####################################

sub process_params {

    my $params= shift;
    my $OUT;

    my %sepchar_options = ( "colon" => ":",
                            "comma" => ",",
                            "pipe"  => "|",
                            "tab"   => "\t",
                          );
                      
    my $sepchar_input = $params->{'sepchar'} || "comma";
    my $sepchar = $sepchar_options{$sepchar_input} || ",";

    my $infile = $params->{'inputfile'} || die "$!: Didn't specify inputfile.\n";
    my $IN = Tie::Handle::CSV->new($infile, header => 1, sep_char => $sepchar);

    if ( $params->{'outputfile'} ) {
        my $outfile = $params->{'outputfile'};
        open $OUT, ">$outfile" or die "Can't open $outfile: $!\n";
        }
        
    return ($IN, $OUT);

    }
