#!/bin/echo This is a perl module and should not be run

package Meta::Xml::Parsers::Perlpkgs;

use strict qw(vars refs subs);
use Meta::Lang::Perl::Perlpkgs qw();
use Meta::Lang::Perl::Perlpkg qw();
use Meta::Xml::Parsers::Author qw();
use Meta::Utils::Output qw();
use Meta::Development::PackModule qw();
use Meta::Info::Credit qw();

our($VERSION,@ISA);
$VERSION="0.13";
@ISA=qw(Meta::Xml::Parsers::Author);

#sub new($);
#sub get_result($);
#sub handle_start($$);
#sub handle_end($$);
#sub handle_char($$);

#__DATA__

sub new($) {
	my($clas)=@_;
	my($self)=Meta::Xml::Parsers::Author->new();
	$self->setHandlers(
		'Start'=>\&handle_start,
		'End'=>\&handle_end,
		'Char'=>\&handle_char,
	);
	$self->{TEMP_PERLPKG}=defined;
	$self->{TEMP_MODULE}=defined;
	$self->{TEMP_SCRIPT}=defined;
	$self->{TEMP_TEST}=defined;
	$self->{TEMP_FILE}=defined;
	$self->{TEMP_CREDIT}=defined;
	bless($self,$clas);
	return($self);
}

sub get_result($) {
	my($self)=@_;
	return($self->{RESULT});
}

sub handle_start($$) {
	my($self,$elem)=@_;
	my($context)=join(".",$self->context(),$elem);
	if($elem eq "perlpkgs") {
		$self->{TEMP_PERLPKGS}=Meta::Lang::Perl::Perlpkgs->new();
	}
	if($self->within_element("perlpkgs")) {
		if($elem eq "perlpkg") {
			$self->{TEMP_PERLPKG}=Meta::Lang::Perl::Perlpkg->new();
		}
		if($self->within_element("author") || $elem eq "author") {
			$self->SUPER::handle_start($elem);
		}
	}
	if($context eq "perlpkgs.perlpkg.modules.module") {
		$self->{TEMP_MODULE}=Meta::Development::PackModule->new();
	}
	if($context eq "perlpkgs.perlpkg.scripts.script") {
		$self->{TEMP_SCRIPT}=Meta::Development::PackModule->new();
	}
	if($context eq "perlpkgs.perlpkg.tests.test") {
		$self->{TEMP_TEST}=Meta::Development::PackModule->new();
	}
	if($context eq "perlpkgs.perlpkg.files.file") {
		$self->{TEMP_FILE}=Meta::Development::PackModule->new();
	}
	if($context eq "perlpkgs.perlpkg.credits.credit") {
		$self->{TEMP_CREDIT}=Meta::Info::Credit->new();
	}
}

sub handle_end($$) {
	my($self,$elem)=@_;
	if($elem eq "perlpkgs") {
		$self->{RESULT}=$self->{TEMP_PERLPKGS};
	}
	if($self->within_element("perlpkgs")) {
		if($elem eq "perlpkg") {
			$self->{TEMP_PERLPKGS}->push($self->{TEMP_PERLPKG});
		}
		if($self->within_element("perlpkg")) {
			if($elem eq "author") {
				$self->SUPER::handle_end($elem);
				$self->{TEMP_PERLPKG}->set_author($self->SUPER::get_result());
			}
			if($self->within_element("modules")) {
				if($elem eq "module") {
					$self->{TEMP_PERLPKG}->get_modules()->push($self->{TEMP_MODULE});
				}
			}
			if($self->within_element("scripts")) {
				if($elem eq "script") {
					$self->{TEMP_PERLPKG}->get_scripts()->push($self->{TEMP_SCRIPT});
				}
			}
			if($self->within_element("tests")) {
				if($elem eq "test") {
					$self->{TEMP_PERLPKG}->get_tests()->push($self->{TEMP_TEST});
				}
			}
			if($self->within_element("files")) {
				if($elem eq "file") {
					$self->{TEMP_PERLPKG}->get_files()->push($self->{TEMP_FILE});
				}
			}
			if($self->within_element("credits")) {
				if($elem eq "credit") {
					$self->{TEMP_PERLPKG}->get_credits()->push($self->{TEMP_CREDIT});
				}
			}
		}
	}
}

