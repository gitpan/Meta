#!/bin/echo This is a perl module and should not be run

package Meta::Utils::Opts::Opts;

use strict qw(vars refs subs);
use Meta::Utils::Progname qw();
use Meta::Utils::List qw();
use Meta::Lang::Perl::Perl qw();
use Meta::Utils::System qw();
use Meta::Utils::Color qw();
use Getopt::Long qw();
use Meta::Utils::Opts::Sopt qw();
use Meta::Ds::Ohash qw();
use Gtk qw();
use Meta::Utils::Output qw();
use Class::MethodMaker qw();
use Meta::Utils::File::File qw();

our($VERSION,@ISA);
$VERSION="0.38";
@ISA=qw(Meta::Ds::Ohash);

#sub BEGIN();
#sub new($);
#sub inse($$$$$$$);

#sub def_bool($$$$$);
#sub def_inte($$$$$);
#sub def_stri($$$$$);
#sub def_floa($$$$$);
#sub def_dire($$$$$);
#sub def_newd($$$$$);
#sub def_devd($$$$$);
#sub def_file($$$$$);
#sub def_newf($$$$$);
#sub def_devf($$$$$);
#sub def_enum($$$$$$);

#sub use_color($$$);
#sub use_color_rese($$);

#sub set_standard($);
#sub anal($);
#sub usag($$);
#sub man($$);
#sub get_valu($$);

#sub get_gui($);

#__DATA__

sub BEGIN() {
	Class::MethodMaker->get_set(
		-java=>"_name",
		-java=>"_description",
		-java=>"_author",
		-java=>"_license",
		-java=>"_copyright",
		-java=>"_color",
		-java=>"_free_allo",
		-java=>"_free_stri",
		-java=>"_free_mini",
		-java=>"_free_maxi",
		-java=>"_free_noli",
	);
}

sub new($) {
	my($clas)=@_;
	my($self)=Meta::Ds::Ohash->new();
	bless($self,$clas);
	$self->set_color(1);
	$self->set_free_allo(0);
	$self->set_free_stri("unknown");
	$self->set_free_mini(1);
	$self->set_free_maxi(65000);
	$self->set_free_noli(1);
	return($self);
}

sub inse($$$$$$$) {
	my($self,$name,$desc,$type,$defa,$poin,$enum)=@_;
	my($obje)=Meta::Utils::Opts::Sopt->new();
	$obje->set_name($name);
	$obje->set_description($desc);
	$obje->set_type($type);
	$obje->set_defa($defa);
	$obje->set_poin($poin);
	$obje->set_valu($defa);
	$obje->set_enum($enum);
	$self->insert($name,$obje);
}

sub def_bool($$$$$) {
	my($self,$name,$desc,$defa,$poin)=@_;
	$self->inse($name,$desc,"bool",$defa,$poin,undef);
}

sub def_inte($$$$$) {
	my($self,$name,$desc,$defa,$poin)=@_;
	$self->inse($name,$desc,"inte",$defa,$poin,undef);
}

sub def_stri($$$$$) {
	my($self,$name,$desc,$defa,$poin)=@_;
	$self->inse($name,$desc,"stri",$defa,$poin,undef);
}

sub def_floa($$$$$) {
	my($self,$name,$desc,$defa,$poin)=@_;
	$self->inse($name,$desc,"floa",$defa,$poin,undef);
}

sub def_dire($$$$$) {
	my($self,$name,$desc,$defa,$poin)=@_;
	$self->inse($name,$desc,"dire",$defa,$poin,undef);
}

sub def_newd($$$$$) {
	my($self,$name,$desc,$defa,$poin)=@_;
	$self->inse($name,$desc,"newd",$defa,$poin,undef);
}

sub def_devd($$$$$) {
	my($self,$name,$desc,$defa,$poin)=@_;
	$self->inse($name,$desc,"devd",$defa,$poin,undef);
}

sub def_file($$$$$) {
	my($self,$name,$desc,$defa,$poin)=@_;
	$self->inse($name,$desc,"file",$defa,$poin,undef);
}

sub def_newf($$$$$) {
	my($self,$name,$desc,$defa,$poin)=@_;
	$self->inse($name,$desc,"newf",$defa,$poin,undef);
}

sub def_devf($$$$$) {
	my($self,$name,$desc,$defa,$poin)=@_;
	$self->inse($name,$desc,"devf",$defa,$poin,undef);
}

