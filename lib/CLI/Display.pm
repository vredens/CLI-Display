package CLI::Display;

use 5.008;
use strict;
use warnings;

use Term::ANSIColor;
use Carp;

require Exporter;

our @ISA = qw(Exporter);

our @EXPORT_OK = ( qw(print_g print_y print_r continue_or_abort) );

our %EXPORT_TAGS = ( prints => [qw/print_g print_y print_r/] );

our @EXPORT = qw();

our $VERSION = 0.1;

sub print_r(@) {
	print color 'red';
	print @_;
	print color 'reset';
}

sub print_g(@) {
	print color 'green';
	print @_;
	print color 'reset';
}

sub print_y(@) {
	print color 'yellow';
	print @_;
	print color 'reset';
}

sub continue_or_abort {
	my $indent = shift || 0;
	print_y "\t" x $indent, 'Continue? [y|n] ';
	while(<STDIN>) {
		s/\n|\r//g;
		if ($_ eq 'y') {
			return 1;
		} elsif ($_ eq 'n') {
			exit 1;
		} else {
			print_r "\t" x $indent, "use either 'y', 'n' or abort the script. Continue [y|n]";
		}
	}
}

1;

__END__

=head1 NAME

CLI::Display - a set of text display helpers, and more, for command line
tools.

=head1 SYNOPSIS

 use CLI::Display qw/:prints continue_or_abort/;

 print_g "this is my green: ", $text, "\n";
 print_y "highlighting this using yellow color\n";
 print_e "a multi "; print_y "color "; print_g "line"; print "...\n";

 # wait for user to continue or abort the script and indent 
 # all output by 1 tab
 continue_or_abort 1; 

=head1 DESCRIPTION

A simple lib of methods that help colorize your CLI tool output using 
the Term::ANSIColor lib.

More helpers are introduced as I need more for my CLI tools.

=head1 FUNCTIONS

=head2 print_g (@)

Works just like regular 'print' but it colors the output as green.

=head2 print_y (@)

Same as print_g but uses yellow.

=head2 print_r (@)

Same as print_g but uses red.

=head2 continue_or_abort (@)

Halts the script waiting for user input, which needs to be either 'y' or
'n'. 

=head1 SEE ALSO

Term::ANSIColor::Print a much better alternative if you want something 
more complex in generating output. It's OO though.

=head1 AUTHOR

J.B. Ribeiro, E<lt>vredens@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2012 by J.B. Ribeiro

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.12.3 or,
at your option, any later version of Perl 5 you may have available.

=cut
