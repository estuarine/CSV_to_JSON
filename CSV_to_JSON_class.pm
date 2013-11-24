#!/usr/bin/perl
package CSV_to_JSON_class;
use Modern::Perl;
use Moose;
use Tie::Handle::CSV;
use JSON;
use List::MoreUtils qw(natatime);
binmode(STDOUT, ":utf8");

# Object-oriented version of CSV_to_JSON.pl for use in other scripts

has [qw/ inputfile outputfile sepchar /] => ( is  => 'rw', isa => 'Str' );

# Make the class immutable to speed up Moose's performance
__PACKAGE__->meta->make_immutable;


###############################################################

sub convert {

    my $params = my $self = shift;
    
    if (@_) { 

        my $it = natatime 2, @_;
        while (my ($key, $value) = $it->() ) {
        
            $params->{$key} = $value;
        
            }
    
        }

    my $json = JSON->new;
   
    my ($IN, $infile, $OUT, $outfile) = process_input($params); 

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

    }


####################################

sub process_input {

    my $params = shift;

    my %sepchar_options = ( "colon" => ":",
                            "comma" => ",",
                            "pipe"  => "|",
                            "tab"   => "\t",
                           );
                      
    my $sepchar_input = $params->{'sepchar'} || "comma";
    my $sepchar = $sepchar_options{$sepchar_input} || ",";

    my $infile = $params->{'inputfile'} || die "$!: Didn't specify inputfile.\n";
    my $IN = Tie::Handle::CSV->new($infile, header => 1, sep_char => $sepchar);

    my $outfile = $params->{'outputfile'} || die "$!: Didn't specify outputfile.\n";
    open my $OUT, ">$outfile" or die "Can't open $outfile: $!\n";

    return ($IN, $infile, $OUT, $outfile);

    }
