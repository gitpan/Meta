#!/bin/echo This is a perl module and should not be run

package Meta::Lang::Cpp::Run;

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Baseline::Aegis qw();

our($VERSION,@ISA);
$VERSION="0.10";
@ISA=qw();

#sub run_with_flags($$$$);
#sub TEST($);

#__DATA__

sub run_with_flags($$$$) {
	my($plat,$arch,$exec,$para)=@_;
	my($list)=Meta::Baseline::Aegis::search_path_list();
	for(my($i)=0;$i<=$#$list;$i++) {
		$list->[$i].="/dlls/".$plat."/".$arch;
	}
	my($addx)=join(":",@$list);
	Meta::Utils::Env::add("LD_LIBRARY_PATH",":",$addx);
	my($binary)=Meta::Baseline::Aegis::which("bins/$plat/$arch/$exec");
	return(Meta::Utils::System::system_nodie($binary,[$para]));
}

sub TEST($) {
	my($context)=@_;
	return(1);
}

1;

__END__

=head1 NAME

Meta::Lang::Cpp::Run - module to run C++ executables for you.

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

	MANIFEST: Run.pm
	PROJECT: meta
	VERSION: 0.10

=head1 SYNOPSIS

	package foo;
	use Meta::Lang::Cpp::Run qw();
	my($object)=Meta::Lang::Cpp::Run->new();
	my($result)=$object->method();

=head1 DESCRIPTION

This module will run C++ applications for you (and will hide dynamic
libs and other issues from you).

=head1 FUNCTIONS

	run_with_flags($$$$)
	TEST($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<run_with_flags($$$$)>

This will run an executable with the correct dynamic libs etc...

=item B<TEST($)>

Test suite for this module.

=back

=head1 SUPER CLASSES

None.

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mailto:veltzer@cpan.org
	WWW: http://www.veltzer.org
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV C++ and temp stuff
	0.01 MV perl packaging
	0.02 MV md5 project
	0.03 MV database
	0.04 MV perl module versions in files
	0.05 MV movies and small fixes
	0.06 MV thumbnail user interface
	0.07 MV more thumbnail issues
	0.08 MV website construction
	0.09 MV web site automation
	0.10 MV SEE ALSO section fix

=head1 SEE ALSO

Meta::Baseline::Aegis(3), Meta::Utils::System(3), strict(3)

=head1 TODO

Nothing.
