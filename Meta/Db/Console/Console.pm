#!/bin/echo This is a perl module and should not be run

package Meta::Db::Console::Console;

use strict qw(vars refs subs);
use Term::ReadLine qw();
use Meta::Utils::Output qw();
use Meta::Db::Connections qw();
use Meta::Db::Def qw();
use Meta::Db::Dbi qw();

our($VERSION,@ISA);
$VERSION="0.16";
@ISA=qw(Term::ReadLine);

#sub BEGIN();
#sub new($);
#sub add_vars($$);
#sub run($);
#sub TEST($);

#__DATA__

sub BEGIN() {
#	Meta::Class::MethodMaker->new("new");
	Meta::Class::MethodMaker->get_set(
		-java=>"_defs",
		-java=>"_def_name",
		-java=>"_connections",
		-java=>"_connection_name",
		-java=>"_prompt",
	);
	Meta::Class::MethodMaker->print([
		"defs",
		"def_name",
		"connections",
		"connection_name",
		"prompt",
	]);
}

sub new($) {
	my($clas)=@_;
	my($self)=Term::ReadLine->new();
	bless($self,$clas);
	return($self);
}

sub add_vars($$$) {
	my($self,$opts,$pref)=@_;
#	$opts->def_stri('prompt','what prompt to use','prompt>',\($self->{PROMPT}));
#	$opts->def_url('connections','what connections url to use','aegis:xmlx/connections/connections.xml',));
#	$opts->def_stri('con_name','what connection to use',undef,));
#	$opts->def_url('defs','what defs file to use','aegis:xmlx/def/chess.xml',));
#	$opts->def_stri('database_name','what database to use',undef,));
}

sub run($) {
	my($self)=@_;
	my($prompt)=$self->get_prompt();
	my($connection)=Meta::Db::Connections->new_url($self->get_connections())->get_con_null($self->get_con_name());
	my($def)=Meta::Db::Def->new_url($self->get_defs())->get_def_null($self->get_database_name());
	my($dbif)=Meta::Db::Dbi->new();
	$dbif->connect_def($connection,$def);
#	$connection->print(Meta::Utils::Output::get_file());
	my($line);
	$self->ReadHistory();
	while(defined($line=$self->readline($prompt))) {
#		Meta::Utils::Output::print("Got command [".$line."]\n");
		my($resu)=$dbif->execute_single($line);
		my($ref)=CORE::ref($resu);
		if($ref eq "ARRAY") {
			for(my($i)=0;$i<=$#$resu;$i++) {
				Meta::Utils::Output::print("result [".$resu->[$i]."]\n");
			}
		} else {
			Meta::Utils::Output::print("result [".$resu."]\n");
		}

	}
	$self->WriteHistory();
	$dbif->disconnect($connection);
	Meta::Utils::Output::print("\n");
}

sub TEST($) {
	my($context)=@_;
	return(1);
}

1;

__END__

=head1 NAME

Meta::Db::Console::Console - readline console for DBI/DBD databases.

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

	MANIFEST: Console.pm
	PROJECT: meta
	VERSION: 0.16

=head1 SYNOPSIS

	package foo;
	use Meta::Db::Console::Console qw();
	my($object)=Meta::Db::Console::Console->new();
	my($result)=$object->method();

=head1 DESCRIPTION

This object supplies you with a console for DBI/DBD database.
When you run the console you get to execute SQL queries and see the
results on your terminal.

=head1 FUNCTIONS

	new($)
	add_vars($)
	run($)
	TEST($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<new($)>

This is a constructor for the Meta::Db::Console::Console object.

=item B<run($)>

This method will run the console in a loop.

=item B<TEST($)>

Test suite for this module.

=back

=head1 SUPER CLASSES

Term::ReadLine(3)

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mailto:veltzer@cpan.org
	WWW: http://www.veltzer.org
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV db stuff
	0.01 MV good xml support
	0.02 MV xml data sets
	0.03 MV perl packaging
	0.04 MV XSLT, website etc
	0.05 MV PDMT
	0.06 MV more movies
	0.07 MV md5 project
	0.08 MV database
	0.09 MV perl module versions in files
	0.10 MV movies and small fixes
	0.11 MV thumbnail user interface
	0.12 MV more thumbnail issues
	0.13 MV website construction
	0.14 MV web site automation
	0.15 MV SEE ALSO section fix
	0.16 MV download scripts

=head1 SEE ALSO

Meta::Db::Connections(3), Meta::Db::Dbi(3), Meta::Db::Def(3), Meta::Utils::Output(3), Term::ReadLine(3), strict(3)

=head1 TODO

-add options to set the prompt according to preference.

-use Data::ShowTable to show the results.
