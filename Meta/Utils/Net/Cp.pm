#!/bin/echo This is a perl module and should not be run

package Meta::Utils::Net::Cp;

use strict qw(vars refs subs);
use Expect qw();

our($VERSION,@ISA);
$VERSION="0.25";
@ISA=qw();

#sub doit($$$$$$$$);

#__DATA__

sub doit($$$$$$$$) {
	my($verb,$demo,$name,$user,$pass,$sour,$targ,$perm)=@_;
	my($time)=20;
	my($sess)=Expect->spawn("ftp ".$name);
	$sess->expect($time,"-re",'Name (.*): ') || Meta::Utils::System::die("never got name prompt on [".$name."],[".$sess->exp_error()."]");
	print $sess $user."\r";
	$sess->expect($time,"Password:") || Meta::Utils::System::die("never got password prompt on [".$name."],[".$sess->exp_error()."]");
	print $sess $pass."\r";
	my($matc)=$sess->expect($time,"Login incorrect","ftp>");
	if($matc==1) {
		Meta::Utils::System::die("connection closed");
	}
	print $sess "binary\r";
	$matc=$sess->expect($time,"ftp>");
	if($matc==0) {
		Meta::Utils::System::die("connection closed");
	}
	print $sess "prompt\r";
	$matc=$sess->expect($time,"ftp>");
	if($matc==0) {
		Meta::Utils::System::die("connection closed");
	}
	my(@list)=split("/",$targ);
	for(my($i)=0;$i<$#list;$i++) {
		print $sess "mkdir ".join("/",@list[0..$i])."\r";
		my($matc)=$sess->expect($time,"ftp>");
		if($matc==0) {
			Meta::Utils::System::die("connection closed");
		}
	}
	print $sess "put ".$sour." ".$targ."\r";
	if($perm eq "execute") {
		print $sess "chmod 755 ".$targ."\r";
		my($matc)=$sess->expect($time,"ftp>");
		if($matc==0) {
			Meta::Utils::System::die("connection closed");
		}
	}
	$matc=$sess->expect($time,"ftp>");
	if($matc==0) {
		Meta::Utils::System::die("connection closed");
	}
	print $sess "exit\r";
	$sess->hard_close();
	return(1);
}

1;

__END__

=head1 NAME

Meta::Utils::Net::Cp - library to handle copying of files from machine to machine.

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

	MANIFEST: Cp.pm
	PROJECT: meta
	VERSION: 0.25

=head1 SYNOPSIS

	package foo;
	use Meta::Utils::Net::Cp qw();
	my($stat)=Meta::Utils::Net::Cp::doit([params]);
	if(!$stat) {
		Meta::Utils::System::die("unable to copy file to remote machine");
	}

=head1 DESCRIPTION

This module will help you copy local files to remote machines. This module
will provide rcp, ftp, rdist and other methods for accoplishing this.

=head1 FUNCTIONS

	doit($$$$$$$$)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<doit($$$$$$$$)>

This function will actualy do the distribution.

=back

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mark2776@yahoo.com
	WWW: http://www.geocities.com/mark2776
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV initial code brought in
	0.01 MV make quality checks on perl code
	0.02 MV more perl checks
	0.03 MV make Meta::Utils::Opts object oriented
	0.04 MV fix up perl checks
	0.05 MV check that all uses have qw
	0.06 MV fix todo items look in pod documentation
	0.07 MV correct die usage
	0.08 MV perl code quality
	0.09 MV more perl quality
	0.10 MV more perl quality
	0.11 MV perl documentation
	0.12 MV more perl quality
	0.13 MV perl qulity code
	0.14 MV more perl code quality
	0.15 MV revision change
	0.16 MV languages.pl test online
	0.17 MV fix docbook and other various stuff
	0.18 MV literature stuff
	0.19 MV perl packaging
	0.20 MV md5 project
	0.21 MV database
	0.22 MV perl module versions in files
	0.23 MV movies and small fixes
	0.24 MV thumbnail user interface
	0.25 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

-dont hard_close the connection at the end.