sub def_enum($$$$$$) {
	my($self,$name,$desc,$defa,$poin,$enum)=@_;
	$self->inse($name,$desc,"enum",$defa,$poin,$enum);
}

sub use_color($$$) {
	my($self,$file,$colo)=@_;
	if($self->get_color()) {
		Meta::Utils::Color::set_color($file,$colo);
	}
}

sub use_color_rese($$) {
	my($self,$file)=@_;
	if($self->get_color()) {
		Meta::Utils::Color::reset($file);
	}
}

sub anal($) {
	my($self)=@_;
	my($file)=Meta::Utils::Output::get_file();
	# fill an array with all the different parameters and types.
	my(@list);
	my(%hash);
	my($size)=$self->size();
	for(my($i)=0;$i<$size;$i++) {
		my($sobj)=$self->elem($i);
		my($name)=$sobj->get_name();
		my($type)=$sobj->get_type();
		my($defa)=$sobj->get_defa();
		my($ostr)=$name;
		if($type eq "bool") {
			$ostr.="!";
		}
		if($type eq "inte") {
			$ostr.=":i";
		}
		if($type eq "stri") {
			$ostr.=":s";
		}
		if($type eq "floa") {
			$ostr.=":f";
		}
		if($type eq "dire" || $type eq "newd" || $type eq "devd") {
			$ostr.=":s";
		}
		if($type eq "file" || $type eq "newf" || $type eq "devf") {
			$ostr.=":s";
		}
		if($type eq "enum") {
			$ostr.=":s";
		}
		push(@list,$ostr);
		$hash{$name}=$defa;
	}
	# find out the name of the program for future use
	my($prog)=Meta::Utils::Progname::progname();
	# now read the rc file and push all the stuff there into the ARGV
	# in the order they appear there. We do this only if we have a home
	# directory
	my($rcfile)=Meta::Utils::Utils::get_home_dir()."/\.".$prog."\.rc";
	if(open(FILE,$rcfile)) {
		my($line);
		while($line=<FILE> || 0) {
			chop($line);
			Meta::Utils::List::add_star(\@ARGV,$line);
		}
		close(FILE) || Meta::Utils::System::die("unable to close file [".$rcfile."]");
	}
	my($resu)=Getopt::Long::GetOptions(\%hash,@list);
	if(!$resu) {
		$self->use_color($file,"red");
		print $file $prog.": unable to parse command line args\n";
		$self->usag($file);
	}
	# move values from the hash back to the objects
	for(my($i)=0;$i<$self->size();$i++) {
		my($sobj)=$self->elem($i);
		my($curr_name)=$sobj->get_name();
		my($valu)=$hash{$curr_name};
		$sobj->set_valu($valu);
	}
	if($self->get_valu("help")==1) {
		$self->use_color($file,"red");
		print $file $prog.": help requested\n";
		$self->usag($file);
	}
	if($self->get_valu("man")==1) {
		$self->man($file);
	}
	if($self->get_valu("quit")==1) {
		Meta::Utils::System::exit(1);
	}
	if($self->get_valu("gtk")==1) {
		Gtk->init();
		my($window)=$self->get_gui();
		Gtk->main();
	}
	if($self->get_valu("license")==1) {
		my($prog)=Meta::Utils::Progname::fullname();
		my($text)=Meta::Utils::File::File::load($prog);
		my($pods)=Meta::Lang::Perl::Perl::get_pods($text);
		my($pod)=$pods->{"LICENSE"};
		$pod=CORE::substr($pod,1);
		Meta::Utils::Output::print($pod);
		Meta::Utils::System::exit(1);
	}
	if($self->get_valu("copyright")==1) {
		my($prog)=Meta::Utils::Progname::fullname();
		my($text)=Meta::Utils::File::File::load($prog);
		my($pods)=Meta::Lang::Perl::Perl::get_pods($text);
		my($pod)=$pods->{"COPYRIGHT"};
		$pod=CORE::substr($pod,1);
		Meta::Utils::Output::print($pod);
		Meta::Utils::System::exit(1);
	}
	# sanity check for sanity types
	for(my($i)=0;$i<$self->size();$i++) {
		my($sobj)=$self->elem($i);
		my($erro);
		if(!$sobj->verify(\$erro)) {
			$self->use_color($file,"red");
			print $file $prog.": ".$erro."\n";
			$self->usag($file);
		}
	}
	# pass values to the pointers requested
	for(my($i)=0;$i<$self->size();$i++) {
		my($sobj)=$self->elem($i);
		my($curr_valu)=$sobj->get_valu();
		my($curr_poin)=$sobj->get_poin();
		$$curr_poin=$curr_valu;
	}
	if(!$self->get_free_allo()) {
		if($#ARGV>=0) {
			$self->use_color($file,"red");
			print $file $prog.": free arguments are not allowed\n";
			print $file $prog.": arguments were [".join(",",@ARGV)."]\n";
			$self->usag($file);
		}
	} else {
		if($#ARGV<$self->get_free_mini()-1) {
			my($numb)=$#ARGV+1;
			$self->use_color($file,"red");
			print $file $prog.": too little free arguments [".$numb."]\n";
			print $file $prog.": minimum required is [".$self->get_free_mini()."]\n";
			print $file $prog.": arguments were [".join(",",@ARGV)."]\n";
			$self->usag($file);
		}
		if($#ARGV>=$self->get_free_maxi()) {
			my($numb)=$#ARGV+1;
			$self->use_color($file,"red");
			print $file $prog.": too many free arguments [".$numb."]\n";
			print $file $prog.": maximum required is [".$self->get_free_maxi()."]\n";
			print $file $prog.": arguments were [".join(",",@ARGV)."]\n";
			$self->usag($file);
		}
	}
}

