#!/usr/bin/env perl

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Opts::Opts qw();
use Meta::Baseline::Test qw();
use Meta::Lang::Perl::Perlpkgs qw();
use Meta::Baseline::Aegis qw();

my($opts)=Meta::Utils::Opts::Opts->new();
$opts->set_standard();
$opts->set_free_allo(0);
$opts->analyze(\@ARGV);

Meta::Baseline::Test::redirect_on();

#Meta::Utils::Output::print("in here\n");
my($file)=Meta::Baseline::Aegis::which("xmlx/temp/xmlx/perlpkgs/meta.xml");
#Meta::Utils::Output::print("in there\n");
my($object)=Meta::Lang::Perl::Perlpkgs::new_file($file);
Meta::Utils::Output::print("number of packages is [".$object->size()."]\n");
for(my($i)=0;$i<$object->size();$i++) {
	my($curr)=$object->getx($i);
	Meta::Utils::Output::print("package name is [".$curr->get_name()."]\n");
	Meta::Utils::Output::print("package description is [".$curr->get_description()."]\n");
	Meta::Utils::Output::print("package longdescription is [".$curr->get_longdescription()."]\n");
	Meta::Utils::Output::print("package version is [".$curr->get_version()."]\n");
	Meta::Utils::Output::print("package license is [".$curr->get_license()."]\n");
	Meta::Utils::Output::print("package author is [".$curr->get_author()->get_perl_makefile()."]\n");
	Meta::Utils::Output::print("number of modules in [".$i."] is [".$curr->get_modules()->size()."]\n");
	Meta::Utils::Output::print("number of scripts in [".$i."] is [".$curr->get_scripts()->size()."]\n");
	Meta::Utils::Output::print("number of tests in [".$i."] is [".$curr->get_tests()->size()."]\n");
	Meta::Utils::Output::print("number of files in [".$i."] is [".$curr->get_files()->size()."]\n");
	Meta::Utils::Output::print("number of credits in [".$i."] is [".$curr->get_credits()->size()."]\n");
	#my($modules)=$curr->get_modules();
	#for(my($j)=0;$j<$modules->size();$j++) {
	#	my($source)=$modules->getx($j)->get_source();
	#	my($target)=$modules->getx($j)->get_target();
	#	Meta::Utils::Output::print("\tmodule [".$j."]\n");
	#	Meta::Utils::Output::print("\t\t".$source."\n");
	#	Meta::Utils::Output::print("\t\t".$target."\n");
	#}
	my($credits)=$curr->get_credits();
	for(my($j)=0;$j<$credits->size();$j++) {
		my($curr)=$credits->getx($j);
		my($items)=$curr->get_items();
		for(my($k)=0;$k<$items->size();$k++) {
			Meta::Utils::Output::print("item [".$k."] is [".$items->getx($k)."]\n");
		}
		Meta::Utils::Output::print("author is [".$curr->get_author()->get_perl_makefile()."]\n");
	}
	#my($modules)=$curr->get_modules_dep_list(1,1);
}

Meta::Baseline::Test::redirect_off();

Meta::Utils::System::exit(1);

__END__

=head1 NAME

perlpkgs.pl - testing program for the Meta:::Lang::Perl::Perlpkgs.pm module.

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

	MANIFEST: perlpkgs.pl
	PROJECT: meta
	VERSION: 0.13

=head1 SYNOPSIS

	perlpkgs.pl

=head1 DESCRIPTION

This script tests the Meta::Lang::Perl::Perlpkgs module.
Currently it just reads an object from a file.

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

	0.00 MV perl packaging
	0.01 MV perl packaging again
	0.02 MV license issues
	0.03 MV fix database problems
	0.04 MV more database issues
	0.05 MV md5 project
	0.06 MV database
	0.07 MV perl module versions in files
	0.08 MV thumbnail user interface
	0.09 MV more thumbnail issues
	0.10 MV website construction
	0.11 MV improve the movie db xml
	0.12 MV web site automation
	0.13 MV SEE ALSO section fix

=head1 SEE ALSO

Meta::Baseline::Aegis(3), Meta::Baseline::Test(3), Meta::Lang::Perl::Perlpkgs(3), Meta::Utils::Opts::Opts(3), Meta::Utils::System(3), strict(3)

=head1 TODO

Nothing.
