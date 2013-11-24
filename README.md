CSV_to_JSON
===========

This is an extremely simple Perl script to convert CSV files to JSON, useful if you just need to convert a file using the existing headers. It doesn't do anything fancy in terms of sorting or nesting the data.

Usage:

1) You can specify the input and output files either by editing the code or by providing them on the command line. If you choose the latter, the format is:

	perl CSV_to_JSON.pl [input_file_name] [output_file_name]
	
The default is:

	perl CSV_to_JSON.pl Example.csv Example.json
	
2) The file assumes that the input file is comma-separated. Editing the sep_char value would allow you to specify another option like tab- or pipe-separated.

3) The script's dependencies are Tie::Handle::CSV and JSON.




