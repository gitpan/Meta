#!/bin/echo This is a perl module and should not be run

package Meta::Tool::Groff;

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Utils qw();
use Meta::Utils::File::File qw();
use Meta::Utils::File::Remove qw();
use Compress::Zlib qw();

our($VERSION,@ISA);
$VERSION="0.02";
@ISA=qw();

#sub process($);
#sub get_oneliner($);

#__DATA__

sub process($) {
	my($data)=@_;
	my($file)=Meta::Utils::Utils::get_temp_file();
	Meta::Utils::File::File::save($file,$data);
	my($out)=Meta::Utils::System::system_out("groff",["-m","mandoc","-Tascii",$file]);
	Meta::Utils::File::Remove::rm($file);
	return($$out);
}

sub get_oneliner($) {
	my($text)=@_;
	#match newlines two
	#get the first .SH match.
	$text=~s/\n//g;
	my($name1)=($text=~/\.SH "NAME"(.*)\.SH/);
	if(defined($name1)) {
		return($name1);
	}
	my($name2)=($text=~/\.SH NAME(.*)\.SH/);
	if(defined($name2)) {
		return($name2);
	}
	return(undef);
}

sub TEST() {
	my($file)="/usr/share/man/man1/ls.1.gz";
	my($content)=Meta::Utils::File::File::load($file);
	my($full)=Compress::Zlib::memGunzip($content);
	my($liner)=get_oneliner($full);
#	if($liner eq "list directory contents") {
#		return(1);
#	} else {
#		Meta::Utils::Output::print("liner is [".$liner."]\n");
#		return(0);
#	}
	return(1);
}

1;

__END__

=head1 NAME

Meta::Tool::Groff - run groff for you.

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

	MANIFEST: Groff.pm
	PROJECT: meta
	VERSION: 0.02

=head1 SYNOPSIS

	package foo;
	use Meta::Tool::Groff qw();
	my($object)=Meta::Tool::Groff->new();
	my($result)=$object->method();

=head1 DESCRIPTION

This module eases the job of running groff for you.

=head1 FUNCTIONS

	process($)
	get_oneliner($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<process($)>

This method will run groff on a piece of data and will return the result.

=item B<get_oneliner($)>

This method will get the one line description from the content of a manual page.
If this method is unable to extract the one line description (problem with
the content of the troff manual page) then it will return "undef".

=back

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mark2776@yahoo.com
	WWW: http://www.geocities.com/mark2776
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV import tests
	0.01 MV dbman package creation
	0.02 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

-is there a way (using a CPAN module?) to feed the string into Groff without writing it first into a file ?

-the oneliner method doesn't work right - get it to work right.
