#!/bin/echo This is a perl module and should not be run

package Meta::Baseline::Utils;

use strict qw(vars refs subs);
use XML::Writer qw();
use IO qw();
use Meta::Utils::File::File qw();

our($VERSION,@ISA);
$VERSION="0.25";
@ISA=qw();

#sub get_emblem();
#sub get_cook_emblem();
#sub file_emblem($);
#sub script_emblem($);
#sub xmlfile_emblem($);
#sub cook_emblem($);
#sub cook_emblem_print($);

#__DATA__

sub get_emblem() {
	return("Base auto generated file - DO NOT EDIT!");
}

sub get_cook_emblem() {
	return("/* ".&get_emblem()." */\n");
}

sub file_emblem($) {
	my($file)=@_;
	my($string)="/* ".&get_emblem()." */\n";
	Meta::Utils::File::File::save($file,$string);
}

sub script_emblem($) {
	my($file)=@_;
	my($string)="# ".&get_emblem()."\n";
	Meta::Utils::File::File::save($file,$string);
}

sub xmlfile_emblem($) {
	my($file)=@_;
	my($output)=IO::File->new("> ".$file);
	my($writer)=XML::Writer->new(OUTPUT=>$output);
	$writer->xmlDecl();
	$writer->comment(&get_emblem());
	$writer->dataElement("empty");
	$writer->end();
	$output->close();
}

sub cook_emblem($) {
	my($file)=@_;
	&file_emblem($file);
}

sub cook_emblem_print($) {
	my($file)=@_;
	my($string)="/* ".&get_emblem()." */\n";
	print $file $string;
}

1;

__END__

=head1 NAME

Meta::Baseline::Utils - library to provide utilities to baseline software.

=head1 COPYRIGHT

Copyright (C) 2001, 2002 Mark Veltzer;
All rights reserved.

=head1 LICENSE

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111, USA.

=head1 DETAILS

	MANIFEST: Utils.pm
	PROJECT: meta
	VERSION: 0.25

=head1 SYNOPSIS

	package foo;
	use Meta::Baseline::Utils qw();
	Meta::Baseline::Utils::cook_emblem_print(*FILE);

=head1 DESCRIPTION

This package will provide code sniplets that a lot of scripts in the
baseline need.

=head1 FUNCTIONS

	get_emblem()
	get_cook_emblem()
	file_emblem($)
	script_emblem($)
	xmlfile_emblem($)
	cook_emblem($)
	cook_emblem_print($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<get_emblem()>

This will return the emblem that should be put on auto generated files.

=item B<get_cook_emblem()>

This method returns the emblem in a cook style (C multi line comment).

=item B<file_emblem($)>

This will create a stub file with the emblem.
This is meant for files in which the /* */ is the form for comments.

=item B<script_emblem($)>

This method will create a stub file fit for scripts (where the hash (#)
sign is the correct form for comments.

=item B<xmlfile_emblem($)>

This will create a stub XML file.

=item B<cook_emblem($)>

Cook knows how to handle C++ style comments so we just
call the method for that.

=item B<cook_emblem_print($)>

This method gets a file handle and prints a cook emblem into it.

=back

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mark2776@yahoo.com
	WWW: http://www.geocities.com/mark2776
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV bring databases on line
	0.01 MV this time really make the databases work
	0.02 MV make quality checks on perl code
	0.03 MV more perl checks
	0.04 MV check that all uses have qw
	0.05 MV fix todo items look in pod documentation
	0.06 MV more on tests/more checks to perl
	0.07 MV spelling change
	0.08 MV correct die usage
	0.09 MV perl code quality
	0.10 MV more perl quality
	0.11 MV more perl quality
	0.12 MV perl documentation
	0.13 MV more perl quality
	0.14 MV perl qulity code
	0.15 MV more perl code quality
	0.16 MV revision change
	0.17 MV languages.pl test online
	0.18 MV perl packaging
	0.19 MV xml encoding
	0.20 MV md5 project
	0.21 MV database
	0.22 MV perl module versions in files
	0.23 MV movies and small fixes
	0.24 MV thumbnail user interface
	0.25 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

-add routine to make a file read only after is created and do it with emblem.

-make the emblem / emblem_simple more natural.
