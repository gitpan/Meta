#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Baseline::Utils - library to provide utilities to baseline software.

=head1 COPYRIGHT

Copyright (C) 2001 Mark Veltzer;
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

=head1 SYNOPSIS

C<package foo;>
C<use Meta::Baseline::Utils qw();>
C<Meta::Baseline::Utils::cook_emblem_print(*FILE);>

=head1 DESCRIPTION

This package will provide code sniplets that a lot of scripts in the
baseline need.

=head1 EXPORTS

C<get_emblem()>
C<get_cook_emblem()>
C<file_emblem($)>
C<script_emblem($)>
C<xmlfile_emblem($)>
C<cook_emblem($)>
C<cook_emblem_print($)>

=cut

package Meta::Baseline::Utils;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT);
use XML::Writer qw();
use IO qw();
use Meta::Utils::File::File qw();

$VERSION="1.00";
@ISA=qw(Exporter);
@EXPORT_OK=qw();
@EXPORT=qw();

#sub get_emblem();
#sub get_cook_emblem();
#sub file_emblem($);
#sub script_emblem($);
#sub xmlfile_emblem($);
#sub cook_emblem($);
#sub cook_emblem_print($);

#__DATA__

=head1 FUNCTION DOCUMENTATION

=over

=item B<get_emblem()>

This will return the emblem that should be put on auto generated files.

=cut

sub get_emblem() {
	return("Base auto generated file - DO NOT EDIT!");
}

=item B<get_cook_emblem()>

This method returns the emblem in a cook style (C multi line comment).

=cut

sub get_cook_emblem() {
	return("/* ".&get_emblem()." */\n");
}

=item B<file_emblem($)>

This will create a stub file with the emblem.
This is meant for files in which the /* */ is the form for comments.

=cut

sub file_emblem($) {
	my($file)=@_;
	my($string)="/* ".&get_emblem()." */\n";
	Meta::Utils::File::File::save($file,$string);
}

=item B<script_emblem($)>

This method will create a stub file fit for scripts (where the hash (#)
sign is the correct form for comments.

=cut

sub script_emblem($) {
	my($file)=@_;
	my($string)="# ".&get_emblem()."\n";
	Meta::Utils::File::File::save($file,$string);
}

=item B<xmlfile_emblem($)>

This will create a stub XML file.

=cut

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

=item B<cook_emblem($)>

Cook knows how to handle C++ style comments so we just
call the method for that.

=cut

sub cook_emblem($) {
	my($file)=@_;
	&file_emblem($file);
}

=item B<cook_emblem_print($)>

This method gets a file handle and prints a cook emblem into it.

=cut

sub cook_emblem_print($) {
	my($file)=@_;
	my($string)="/* ".&get_emblem()." */\n";
	print $file $string;
}

1;

=back

=head1 BUGS

None.

=head1 AUTHOR

Mark Veltzer <mark2776@yahoo.com>

=head1 HISTORY

start of revision info
end of revision info

=head1 SEE ALSO

Nothing.

=head1 TODO

-add routine to make a file read only after is created and do it with emblem.

-make the emblem / emblem_simple more natural.

=cut
