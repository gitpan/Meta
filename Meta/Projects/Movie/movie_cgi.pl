#!/usr/bin/env perl

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Opts::Opts qw();
use CGI qw();
use DBI qw();

my($opts)=Meta::Utils::Opts::Opts->new();
$opts->set_standard();
$opts->set_free_allo(0);
$opts->analyze(\@ARGV);

my($dbi)=DBI->connect("dbi:mysql:movie:host=localhost","devel","XXX");
if(!$dbi) {
	Meta::Utils::System::die("Error connecting to db [".DBI->errstr()."]");
}
my($ar)=$dbi->selectall_arrayref("select id,name from movie order by id");

my($p)=CGI->new();
print $p->header();
print $p->start_html();
print $p->start_table();
print $p->caption("this is my list of movies");
print $p->Tr($p->th(['id','name']));
for(my($i)=0;$i<=$#$ar;$i++) {
	print $p->Tr($p->td([$ar->[$i][0],$ar->[$i][1]]));
}
print $p->end_table();
print $p->end_html();

Meta::Utils::System::exit(1);

__END__

=head1 NAME

movie_cgi.pl - what does your program do.

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

	MANIFEST: movie_cgi.pl
	PROJECT: meta
	VERSION: 0.03

=head1 SYNOPSIS

	movie_cgi.pl [options]

=head1 DESCRIPTION

This is a CGI script which enables you to browse my movie database.
If you want to embed this as part of a larger framework then please
have a look at the modules that this is using since in itself
it does almost nothing.

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

	0.00 MV web site development
	0.01 MV web site automation
	0.02 MV SEE ALSO section fix
	0.03 MV put all tests in modules

=head1 SEE ALSO

CGI(3), DBI(3), Meta::Utils::Opts::Opts(3), Meta::Utils::System(3), strict(3)

=head1 TODO

Nothing.