sub usag($$) {
	my($self,$file)=@_;
	my($prog)=Meta::Utils::Progname::progname();
	$self->use_color($file,"blue");
	print $file $prog.": purpose: [".$self->get_description()."]\n";
	print $file $prog.": author: [".$self->get_author()."]\n";
	print $file $prog.": license: [".$self->get_license()."]\n";
	print $file $prog.": usage: [".$prog."]";
	if($self->get_free_allo()) {
		print $file " [".$self->get_free_stri()."]";
	}
	print $file " [options]\n";
	print $file $prog.": where options are:\n";
	my($size)=$self->size();
	for(my($i)=0;$i<$size;$i++) {
		my($sobj)=$self->valx($i);
		my($curr_name)=$sobj->get_name();
		my($curr_desc)=$sobj->get_description();
		my($curr_type)=$sobj->get_type();
		my($curr_defa)=$sobj->get_defa();
		my($curr_poin)=$sobj->get_poin();
		my($curr_valu)=$sobj->get_valu();
		my($curr_enum)=$sobj->get_enum();
		$self->use_color($file,"clear blue");
		print $file $prog.": \t";
		$self->use_color($file,"bold white");
		print $file $curr_name."\n";
		$self->use_color($file,"clear blue");
		print $file $prog.":\t\ttype [".$curr_type."],\ default [".$curr_defa."]\n";
		print $file $prog.":\t\tdescription [".$curr_desc."]\n";
		if($curr_type eq "enum") {
			my(@arra);
			for(my($j)=0;$j<$curr_enum->size();$j++) {
				push(@arra,$curr_enum->elem($j));
			}
			print $file $prog.":\t\toptions [".join(",",@arra)."]\n";
		}
	}
	if($self->get_free_allo()) {
		print $file $prog.": minimum of [".$self->get_free_mini()."] free arguments required\n";
		if($self->get_free_noli()) {
			print $file $prog.": no maximum limit on number of free arguments placed\n";
		} else {
			print $file $prog.": maximum of [".$self->get_free_maxi()."] free arguments required\n";
		}
	} else {
		print $file $prog.": no free arguments are allowed\n";
	}
	$self->use_color_rese($file);
	Meta::Utils::System::exit(0);
}

sub man($$) {
	my($self,$file)=@_;
	my($prog)=Meta::Utils::Progname::fullname();
	Meta::Lang::Perl::Perl::man_file($prog);
	Meta::Utils::System::exit(0);
}

sub get_valu($$) {
	my($self,$name)=@_;
	my($sobj)=$self->get($name);
	return($sobj->get_valu());
}

