#!/bin/echo This is a perl module and should not be run

package Meta::Tool::Nsgmls;

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Output qw();
use Meta::Lang::Docb::Params qw();

our($VERSION,@ISA);
$VERSION="0.07";
@ISA=qw();

#sub dochec($$);

#__DATA__

sub dochec($$) {
	my($file,$path)=@_;
	my($prog)="nsgmls";
	my(@args);
	push(@args,"-s");
	push(@args,"-u");
	push(@args,"-g");
	push(@args,"-e");
	my(@lpth)=split(":",$path);
	for(my($i)=0;$i<=$#lpth;$i++) {
		my($curr)=$lpth[$i]."/dtdx";
		push(@args,"-D");
		push(@args,$curr);
	}
	my(@epth)=split(":",Meta::Lang::Docb::Params::get_extra());
	for(my($i)=0;$i<=$#epth;$i++) {
		my($curr)=$epth[$i];
		push(@args,"-D");
		push(@args,$curr);
	}
	push(@args,$file);
	my($text);
#	Meta::Utils::Output::print("args are [".join(",",@args)."]\n");
	my($code)=Meta::Utils::System::system_err_nodie(\$text,$prog,\@args);
	if(!$code) {
		Meta::Utils::Output::print($text);
	} else {
		Meta::Utils::Output::print($text);
	}
	return($code);
}

1;

__END__

=head1 NAME

Meta::Tool::Nsgmls - run nsgmls for you.

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

	MANIFEST: Nsgmls.pm
	PROJECT: meta
	VERSION: 0.07

=head1 SYNOPSIS

	package foo;
	use Meta::Tool::Nsgmls qw();
	my($object)=Meta::Tool::Nsgmls->new();
	my($result)=$object->method();

=head1 DESCRIPTION

This module will ease the work of running nsgmls for you.

=head1 FUNCTIONS

	dochec($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<dochec($$)>

This method will check an sgml file using nsgmls and will return a boolean
value according to whether that file is correct.

=back

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mark2776@yahoo.com
	WWW: http://www.geocities.com/mark2776
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV history change
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

-how do I stop nsgmls from refering to /usr/lib/sgml (is it hardcoded ?).

-make number of errors coming out nsgmls minimal.
