#!/bin/echo This is a perl module and should not be run

package Meta::Imdb::Get;

use strict qw(vars refs subs);
use LWP::UserAgent qw();
use HTTP::Request qw();
use HTTP::Request::Common qw();
use Meta::Baseline::Aegis qw();
use Meta::Utils::File::File qw();
use HTML::Form qw();
use XML::XQL qw();
use XML::XQL::DOM qw();
use Meta::Lang::Html::Html qw();

our($VERSION,@ISA);
$VERSION="0.13";
@ISA=qw(LWP::UserAgent);

#sub new($);
#sub get_page_form($$$);
#sub get_page($$$);
#sub get_title($$);
#sub get_director_id($$$);
#sub get_director_id_form($$$);
#sub get_search_page($);
#sub get_birth_name($$$);
#sub TEST($);

#__DATA__

sub new($) {
	my($clas)=@_;
	my($self)=LWP::UserAgent->new();
	$self->agent("MVbrowser/v5.7 Platinum");
	bless($self,$clas);
	return($self);
}

sub get_page_form($$$) {
	my($self,$dire,$name)=@_;
	my($url)="http://us.imdb.com/List";
	my($file)="html/import/projects/Imdb/list.html";
	$file=Meta::Baseline::Aegis::which($file);
	my($html)=Meta::Utils::File::File::load($file);
	my(@forms)=HTML::Form->parse($html,$url);
	my($form)=$forms[1];
	$form->value(words=>$name);
	$form->value(featuring=>$dire);
#	$form->dump();
	my($req)=$form->click();
	$req->referer("http://www.nomorebillgates.org");
	my($res)=$self->request($req);
	if($res->is_error()) {
		Meta::Utils::System::die("unable to get url [".$url."] with error [".$res->status_line()."]");
	}
	return($res->content());
}

sub get_page($$$) {
	my($self,$dire,$name)=@_;
	my($url)="http://us.imdb.com/List";
	my($req)=HTTP::Request::Common::POST($url,[ words=>$name,featuring=>$dire ]);
	$req->referer("http://www.nomorebillgates.org");
	my($res)=$self->request($req);
	if($res->is_error()) {
		Meta::Utils::System::die("unable to get url [".$url."] with error [".$res->status_line()."]");
	}
	return($res->content());
}

sub get_title($$) {
	my($self,$titl)=@_;
	my($url)="http://us.imdb.com/Title?".$titl;
	my($req)=HTTP::Request::Common::GET($url);
	$req->referer("http://www.nomorebillgates.org");
	my($res)=$self->request($req);
	if($res->is_error()) {
		Meta::Utils::System::die("unable to get url [".$url."] with error [".$res->status_line()."]");
	}
	return($res->content());
}

sub get_director_id($$$) {
	my($self,$firs,$seco)=@_;
	my($name)=$firs." ".$seco;
	my($url)="http://us.imdb.com/search";
	my($req)=HTTP::Request::Common::POST($url,[ name=>$name,occupation=>"Filmmakers/Crew only" ]);
	$req->referer("http://www.nomorebillgates.org");
	my($res)=$self->request($req);
	if($res->is_error()) {
		Meta::Utils::System::die("unable to get url [".$url."] with error [".$res->status_line()."]");
	}
	return($res->content());
}

sub get_director_id_form($$$) {
	my($self,$firs,$seco)=@_;
	my($name)=$firs." ".$seco;
	my($url)="http://us.imdb.com/search";
	my($file)="html/import/projects/Imdb/search.html";
	$file=Meta::Baseline::Aegis::which($file);
	my($html)=Meta::Utils::File::File::load($file);
	my(@forms)=HTML::Form->parse($html,$url);
	my($form)=$forms[3];
	$form->value(name=>$name);
#	$form->value(occupation=>"Directors");
#	$form->dump();
	my($req)=$form->click();
	$req->referer("http://www.nomorebillgates.org");#this is ok
#	$req->uri($url);# this does not seem to work
#	Meta::Utils::Output::print("req is ".$req->as_string()."\n");
	my($res)=$self->request($req);
	if($res->is_error()) {
		Meta::Utils::System::die("unable to get url [".$url."] with error [".$res->status_line()."]");
	}
	return($res->content());
}

