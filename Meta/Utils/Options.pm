#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Utils::Options - utilities to let you manipulate option files.

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

MANIFEST: Options.pm
PROJECT: meta

=head1 SYNOPSIS

C<package foo;>
C<use Meta::Utils::Options qw();>
C<my($opti)=Meta::Utils::Options->new();>
C<$opti->read("my_configuration_file");>
C<$obje=$opti->get("my_variable");>

=head1 DESCRIPTION

This library lets you read and write configuration files.

=head1 EXPORTS

C<new($)>
C<read($$)>
C<getd($$$)>
C<getenv($$)>

=cut

package Meta::Utils::Options;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT);
use Meta::Utils::File::File qw();
use Meta::Utils::Env qw();
use Meta::Utils::Utils qw();
use Meta::Ds::Ohash qw();

$VERSION="1.00";
@ISA=qw(Exporter Meta::Ds::Ohash);
@EXPORT_OK=qw();
@EXPORT=qw();

#sub new($);
#sub read($$);
#sub getd($$$);
#sub getenv($$);

#__DATA__

=head1 FUNCTION DOCUMENTATION

=over

=item B<new($)>

Gives you a new options object.

=cut

sub new($) {
	my($clas)=@_;
	my($self)=Meta::Ds::Ohash->new();
	bless($self,$clas);
	return($self);
}

=item B<read($$)>

This lets you read a file in options format.

=cut

sub read($$) {
	my($self,$file)=@_;
	Meta::Utils::Arg::check_arg($self,"Meta::Utils::Options");
	my($text)=Meta::Utils::File::File::load($file);
	$text=Meta::Utils::Utils::remove_comments($text);
	my(@line)=split(/;/,$text);
	for(my($i)=0;$i<=$#line;$i++) {
		my($current)=$line[$i];
		if($current=~/=/) {
			my($elem,$valx)=($current=~/^\s*(\S+)\s*=\s*(.*)\s*$/);
			$self->insert($elem,$valx);
		}
	}
	return(1);
}

=item B<getd($$$)>

This will get a value but will return a default value if no value exists.

=cut

sub getd($$$) {
	my($self,$elem,$defa)=@_;
	Meta::Utils::Arg::check_arg($self,"Meta::Utils::Options");
	if($self->has($elem)) {
		return($self->get($elem));
	} else {
		return($defa);
	}
}

=item B<getenv($$)>

This is a new get routine which is overridable by the envrionment.
Mind you, that a default value must be available in the options file.

=cut

sub getenv($$) {
	my($self,$elem)=@_;
	Meta::Utils::Arg::check_arg($self,"Meta::Utils::Options");
	my($resu)=$self->get($elem);
	if(Meta::Utils::Env::has($elem)) {
		$resu=Meta::Utils::Env::get($elem);
	}
	return($resu);
}

1;

=back

=head1 BUGS

None.

=head1 AUTHOR

Mark Veltzer <mark2776@yahoo.com>

=head1 HISTORY

start of revision info
1	Mon Jan  1 16:38:12 2001	MV	initial code brought in
2	Tue Jan  2 06:08:54 2001	MV	bring databases on line
2	Wed Jan  3 07:02:01 2001	MV	handle architectures better
3	Sat Jan  6 11:39:39 2001	MV	make quality checks on perl code
4	Sat Jan  6 17:14:09 2001	MV	more perl checks
5	Sun Jan  7 18:17:29 2001	MV	make Meta::Utils::Opts object oriented
6	Tue Jan  9 18:15:19 2001	MV	check that all uses have qw
6	Tue Jan  9 19:29:31 2001	MV	fix todo items look in pod documentation
7	Wed Jan 10 12:05:55 2001	MV	more on tests/more checks to perl
8	Fri Jan 12 13:36:01 2001	MV	make options a lot better
9	Sun Jan 28 02:34:56 2001	MV	perl code quality
10	Sun Jan 28 13:51:26 2001	MV	more perl quality
11	Tue Jan 30 03:03:17 2001	MV	more perl quality
12	Sat Feb  3 23:41:08 2001	MV	perl documentation
13	Mon Feb  5 03:21:02 2001	MV	more perl quality
14	Tue Feb  6 01:04:52 2001	MV	perl qulity code
15	Tue Feb  6 07:02:13 2001	MV	more perl code quality
16	Tue Feb  6 22:19:51 2001	MV	revision change
end of revision info

=head1 SEE ALSO

Nothing.

=head1 TODO

Nothing.

=cut