sub handle_char($$) {
	my($self,$elem)=@_;
	if($self->within_element("perlpkgs")) {
		if($self->within_element("perlpkg")) {
			if($self->in_element("name")) {
				$self->{TEMP_PERLPKG}->set_name($elem);
			}
			if($self->in_element("description")) {
				$self->{TEMP_PERLPKG}->set_description($elem);
			}
			if($self->in_element("longdescription")) {
				$self->{TEMP_PERLPKG}->set_longdescription($elem);
			}
			if($self->in_element("license")) {
				$self->{TEMP_PERLPKG}->set_license($elem);
			}
			if($self->in_element("version")) {
				$self->{TEMP_PERLPKG}->set_version($elem);
			}
			if($self->in_element("uname")) {
				$self->{TEMP_PERLPKG}->set_uname($elem);
			}
			if($self->in_element("gname")) {
				$self->{TEMP_PERLPKG}->set_gname($elem);
			}
			if($self->within_element("author")) {
				#Meta::Utils::Output::print("in here\n");
				$self->SUPER::handle_char($elem);
			}
			if($self->within_element("modules")) {
				if($self->within_element("module")) {
					if($self->in_element("source")) {
						$self->{TEMP_MODULE}->set_source($elem);
					}
					if($self->in_element("target")) {
						$self->{TEMP_MODULE}->set_target($elem);
					}
				}
			}
			if($self->within_element("scripts")) {
				if($self->within_element("script")) {
					if($self->in_element("source")) {
						$self->{TEMP_SCRIPT}->set_source($elem);
					}
					if($self->in_element("target")) {
						$self->{TEMP_SCRIPT}->set_target($elem);
					}
				}
			}
			if($self->within_element("tests")) {
				if($self->within_element("test")) {
					if($self->in_element("source")) {
						$self->{TEMP_TEST}->set_source($elem);
					}
					if($self->in_element("target")) {
						$self->{TEMP_TEST}->set_target($elem);
					}
				}
			}
			if($self->within_element("files")) {
				if($self->within_element("file")) {
					if($self->in_element("source")) {
						$self->{TEMP_FILE}->set_source($elem);
					}
					if($self->in_element("target")) {
						$self->{TEMP_FILE}->set_target($elem);
					}
				}
			}
			if($self->within_element("credits")) {
				if($self->within_element("credit")) {
					if($self->in_element("item")) {
						$self->{TEMP_ITEM}=$elem;
					}
				}
			}
		}
	}
}

1;

__END__

=head1 NAME

Meta::Xml::Parsers::Perlpkgs - Object to parse an XML/perlpkgs file.

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

	MANIFEST: Perlpkgs.pm
	PROJECT: meta
	VERSION: 0.13

=head1 SYNOPSIS

	package foo;
	use Meta::Xml::Parsers::Perlpkgs qw();
	my($def_parser)=Meta::Xml::Parsers::Perlpkgs->new();
	$def_parser->parsefile($file);
	my($def)=$def_parser->get_result();

=head1 DESCRIPTION

This object will create a Meta::Lang::Perl::Perlpkgs from an XML/perlpkgs
file.

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

	0.00 MV perl packaging
	0.01 MV more perl packaging
	0.02 MV perl packaging again
	0.03 MV perl packaging again
	0.04 MV validate writing
	0.05 MV fix database problems
	0.06 MV more database issues
	0.07 MV md5 project
	0.08 MV database
	0.09 MV perl module versions in files
	0.10 MV movies and small fixes
	0.11 MV thumbnail user interface
	0.12 MV import tests
	0.13 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

Nothing.