sub get_search_page($) {
	my($self)=@_;
	my($url)="http://us.imdb.com/search";
	my($req)=HTTP::Request::Common::GET($url);
	$req->referer("http://www.nomorebillgates.org");
	my($res)=$self->request($req);
	if($res->is_error()) {
		Meta::Utils::System::die("unable to get url [".$url."] with error [".$res->status_line()."]");
	}
	return($res->content());
}

sub get_birth_name($$$) {
	my($self,$firs,$seco)=@_;
	my($page)=$self->get_director_id_form($firs,$seco);
	my($dom)=Meta::Lang::Html::Html::c2dom($page);
	#this is possible due to XML::XQL and XML::XQL::DOM
	my(@result)=$dom->xql("html/body/table/tr/td/div/table/tr/td/dl/dd");
	#there must be 3 items here
	if($#result!=2) {
		Meta::Utils::System::die("problem since result is not a 3-tuple");
	}
	my($node)=$result[0]->getFirstChild();
	#the node must be a text node
	if($node->getNodeType()==XML::DOM::TEXT_NODE) {
		my($data)=$node->getData();
		return($data);
	} else {
		return(undef);
	}
}

sub TEST($) {
	my($context)=@_;
	return(1);
}

1;

__END__

=head1 NAME

Meta::Imdb::Get - module to help you get information from IMDB.

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

	MANIFEST: Get.pm
	PROJECT: meta
	VERSION: 0.13

=head1 SYNOPSIS

	package foo;
	use Meta::Imdb::Get qw();
	my($object)=Meta::Imdb::Get->new();
	my($page)=$object->get_page("Woody Allen","Manhattan");

=head1 DESCRIPTION

This module will ease the task of getting information from IMDB.
Just use its method and get the film info.

=head1 FUNCTIONS

	new($)
	get_page_form($$$)
	get_page($$$)
	get_title($$)
	get_director_id($$$)
	get_director_id_form($$$)
	get_search_page($)
	get_birth_name($$$)
	TEST($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<new($)>

This is a constructor for the Meta::Imdb::Get object.

=item B<get_page_form($$$)>

This method receives an IMDB object, a director and a film name and gives
you the HTML in IMDB which has that information.
The method uses the FORM objects to achieve this.

=item B<get_page($$$)>

This method receives an IMDB object, a director and a film name and gives
you the HTML in IMDB which has that information.
The method uses the regular Request objects to achieve this.

=item B<get_title($$)>

This method receives a title id and returns the page for that title.

=item B<get_director_id($$$)>

This method received a director first and second name and returns the director
imdb id.
This method is broken (Filemmakers/Crew only is not an option).

=item B<get_director_id_form($$$)>

This method is is exactly as get_director_id except it uses a form to do
what it does.

=item B<get_search_page($)>

This will get the search page of imdb.

=item B<get_birth_name($$$)>

This method gets a birth name for a person.

=item B<TEST($)>

Test suite for this module.

=back

=head1 SUPER CLASSES

LWP::UserAgent(3)

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mailto:veltzer@cpan.org
	WWW: http://www.veltzer.org
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV misc fixes
	0.01 MV get imdb ids of directors and movies
	0.02 MV perl packaging
	0.03 MV md5 project
	0.04 MV database
	0.05 MV perl module versions in files
	0.06 MV movies and small fixes
	0.07 MV md5 progress
	0.08 MV more Class method generation
	0.09 MV thumbnail user interface
	0.10 MV more thumbnail issues
	0.11 MV website construction
	0.12 MV web site automation
	0.13 MV SEE ALSO section fix

=head1 SEE ALSO

HTML::Form(3), HTTP::Request(3), HTTP::Request::Common(3), LWP::UserAgent(3), Meta::Baseline::Aegis(3), Meta::Lang::Html::Html(3), Meta::Utils::File::File(3), XML::XQL(3), XML::XQL::DOM(3), strict(3)

=head1 TODO

Nothing.
