#!/usr/bin/env perl

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Opts::Opts qw();
use Meta::Utils::Output qw();
use Meta::Baseline::Aegis qw();
use Meta::Xml::Dom qw();
use Meta::Lang::Xml::Xml qw();

my($vali);
my($opts)=Meta::Utils::Opts::Opts->new();
$opts->set_standard();
$opts->def_bool("validate","use a validating parser ?",0,\$vali);
$opts->set_free_allo(0);
$opts->analyze(\@ARGV);

Meta::Lang::Xml::Xml::setup_path();
my($file)=Meta::Baseline::Aegis::which("xmlx/lit/lit.xml");

my($parser)=Meta::Xml::Dom->new_vali($vali);
my($doc)=$parser->parsefile($file);
 
my($loans);#mind that this needs to be on a different line
$loans=$doc->getElementsByTagName("loan");
for(my($i)=0;$i<$loans->getLength();$i++) {
	my($current)=$loans->[$i];
	if($current->hasChildNodes()) {#check if authorizations has text at all
		my($loanto_name)=$current->getFirstChild()->getData();
		#find the name of the book
		Meta::Utils::Output::print("[".$loanto_name."] is loaning something\n");
	} else {
		Meta::Utils::System::die("no loan text ?");
	}
}

Meta::Utils::System::exit(1);

__END__

=head1 NAME

lit_loans.pl - show books out on a loan.

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

	MANIFEST: lit_loans.pl
	PROJECT: meta
	VERSION: 0.10

=head1 SYNOPSIS

	lit_loans.pl [options]

=head1 DESCRIPTION

This script will report which books are out on a loan from the lit/XML database.

=head1 OPTIONS

=over 4

=item B<help> (type: bool, default: 0)

display help message

=item B<pod> (type: bool, default: 0)

display pod options snipplet

=item B<man> (type: bool, default: 0)

display manual page

=item B<quit> (type: bool, default: 0)

quit without doing anything

=item B<gtk> (type: bool, default: 0)

run a gtk ui to get the parameters

=item B<license> (type: bool, default: 0)

show license and exit

=item B<copyright> (type: bool, default: 0)

show copyright and exit

=item B<history> (type: bool, default: 0)

show history and exit

=item B<validate> (type: bool, default: 0)

use a validating parser ?

=back

no free arguments are allowed

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mailto:veltzer@cpan.org
	WWW: http://www.veltzer.org
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV fix database problems
	0.01 MV md5 project
	0.02 MV database
	0.03 MV perl module versions in files
	0.04 MV more Class method generation
	0.05 MV thumbnail user interface
	0.06 MV more thumbnail issues
	0.07 MV website construction
	0.08 MV improve the movie db xml
	0.09 MV web site automation
	0.10 MV SEE ALSO section fix

=head1 SEE ALSO

Meta::Baseline::Aegis(3), Meta::Lang::Xml::Xml(3), Meta::Utils::Opts::Opts(3), Meta::Utils::Output(3), Meta::Utils::System(3), Meta::Xml::Dom(3), strict(3)

=head1 TODO

-actually print the titles which are on the loan.
