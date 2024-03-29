#!/bin/echo This is a perl module and should not be run

package Meta::Utils::Net::Mail;

use strict qw(vars refs subs);
use Meta::Utils::Utils qw();
use Meta::Utils::File::Remove qw();
use Meta::Utils::File::File qw();
use Error qw(:try);

our($VERSION,@ISA);
$VERSION="0.29";
@ISA=qw();

#sub send($$);
#sub TEST($);

#__DATA__

sub send($$) {
	my($clie,$text)=@_;
	my($file)=Meta::Utils::Utils::get_temp_file();
	Meta::Utils::File::File::save($file,$text);
	my($resu)=Meta::Utils::System::system_shell(
		"sendmail ".
		join(" ",@$clie).
		" < ".
		$file
	);
	if(!$resu) {
		throw Meta::Error::Simple("send of email failed");
	}
	Meta::Utils::File::Remove::rm($file);
}

sub TEST($) {
	my($context)=@_;
	return(1);
}

1;

__END__

=head1 NAME

Meta::Utils::Net::Mail - library to handle mail deliveries.

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

	MANIFEST: Mail.pm
	PROJECT: meta
	VERSION: 0.29

=head1 SYNOPSIS

	package foo;
	use Meta::Utils::Net::Mail qw();
	try {
		Meta::Utils::Net::Mail::send("mark@veltzer.org","Hello from Meta::Utils::Net::Mail");
	}
	catch Error::Simple with {
		Meta::Utils::Output::print("unable to send mail to mark");
	}

=head1 DESCRIPTION

This module sends mail who whoever you want to.
I do not recommend using this as this uses a direct sendmail
call which is not portable at all (sendmail has to be in
the users path and other problems).
Alternatives are: Install Mail::Sendmail and use it or
use my object oriented interface above Mail::Sendmail -
Meta::Info::MailMessage.

=head1 FUNCTIONS

	send($$)
	TEST($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<send($$)>

This function sends an email message to a client.
The two arguments are:
0. The names of the clients.
1. The text of the email message.
The function return whether it was able to send the message or not.

=item B<TEST($)>

Test suite for this module.
This test suite currently does nothing.

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

	0.00 MV initial code brought in
	0.01 MV make quality checks on perl code
	0.02 MV more perl checks
	0.03 MV make Meta::Utils::Opts object oriented
	0.04 MV check that all uses have qw
	0.05 MV fix todo items look in pod documentation
	0.06 MV put ALL tests back and light the tree
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
	0.17 MV perl packaging
	0.18 MV perl packaging again
	0.19 MV more Perl packaging
	0.20 MV md5 project
	0.21 MV database
	0.22 MV perl module versions in files
	0.23 MV movies and small fixes
	0.24 MV thumbnail user interface
	0.25 MV more thumbnail issues
	0.26 MV website construction
	0.27 MV web site automation
	0.28 MV SEE ALSO section fix
	0.29 MV md5 issues

=head1 SEE ALSO

Error(3), Meta::Utils::File::File(3), Meta::Utils::File::Remove(3), Meta::Utils::Utils(3), strict(3)

=head1 TODO

-stop using the system_shell command here and rather use a system command which gets its standard input from a file you tell it to.

-stop using a temp file at ALL!!!