sub set_standard($) {
	my($self)=@_;
	$self->{STANDARD_HELP}=defined;
	$self->{STANDARD_MANX}=defined;
	$self->{STANDARD_QUIT}=defined;
	$self->{STANDARD_GTKX}=defined;
	$self->{STANDARD_LICE}=defined;
	$self->{STANDARD_COPY}=defined;
	$self->def_bool("help","display help message",0,\$self->{STANDARD_HELP});
	$self->def_bool("man","display manual page",0,\$self->{STANDARD_MANX});
	$self->def_bool("quit","quit without doing anything",0,\$self->{STANDARD_QUIT});
	$self->def_bool("gtk","run a gtk ui to get the parameters",0,\$self->{STANDARD_GTKX});
	$self->def_bool("license","show license and exit",0,\$self->{STANDARD_LICE});
	$self->def_bool("copyright","show copyright and exit",0,\$self->{STANDARD_COPY});
}

sub get_gui($) {
	my($self)=@_;
	my($size)=$self->size();
	my($packer)=Gtk::VBox->new(0,0);
	my($tip)=Gtk::Tooltips->new();
	for(my($i)=0;$i<$size;$i++) {
		my($sobj)=$self->elem($i);
		my($name)=$sobj->get_name();
		my($desc)=$sobj->get_description();
		my($type)=$sobj->get_type();
		my($defa)=$sobj->get_defa();
		my($enum)=$sobj->get_enum();
		my($pack);
		my($spac)=10;
		if($type eq "bool") {
			$pack=Gtk::HBox->new(1,$spac);
			my($button)=Gtk::CheckButton->new($name);
			$button->set_active($defa);
			$button->show();
			$pack->pack_start($button,1,0,0);
			$tip->set_tip($button,$desc,"");
		}
		if($type eq "inte") {
			$pack=Gtk::HBox->new(1,$spac);
			my($label)=Gtk::Label->new();
			$label->set_text($name);
			$label->show();
			my($adju)=Gtk::Adjustment->new($defa,-10000,10000,1,2,0);
			my($spin)=Gtk::SpinButton->new($adju,1,4);
			$spin->set_digits(0);
			$spin->show();
			$pack->pack_start_defaults($label);
			$pack->pack_start_defaults($spin);
			$tip->set_tip($spin,$desc,"");
		}
		if($type eq "stri") {
			$pack=Gtk::HBox->new(1,$spac);
			my($label)=Gtk::Label->new();
			$label->set_text($name);
			$label->show();
			my($entry)=Gtk::Entry->new();
			$entry->set_text($defa);
			$entry->show();
			$pack->pack_start_defaults($label);
			$pack->pack_start_defaults($entry);
			$tip->set_tip($entry,$desc,"");
		}
		if($type eq "floa") {
			$pack=Gtk::HBox->new(1,$spac);
			my($label)=Gtk::Label->new();
			$label->set_text($name);
			$label->show();
			my($adju)=Gtk::Adjustment->new($defa,-10,10,1,2,0);
			my($spin)=Gtk::SpinButton->new($adju,1,4);
			$spin->show();
			$pack->pack_start_defaults($label);
			$pack->pack_start_defaults($spin);
			$tip->set_tip($spin,$desc,"");
		}
		if($type eq "dire" || $type eq "newd" || $type eq "devd") {
			my($label)=Gtk::Label->new($name);
			$label->show();
			my($entry)=Gtk::Entry->new();
			$entry->set_editable(0);
			$entry->set_text($defa);
			$entry->show();
			$pack=Gtk::HBox->new(1,$spac);
			$pack->pack_start_defaults($label);
			$pack->pack_start_defaults($entry);
			$tip->set_tip($entry,$desc,"");
		}
		if($type eq "file" || $type eq "newf" || $type eq "devf") {
			my($label)=Gtk::Label->new($name);
			$label->show();
			my($entry)=Gtk::Entry->new();
			$entry->set_text($defa);
			$entry->set_editable(0);
			$entry->show();
			$pack=Gtk::HBox->new(1,$spac);
			$pack->pack_start_defaults($label);
			$pack->pack_start_defaults($entry);
			$tip->set_tip($entry,$desc,"");
		}
		if($type eq "enum") {
			$pack=Gtk::HBox->new(1,$spac);
			my($label)=Gtk::Label->new();
			$label->set_text($name);
			my($combo)=Gtk::Combo->new();
			my(@arra);
			for(my($i)=0;$i<$enum->size();$i++) {
				my($curr)=$enum->elem($i);
#				Meta::Utils::Output::print("adding [".$curr."]\n");
				push(@arra,$curr);
			}
			$label->show();
			$combo->set_popdown_strings(@arra);
			$combo->set_value_in_list(1,0);
			$combo->entry->set_text($defa);
			$combo->entry->set_editable(0);
			$combo->show();
			$pack->pack_start_defaults($label);
			$pack->pack_start_defaults($combo);
			$tip->set_tip($combo->entry,$desc,"");
		}
		$pack->show();
		$packer->pack_start_defaults($pack);
	}
	$packer->show();
	my($sep)=Gtk::HSeparator->new();
	$sep->show();
	my($button_run)=Gtk::Button->new("Run");
	$button_run->show();
	my($button_quit)=Gtk::Button->new("Quit");
	$button_quit->show();
	my($button_box)=Gtk::HBox->new(0,0);
	$button_box->pack_start($button_run,1,0,0);
	$button_box->pack_start($button_quit,1,0,0);
	$button_box->show();
	my($final_packer)=Gtk::VBox->new(0,0);
	$final_packer->pack_start_defaults($packer);
	$final_packer->pack_start($sep,0,1,5);
	$final_packer->pack_start_defaults($button_box);
	$final_packer->show();
	my($window)=Gtk::Window->new("dialog");
	$window->add($final_packer);
	$window->show();
	return($window);
}

