#!/bin/echo This is a perl module and should not be run

package Meta::Xml::Parsers::Author;

use strict qw(vars refs subs);
use Meta::Info::Author qw();
use Meta::Xml::Parsers::Base qw();

our($VERSION,@ISA);
$VERSION="0.08";
@ISA=qw(Meta::Xml::Parsers::Base);

#sub new($);
#sub get_result($);
#sub handle_start($$);
#sub handle_end($$);
#sub handle_char($$);

#__DATA__

sub new($) {
	my($clas)=@_;
	my($self)=Meta::Xml::Parsers::Base->new();
	$self->setHandlers(
		'Start'=>\&handle_start,
		'End'=>\&handle_end,
		'Char'=>\&handle_char,
	);
	bless($self,$clas);
	$self->{TEMP_AUTHOR}=defined;
	return($self);
}

sub get_result($) {
	my($self)=@_;
	return($self->{TEMP_AUTHOR});
}

sub handle_start($$) {
	my($self,$elem)=@_;
	#Meta::Utils::Output::print("in handle_start with elem [".$elem."]\n");
	if($elem eq "author") {
		$self->{TEMP_AUTHOR}=Meta::Info::Author->new();
	}
}

sub handle_end($$) {
	my($self,$elem)=@_;
}

sub handle_char($$) {
	my($self,$elem)=@_;
	if($self->within_element("author")) {
		if($self->in_element("honorific")) {
			$self->{TEMP_AUTHOR}->set_honorific($elem);
		}
		if($self->in_element("firstname")) {
			$self->{TEMP_AUTHOR}->set_firstname($elem);
		}
		if($self->in_element("surname")) {
			$self->{TEMP_AUTHOR}->set_surname($elem);
		}
		if($self->in_element("cpanid")) {
			$self->{TEMP_AUTHOR}->set_cpanid($elem);
		}
		if($self->in_element("cpanpassword")) {
			$self->{TEMP_AUTHOR}->set_cpanpassword($elem);
		}
		if($self->in_element("sourceforgeid")) {
			$self->{TEMP_AUTHOR}->set_sourceforgeid($elem);
		}
		if($self->in_element("sourceforgepassword")) {
			$self->{TEMP_AUTHOR}->set_sourceforgepassword($elem);
		}
		if($self->in_element("initials")) {
			$self->{TEMP_AUTHOR}->set_initials($elem);
		}
		if($self->in_element("handle")) {
			$self->{TEMP_AUTHOR}->set_handle($elem);
		}
		if($self->in_element("homepage")) {
			$self->{TEMP_AUTHOR}->set_homepage($elem);
		}
		if($self->within_element("affiliation")) {
			if($self->in_element("orgname")) {
				$self->{TEMP_AUTHOR}->get_affiliation()->set_orgname($elem);
			}
			if($self->within_element("address")) {
				if($self->in_element("email")) {
					$self->{TEMP_AUTHOR}->get_affiliation()->get_address()->set_email($elem);
				}
			}
		}
	}
}

1;

__END__

=head1 NAME

Meta::Xml::Parsers::Author - Object to parse an XML/author file.

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

	MANIFEST: Author.pm
	PROJECT: meta
	VERSION: 0.08

=head1 SYNOPSIS

	package foo;
	use Meta::Xml::Parsers::Author qw();
	my($def_parser)=Meta::Xml::Parsers::Author->new();
	$def_parser->parsefile($file);
	my($def)=$def_parser->get_result();

=head1 DESCRIPTION

This object will create a Meta::Info::Author for you from an XML/author file. 

=head1 FUNCTIONS

	new($)
	get_result($)
	handle_start($$)
	handle_end($$)
	handle_char($$)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<new($)>

This gives you a new object for a parser.

=item B<get_result($)>

This method will retrieve the result of the parsing process.

=item B<handle_start($$)>

This will handle start tags.

=item B<handle_end($$)>

This will handle end tags.
This currently does nothing.

=item B<handle_char($$)>

This will handle actual text.

=back

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mark2776@yahoo.com
	WWW: http://www.geocities.com/mark2776
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV perl packaging again
	0.01 MV perl packaging again
	0.02 MV fix database problems
	0.03 MV md5 project
	0.04 MV database
	0.05 MV perl module versions in files
	0.06 MV movies and small fixes
	0.07 MV thumbnail user interface
	0.08 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

Nothing.
