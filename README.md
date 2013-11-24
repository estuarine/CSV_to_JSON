CSV_to_JSON
===========

This is a library of Perl scripts for converting CSV (or tab-, pipe- or colon-separated) files to JSON, useful if you just need to convert the data using the existing file headers. They don't do anything fancy in terms of sorting or nesting the data.

The library consists of: 1) CSV_to_JSON.pl, a standalone script that allows you to convert one file at a time using command-line options; 2) CSV_to_JSON_class.pm, a package that provides a class that you can call from other scripts; and 3) converter_example.pl, an example of a Perl script that uses the class.


NOTES FOR EACH OPTION


1) CSV_to_JSON.pl

You can specify the input and output files, as well as the separation character used in the input file, either by editing the code or by providing them on the command line. If you choose the latter, the format is:

	perl CSV_to_JSON.pl [input_file_name] [output_file_name] [separation_character]
	
The allowed values for separation_character are "colon," "comma," "pipe" or "tab." You can easily add other characters by editing the %sepchar_options hash on lines 45-49.
	
The default is:

	perl CSV_to_JSON.pl Example.csv Example.json comma
	
Dependencies are Tie::Handle::CSV and JSON.


2) CSV_to_JSON_class.pm

The package relies on the invoking script to provide the parameters 'inputfile,' 'outputfile' and 'sepchar' (as in 'separation character,' such as comma, tab, etc.) The 'sepchar' parameter will default to 'comma' (i.e., it will assume the input file is CSV), and 'outputfile' is optional, but the package will throw a fatal error if 'inputfile' isn't specified.

Dependencies are Moose, Modern::Perl, Tie::Handle::CSV, JSON and List::MoreUtils.


3) converter_example.pl

This is a short example showing how a script can use CSV_to_JSON_class.pm to convert a single file. It would obviously be easy to use it to convert multiple files as well.

The construction of the converter object looks something like this:

	my $converter = CSV_to_JSON_class->new( inputfile  => 'Example.csv',
	                                        outputfile => 'Example.json',
                                            sepchar    => 'comma',
                                           );
                                           
The 'outputfile' and 'sepchar' parameters are optional. If you omit 'outputfile,' the method will convert and return the data but won't write it to a file. If you omit 'sepchar,' it will assume that the inputfile is comma-separated. The 'inputfile' parameter is mandatory; if you omit it, a fatal error will result. 

In this example, the simplest way of converting the file would be to call the class's "convert" method with no additional options, like so:

	my $json_data = $converter->convert;
	
If you don't plan to do anything with the data in the script and just want to save it to a file, you can do it this way:

	$converter->convert;
	
You can also pass all the parameter options when invoking the convert method instead of when creating the object. That would look like this:

	my $converter = CSV_to_JSON_class->new;
	
	$converter->convert( inputfile  => 'Example.csv',
	                     outputfile => 'Example.json',
                         sepchar    => 'comma',
                        );

The example script combines the two -- providing all the needed parameters when creating the object but then overriding the 'outputfile' parameter when calling the method.