1;

__END__

=head1 NAME

Meta::Utils::Opts::Opts - Module to help you analyze command line arguments.

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

	MANIFEST: Opts.pm
	PROJECT: meta
	VERSION: 0.38

=head1 SYNOPSIS

	package foo;
	use Meta::Utils::Opts::Opts qw();
	my($obj)=Meta::Utils::Opts::Opts->new();
	$obj->set_standard();
	$obj->set_free_allo(0);
	$obj->anal(\@ARGV);

=head1 DESCRIPTION

This is a library to handle command line arguments for shell scripts.
It surrounds the Getopt::Long library and gives a nicer interface.
The way to use the library is this:
first you have to prepare a list of variables (of different types of course)
which will control the behaviour of your software.
These values will be overriden by the user if neccessary (or by rc files of
the user if neccessary...).
0. call init to initialize the library.
1. call desc to describe what your program does.
2. call auth to describe the author which wrote your program.
3. call (or not call) standard to use standard settings.
4. call a lot of def_{type} routine to define all the arguments
	to your software (these will include default values).
5. call free/free_mini/free_maxi if you want to allow free arguments to
	your program or set_free_allo(0) to disallow free arguments to your program.
6. call anal.
	If this routine succeds it means that all options given on the
	command line were valid and all files and directory options
	were indeed valid files and directories.
7. the values of the different arguements are in the variables you specified
	as linkage.
8. If you allowed free arguments they are the only thing left in ARGV
	after the anal call was made and you can access them from there.
9. If any error was made in the argument passing by the user then the anal
	routine will abort with appropriate error and correct usage messages.

* You can call the usage routine of this module whenever you like to print
	out a usage message.

Currently supported types for parameters are:
	bool			bool
	integer			inte
	string			stri
	float			floa
	directory		dire
	new directory		newd
	development directory	devd
	file			file
	new file		newf
	development file	devf
	enumerated values	enum

