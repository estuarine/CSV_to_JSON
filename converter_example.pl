#!/usr/bin/perl
use CSV_to_JSON_class;
use Modern::Perl;

my $converter = CSV_to_JSON_class->new( inputfile  => 'Example.csv',
                                        outputfile => 'Example.json',
                                        sepchar    => 'comma',
                                       );

my $json_data = $converter->convert( outputfile => 'New_output_file.json' );
