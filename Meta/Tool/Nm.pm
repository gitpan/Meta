#!/bin/echo This is a perl module and should not be run

package Meta::Tool::Nm;

use strict qw(vars refs subs);

our($VERSION,@ISA);
$VERSION="0.07";
@ISA=qw();

#sub read($);

#__DATA__

sub read($) {
	my($file)=@_;
	my(%hash);
	my($prog)="/usr/bin/nm";
	#do the work
	my($parser)=Meta::Utils::Parse::Text->new();
	my(@args);
	push(@args,$prog);
	push(@args,$file);
	$parser->init_proc(\@args);
	while(!$parser->get_over()) {
		my($line)=$parser->get_line();
		my($address,$type,$sym)=($line=~/^(.*)\s(.)\s(.*)$/);
		$hash{$sym}=defined;
		$parser->next();
	}
	$parser->fini();
	return(\%hash);
}

1;

__END__

=head1 NAME

Meta::Tool::Nm - run nm and give you the results.

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

	MANIFEST: Nm.pm
	PROJECT: meta
	VERSION: 0.07

=head1 SYNOPSIS

	package foo;
	use Meta::Tool::Nm qw();
	my($object)=Meta::Tool::Nm->new();
	my($result)=$object->method();

=head1 DESCRIPTION

This module hides the complexity of running nm from you. Give it
an object file or a library and ask it to read it and it will
return a hash containing the symbols in that file.

=head1 FUNCTIONS

	read($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<read($)>

This function received a file name and runs nm on the file storing
the resulting symbol table in a hash. The function then returns
the hash.

=back

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mark2776@yahoo.com
	WWW: http://www.geocities.com/mark2776
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV more examples
	0.01 MV perl packaging
	0.02 MV md5 project
	0.03 MV database
	0.04 MV perl module versions in files
	0.05 MV movies and small fixes
	0.06 MV thumbnail user interface
	0.07 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

Nothing.