=head1 FUNCTIONS

	BEGIN()
	new($)
	inse($$$$$$$)
	def_bool($$$$$)
	def_inte($$$$$)
	def_stri($$$$$)
	def_floa($$$$$)
	def_dire($$$$$)
	def_newd($$$$$)
	def_devd($$$$$)
	def_file($$$$$)
	def_newf($$$$$)
	def_devf($$$$$)
	def_enum($$$$$$)
	use_color($$$)
	use_color_rese($$)
	set_standard($)
	anal($)
	usag($$)
	man($$)
	get_valu($$)
	get_gui($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<BEGIN()>

IT will also setup get/set method for the following attributes:
name - name of this program.
description - description of this program.
author - author of this program.
license - license under which the program is distributed.
copyright - copyright under which the program is distributed.
color - use color when printing ?
free_allo - allow free arguments on the cmd line ?
free_stri - what is the purpose of the free arguments ?
free_mini - minimum number of free arguments.
free_maxi - maximum number of free arguments.
free_noli - set no limit on the number of free arguments ?

=item B<new($)>

Constructor for this class.

=item B<inse($$$$$$$)>

Inserts an option string, with a type and a default value.

=item B<def_bool($$$$$)>

Add a boolean argument to the options.

=item B<def_inte($$$$$)>

Add an integer argument.

=item B<def_stri($$$$$)>

Add a string argument.

=item B<def_floa($$$$$)>

Add a float argument.

=item B<def_dire($$$$$)>

Add a directory argument (checks that the directory is valid).

=item B<def_newd($$$$$)>

Add a directory new directory argument (checks that the directory does not exist).

=item B<def_devd($$$$$)>

Add a development directory argument (checks that the directory exists).

=item B<def_file($$$$$)>

Add a file aegument (checks that the file is valid).

=item B<def_newf($$$$$)>

Add a new file aegument (checks that the file is non-existant).

=item B<def_devf($$$$$)>

Add a new development file aegument (checks that the file is non-existant).

=item B<def_enum($$$$$$)>

Add an enumerated argument (checks that the value is out of a set of values).

=item B<use_color($$$)>

This method will print color sequences to the file given if color is used.

=item B<use_color_rese($$)>

This method will reset color usage on the specified file.

=item B<anal($)>

This analyzes the arguments, stores the results and is ready to answer
questions about what is going down.

=item B<usag($)>

This routine prints the programs usage statement to standard error with
the program name and all the parameters along with their types and default
values.
The file on which to print the usage is a parameter.

=item B<man($$)>

Show the manual page for this program.
The file on which the manual is shown is a paramter.

A different path to implementation would be to get the name
of the program (not full name but only executable name) and
then ask for a man page on that but the problem is that some
executables are NOT in the path.

=item B<get_valu($$)>

This method will retrieve the current value of some option.

=item B<set_standard($)>

This does the standard initialization for base command line options.
Regularly, this is the first routine you should call if you want to
do command line parsing the base way.
Currently this sets up the help variable correctly.

=item B<get_gui($)>

This method will show a gui for the options.

=back

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mark2776@yahoo.com
	WWW: http://www.geocities.com/mark2776
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV make Meta::Utils::Opts object oriented
	0.01 MV more harsh checks on perl code
	0.02 MV fix todo items look in pod documentation
	0.03 MV add enumerated types to options
	0.04 MV more on tests/more checks to perl
	0.05 MV change new methods to have prototypes
	0.06 MV UI for Opts.pm
	0.07 MV fix up perl cooking a lot
	0.08 MV correct die usage
	0.09 MV fix expect.pl test
	0.10 MV more organization
	0.11 MV perl code quality
	0.12 MV more perl quality
	0.13 MV more perl quality
	0.14 MV make all papers papers
	0.15 MV perl documentation
	0.16 MV more perl quality
	0.17 MV perl qulity code
	0.18 MV more perl code quality
	0.19 MV more perl quality
	0.20 MV revision change
	0.21 MV better general cook schemes
	0.22 MV languages.pl test online
	0.23 MV xml/rpc client/server
	0.24 MV html site update
	0.25 MV perl packaging
	0.26 MV PDMT
	0.27 MV license issues
	0.28 MV pictures database
	0.29 MV tree type organization in databases
	0.30 MV more movies
	0.31 MV md5 project
	0.32 MV database
	0.33 MV perl module versions in files
	0.34 MV movies and small fixes
	0.35 MV graph visualization
	0.36 MV thumbnail user interface
	0.37 MV dbman package creation
	0.38 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

-add nicer type description for each option type.

-Add some more features: 0. must parameters - paramters which must be there. 1. integer parameters which are limited in range. 3. a parameter which is a regular expression (and test the regular expression) 4. parameters which are allowed a selection out of a set.

-The help is not handled well if there is a limit on the minimal number of free arguments (if the user just asks --help that check fails and the usage is printed with an error but actually this is not an error...)

-do it so if I have a fixed sized list of free args I could also attach them to variables (this way I dont have to have lines like one,two,three=ARGV0,ARGV1,ARGV2 in my scripts....(maybe even a more general approach of fixed sized coming first and then var sized ?)

-in the usage print that option passing is in the GNU stype. Maybe even offer an option to show help on passing GNU args... add a document and help on how to set user defined defaults (if you implement that mechanism).

-add an option for a parameter type for a file to be written which is not yet on the disk (or is on the disk, or doesnt care...). The options module will check that the file can be created if need be.

-fix the man command which does not use the file argument given to it.

-make the --license command actually print the GPL.

-make the --copyright command actually print the copyright message.

-if the name is not set by the script then extract it from the script itself.
