CSV_to_JSON
===========

This is an extremely simple Perl script to convert CSV (or tab-, pipe- or colon-separated) files to JSON, useful if you just need to convert the data using the existing file headers. It doesn't do anything fancy in terms of sorting or nesting the data.

You can specify the input and output files, as well as the separation character used in the input file, either by editing the code or by providing them on the command line. If you choose the latter, the format is:

	perl CSV_to_JSON.pl [input_file_name] [output_file_name] [separation_character]
	
The allowed values for separation_character are "colon," "comma," "pipe" or "tab." You can easily add other characters by editing the %sepchar_options hash on lines 10-14.
	
The default is:

	perl CSV_to_JSON.pl Example.csv Example.json comma
	
The script's dependencies are Tie::Handle::CSV and JSON.
