#!/bin/echo This is a perl module and should not be run

package Meta::Utils::File::Group;

use strict qw(vars refs subs);
use Meta::Utils::Output qw();

our($VERSION,@ISA);
$VERSION="0.07";
@ISA=qw();

#sub get_gidx($);
#sub check_gidx($$$);
#sub check_hash_gidx($$$);
#sub grou2gidx($);
#sub check_hash_grou($$$);

#__DATA__

sub get_gidx($) {
	my($file)=@_;
	my(@list)=stat($file);
	if($list[0]) {
		my($gidx)=$list[5];
		return($gidx);
	} else {
		Meta::Utils::System::die("unable to stat file [".$file."]");
		return(0);
	}
}

sub check_gidx($$$) {
	my($file,$grou,$verb)=@_;
	my($curr)=get_gidx($file);
	if($curr ne $grou) {
		if($verb) {
			Meta::Utils::Output::print("failed group check [".$grou."] on file [".$file."] with group [".$curr."]\n");
		}
		return(0);
	} else {
		return(1);
	}
}

sub check_hash_gidx($$$) {
	my($hash,$gidx,$verb)=@_;
	my($stat)=1;
	my($numb)=0;
	while(my($key,$val)=each(%$hash)) {
		if(!check_gidx($key,$gidx,$verb)) {
			$numb++;
			$stat=0;
		}
	}
	return($stat);
}

sub grou2gidx($) {
	my($grou)=@_;
	my($gidx)=(getgrnam($grou))[2];
	return($gidx);
}

sub check_hash_grou($$$) {
	my($hash,$grou,$verb)=@_;
	my($gidx)=grou2gidx($grou);
	return(check_hash_gidx($hash,$gidx,$verb));
}

1;

__END__

=head1 NAME

Meta::Utils::File::Group - library to handle group possessions.

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

	MANIFEST: Group.pm
	PROJECT: meta
	VERSION: 0.07

=head1 SYNOPSIS

	package foo;
	use Meta::Utils::File::Group qw();
	my($result)=Meta::Utils::File::Group::check_hash($hash);

=head1 DESCRIPTION

This package can check and fix the group settings on files within your change.

=head1 FUNCTIONS

	get_gidx($)
	check_gidx($$$)
	check_hash_gidx($$$)
	grou2gidx($)
	check_hash_grou($$$)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<get_gidx($)>

This routine receives a file name and returns the group id ownership of that
file. The function dies if the file does not exist.
The function uses the standard "stat" function to get the relevant
information.

=item B<check_gidx($$$)>

This routine receives a file, a group id and a verbose flag and makes
sure that the file is of the appointed group.
The result is 1 if the check went well and 0 otherwise.

=item B<check_hash_gidx($$$)>

The function receives a hash reference, a group id and a verbose flag.
This routine runs a check on all the files in the hash that they are
indeed of the designated group received.

=item B<grou2gid($)>

This function receives a group name and converts it to the group id.

=item B<check_hash_grou($$$)>

This does exactly as the above function check_hash_gidx except it receives
a group name and not an absolute id, and then translates it to an absolute
id in order to make the check and simple calls: check_hash_gidx.

=back

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mark2776@yahoo.com
	WWW: http://www.geocities.com/mark2776
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV perl reorganization
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
