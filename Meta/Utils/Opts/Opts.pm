#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Utils::Opts::Opts - Module to help you analyze command line arguments.

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

MANIFEST: Opts.pm
PROJECT: meta

=head1 SYNOPSIS

C<package foo;>
C<use Meta::Utils::Opts::Opts qw();>
C<my($obj)=Meta::Utils::Opts::Opts->new();>
C<$obj->set_standard();>
C<$obj->set_free_allo(0);>
C<$obj->anal(\@ARGV);>

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
	file			file

=head1 EXPORTS

C<new($)>
C<inse($$$$$$$)>
C<def_bool($$$$$)>
C<def_inte($$$$$)>
C<def_stri($$$$$)>
C<def_floa($$$$$)>
C<def_dire($$$$$)>
C<def_file($$$$$)>
C<def_newf($$$$$)>
C<def_enum($$$$$$)>
C<get_free_allo($)>
C<set_free_allo($$)>
C<get_free_stri($)>
C<set_free_stri($$)>
C<get_free_mini($)>
C<set_free_mini($$)>
C<get_free_maxi($)>
C<set_free_maxi($$)>
C<get_free_noli($)>
C<set_free_noli($$)>
C<get_colo($)>
C<set_colo($$)>
C<use_colo($$$)>
C<use_colo_rese($$)>
C<set_standard($)>
C<anal($)>
C<usag($$)>
C<man($$)>
C<get_valu($$)>
C<get_desc($)>
C<set_desc($$)>
C<get_auth($)>
C<set_auth($$)>
C<get_lice($)>
C<set_lice($$)>
C<get_gui($)>

=cut

package Meta::Utils::Opts::Opts;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT);
use Meta::Utils::Progname qw();
use Meta::Utils::List qw();
use Meta::Baseline::Lang::Perl qw();
use Meta::Utils::System qw();
use Meta::Utils::Color qw();
use Getopt::Long qw();
use Meta::Utils::Opts::Sopt qw();
use Meta::Ds::Ohash qw();
use Gtk qw();
use Meta::Utils::Output qw();

$VERSION="1.00";
@ISA=qw(Exporter Meta::Ds::Ohash);
@EXPORT_OK=qw();
@EXPORT=qw();

#sub new($);
#sub inse($$$$$$$);

#sub def_bool($$$$$);
#sub def_inte($$$$$);
#sub def_stri($$$$$);
#sub def_floa($$$$$);
#sub def_dire($$$$$);
#sub def_file($$$$$);
#sub def_newf($$$$$);
#sub def_enum($$$$$$);

#sub get_free_allo($);
#sub set_free_allo($$);
#sub get_free_stri($);
#sub set_free_stri($$);
#sub get_free_mini($);
#sub set_free_mini($$);
#sub get_free_maxi($);
#sub set_free_maxi($$);
#sub get_free_noli($);
#sub set_free_noli($$);

#sub get_colo($);
#sub set_colo($$);
#sub use_colo($$$);
#sub use_colo_rese($$);

#sub set_standard($);
#sub anal($);
#sub usag($$);
#sub man($$);
#sub get_valu($$);

#sub get_desc($);
#sub set_desc($$);
#sub get_auth($);
#sub set_auth($$);
#sub get_lice($);
#sub set_lice($$);

#sub get_gui($);

#__DATA__

=head1 FUNCTION DOCUMENTATION

=over

=item B<new($)>

This will give you a new Meta::Utils::Opts::Opts object.

=cut

sub new($) {
	my($clas)=@_;
	my($self)=Meta::Ds::Ohash->new();
	bless($self,$clas);

	$self->{DESC}=defined;
	$self->{AUTH}=defined;
	$self->{LICE}=defined;

	$self->{COLO}=1;

	$self->{FREEALLO}=0;
	$self->{FREESTRI}="unknwon";
	$self->{FREEMINI}=1;
	$self->{FREEMAXI}=65000;
	$self->{FREENOLI}=0;

	return($self);
}

=item B<inse($$$$$$$)>

Inserts an option string, with a type and a default value.

=cut

sub inse($$$$$$$) {
	my($self,$name,$desc,$type,$defa,$poin,$enum)=@_;
	my($obje)=Meta::Utils::Opts::Sopt->new();
	$obje->set_name($name);
	$obje->set_desc($desc);
	$obje->set_type($type);
	$obje->set_defa($defa);
	$obje->set_poin($poin);
	$obje->set_valu($defa);
	$obje->set_enum($enum);
	$self->insert($name,$obje);
}

=item B<def_bool($$$$$)>

Add a boolean argument to the options.

=cut

sub def_bool($$$$$) {
	my($self,$name,$desc,$defa,$poin)=@_;
	$self->inse($name,$desc,"bool",$defa,$poin,undef);
}

=item B<def_inte($$$$$)>

Add an integer argument.

=cut

sub def_inte($$$$$) {
	my($self,$name,$desc,$defa,$poin)=@_;
	$self->inse($name,$desc,"inte",$defa,$poin,undef);
}

=item B<def_stri($$$$$)>

Add a string argument.

=cut

sub def_stri($$$$$) {
	my($self,$name,$desc,$defa,$poin)=@_;
	$self->inse($name,$desc,"stri",$defa,$poin,undef);
}

=item B<def_floa($$$$$)>

Add a float argument.

=cut

sub def_floa($$$$$) {
	my($self,$name,$desc,$defa,$poin)=@_;
	$self->inse($name,$desc,"floa",$defa,$poin,undef);
}

=item B<def_dire($$$$$)>

Add a directory argument (checks that the directory is valid).

=cut

sub def_dire($$$$$) {
	my($self,$name,$desc,$defa,$poin)=@_;
	$self->inse($name,$desc,"dire",$defa,$poin,undef);
}

=item B<def_file($$$$$)>

Add a file aegument (checks that the file is valid).

=cut

sub def_file($$$$$) {
	my($self,$name,$desc,$defa,$poin)=@_;
	$self->inse($name,$desc,"file",$defa,$poin,undef);
}

=item B<def_newf($$$$$)>

Add a new file aegument (checks that the file is non-existant).

=cut

sub def_newf($$$$$) {
	my($self,$name,$desc,$defa,$poin)=@_;
	$self->inse($name,$desc,"newf",$defa,$poin,undef);
}

=item B<def_enum($$$$$$)>

Add an enumerated argument (checks that the value is out of a set of values).

=cut

sub def_enum($$$$$$) {
	my($self,$name,$desc,$defa,$poin,$enum)=@_;
	$self->inse($name,$desc,"enum",$defa,$poin,$enum);
}

=item B<get_colo($)>

This method will return whether color printing will be used by this object.

=cut

sub get_colo($) {
	my($self)=@_;
	return($self->{COLO});
}

=item B<set_colo($$)>

This method will set whether this object will use color printing or not.

=cut

sub set_colo($$) {
	my($self,$valx)=@_;
	$self->{COLO}=$valx;
}

=item B<use_colo($$$)>

This method will print color sequences to the file given if color is used.

=cut

sub use_colo($$$) {
	my($self,$file,$colo)=@_;
	if($self->get_colo()) {
		Meta::Utils::Color::set_color($file,$colo);
	}
}

=item B<use_colo_rese($$)>

This method will reset color usage on the specified file.

=cut

sub use_colo_rese($$) {
	my($self,$file)=@_;
	if($self->get_colo()) {
		Meta::Utils::Color::reset($file);
	}
}

=item B<get_free_allo($)>

This will tell you if free arguments on the command line are allowed.

=cut

sub get_free_allo($) {
	my($self)=@_;
	return($self->{FREEALLO});
}

=item B<set_free_allo($$)>

This routine declares that free arguments are allowed on the command
line and the parameter given is the title string for usage printing
etc...

=cut

sub set_free_allo($$) {
	my($self,$valx)=@_;
	$self->{FREEALLO}=$valx;
}

=item B<get_free_stri($)>

This will tell you how free arguments are going to be described on the command line usage.

=cut

sub get_free_stri($) {
	my($self)=@_;
	return($self->{FREESTRI});
}

=item B<set_free_stri($$)>

This will set the string which will be used to describe free arguments on the command line usage.

=cut

sub set_free_stri($$) {
	my($self,$valx)=@_;
	$self->{FREESTRI}=$valx;
}

=item B<get_free_mini($)>

This method will return the minimal number of free arguments which are allowed on the command line.

=cut

sub get_free_mini($) {
	my($self)=@_;
	return($self->{FREEMINI});
}

=item B<set_free_mini($$)>

This routine sets the minimum number of free arguments that a program
is supposed to accept. (the default value of this is 0).

=cut

sub set_free_mini($$) {
	my($self,$valx)=@_;
	$self->{FREEMINI}=$valx;
}

=item B<get_free_maxi($)>

This method will return the maximal number of free arguments which are allowed on the command line.

=cut

sub get_free_maxi($) {
	my($self)=@_;
	return($self->{FREEMAXI});
}

=item B<set_free_maxi($$)>

This routine sets the maximum number of free arguments that a program
is supposed to accept.

=cut

sub set_free_maxi($$) {
	my($self,$maxi)=@_;
	$self->{FREEMAXI}=$maxi;
}

=item B<get_free_noli($)>

This method will return whether there is a maximal limit on the number of
free arguments allowed on the command line.

=cut

sub get_free_noli($) {
	my($self)=@_;
	return($self->{FREENOLI});
}

=item B<set_free_noli($$)>

This routine sets no limit on the nubmer of free arguments that a program
is supposed to accept.

=cut

sub set_free_noli($$) {
	my($self,$valx)=@_;
	$self->{FREENOLI}=$valx;
}

=item B<anal($)>

This analyzes the arguments, stores the results and is ready to answer
questions about what is going down.

=cut

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
		if($type eq "dire") {
			$ostr.=":s";
		}
		if($type eq "file") {
			$ostr.=":s";
		}
		if($type eq "newf") {
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
		$self->use_colo($file,"red");
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
	# sanity check for sanity types
	for(my($i)=0;$i<$self->size();$i++) {
		my($sobj)=$self->elem($i);
		my($erro);
		if(!$sobj->verify(\$erro)) {
			$self->use_colo($file,"red");
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
	if($self->get_valu("help")==1) {
		$self->use_colo($file,"red");
		print $file $prog.": help requested\n";
		$self->usag($file);
	}
	if($self->get_valu("man")==1) {
		$self->man($file);
	}
	if($self->get_valu("quit")==1) {
		Meta::Utils::System::sexo(1);
	}
	if($self->get_valu("gtk")==1) {
		Gtk->init();
		my($window)=$self->get_gui();
		Gtk->main();
	}
	if($self->get_valu("license")==1) {
		Meta::Utils::Output::print("GPL\n");
		Meta::Utils::System::sexo(1);
	}
	if(!$self->get_free_allo()) {
		if($#ARGV>=0) {
			$self->use_colo($file,"red");
			print $file $prog.": free arguments are not allowed\n";
			print $file $prog.": arguments were [".join(",",@ARGV)."]\n";
			$self->usag($file);
		}
	} else {
		if($#ARGV<$self->get_free_mini()-1) {
			my($numb)=$#ARGV+1;
			$self->use_colo($file,"red");
			print $file $prog.": too little free arguments [".$numb."]\n";
			print $file $prog.": minimum required is [".$self->get_free_mini()."]\n";
			print $file $prog.": arguments were [".join(",",@ARGV)."]\n";
			$self->usag($file);
		}
		if($#ARGV>=$self->get_free_maxi()) {
			my($numb)=$#ARGV+1;
			$self->use_colo($file,"red");
			print $file $prog.": too many free arguments [".$numb."]\n";
			print $file $prog.": maximum required is [".$self->get_free_maxi()."]\n";
			print $file $prog.": arguments were [".join(",",@ARGV)."]\n";
			$self->usag($file);
		}
	}
}

=item B<usag($)>

This routine prints the programs usage statement to standard error with
the program name and all the parameters along with their types and default
values.
The file on which to print the usage is a parameter.

=cut

sub usag($$) {
	my($self,$file)=@_;
	my($prog)=Meta::Utils::Progname::progname();
	$self->use_colo($file,"blue");
	print $file "$prog: purpose: [".$self->get_desc()."]\n";
	print $file "$prog: author: [".$self->get_auth()."]\n";
	print $file "$prog: license: [".$self->get_lice()."]\n";
	print $file "$prog: usage: [".$prog."]";
	if($self->get_free_allo()) {
		print $file " [".$self->get_free_stri()."]";
	}
	print $file " [options]\n";
	print $file $prog.": where options are:\n";
	my($size)=$self->size();
	for(my($i)=0;$i<$size;$i++) {
		my($sobj)=$self->valx($i);
		my($curr_name)=$sobj->get_name();
		my($curr_desc)=$sobj->get_desc();
		my($curr_type)=$sobj->get_type();
		my($curr_defa)=$sobj->get_defa();
		my($curr_poin)=$sobj->get_poin();
		my($curr_valu)=$sobj->get_valu();
		my($curr_enum)=$sobj->get_enum();
		$self->use_colo($file,"clear blue");
		print $file $prog.": \t";
		$self->use_colo($file,"bold white");
		print $file $curr_name."\n";
		$self->use_colo($file,"clear blue");
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
	$self->use_colo_rese($file);
	Meta::Utils::System::sexo(0);
}

=item B<man($$)>

Show the manual page for this program.
The file on which the manual is shown is a paramter.

=cut

sub man($$) {
	my($self,$file)=@_;
	my($prog)=Meta::Utils::Progname::progname();
	Meta::Baseline::Lang::Perl::man($prog);
	Meta::Utils::System::sexo(0);
}

=item B<get_valu($$)>

This method will retrieve the current value of some option.

=cut

sub get_valu($$) {
	my($self,$name)=@_;
	my($sobj)=$self->get($name);
	return($sobj->get_valu());
}

=item B<set_standard($)>

This does the standard initialization for base command line options.
Regularly, this is the first routine you should call if you want to
do command line parsing the base way.
Currently this sets up the help variable correctly.

=cut

sub set_standard($) {
	my($self)=@_;
	$self->{STANDARD_HELP}=defined;
	$self->{STANDARD_MANX}=defined;
	$self->{STANDARD_QUIT}=defined;
	$self->{STANDARD_GTKX}=defined;
	$self->{STANDARD_LICE}=defined;
	$self->def_bool("help","display help message",0,\$self->{STANDARD_HELP});
	$self->def_bool("man","display manual page",0,\$self->{STANDARD_MANX});
	$self->def_bool("quit","quit without doing anything",0,\$self->{STANDARD_QUIT});
	$self->def_bool("gtk","run a gtk ui to get the parameters",0,\$self->{STANDARD_GTKX});
	$self->def_bool("license","show license and exit",0,\$self->{STANDARD_LICE});
}

=item B<get_desc($)>

This method will return the description of the current software.

=cut

sub get_desc($) {
	my($self)=@_;
	return($self->{DESC});
}

=item B<set_desc($$)>

This routine defines for the Opts module a one line description of what
your software does. This will be stored in the module and used later
(for instance when printing the software's usage or help...).

=cut

sub set_desc($$) {
	my($self,$valx)=@_;
	$self->{DESC}=$valx;
}

=item B<get_auth($)>

This method will return the author of the current software.

=cut

sub get_auth($) {
	my($self)=@_;
	return($self->{AUTH});
}

=item B<set_auth($$)>

This routine defines for the Opts module the name of the author of
the file. This will be stored in the module and used later
(for instance when printing the software's usage or help...).

=cut

sub set_auth($$) {
	my($self,$auth)=@_;
	$self->{AUTH}=$auth;
}

=item B<get_lice($)>

This method will return the license of the current software.

=cut

sub get_lice($) {
	my($self)=@_;
	return($self->{LICE});
}

=item B<set_lice($$)>

This routine defines for the Opts module the license of
the software. This will be stored in the module and used later
(for instance when printing the software's usage or help...).

=cut

sub set_lice($$) {
	my($self,$valx)=@_;
	$self->{LICE}=$valx;
}

=item B<get_gui($)>

This method will show a gui for the options.

=cut

sub get_gui($) {
	my($self)=@_;
	my($size)=$self->size();
	my($packer)=Gtk::VBox->new(0,0);
	my($tip)=Gtk::Tooltips->new();
	for(my($i)=0;$i<$size;$i++) {
		my($sobj)=$self->elem($i);
		my($name)=$sobj->get_name();
		my($desc)=$sobj->get_desc();
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
		if($type eq "dire") {
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
		if($type eq "file") {
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

=back

=head1 BUGS

None.

=head1 AUTHOR

Mark Veltzer <mark2776@yahoo.com>

=head1 HISTORY

start of revision info
1	Sun Jan  7 18:17:29 2001	MV	make Meta::Utils::Opts object oriented
2	Sun Jan  7 20:46:54 2001	MV	more harsh checks on perl code
3	Tue Jan  9 19:29:31 2001	MV	fix todo items look in pod documentation
4	Tue Jan  9 22:40:39 2001	MV	add enumerated types to options
5	Wed Jan 10 12:05:55 2001	MV	more on tests/more checks to perl
6	Fri Jan 12 15:53:19 2001	MV	change new methods to have prototypes
7	Sat Jan 13 08:28:57 2001	MV	UI for Opts.pm
8	Sun Jan 14 05:25:04 2001	MV	fix up perl cooking a lot
9	Thu Jan 18 15:59:13 2001	MV	correct die usage
10	Thu Jan 18 19:33:43 2001	MV	fix expect.pl test
11	Fri Jan 19 12:38:57 2001	MV	more organization
12	Sun Jan 28 02:34:56 2001	MV	perl code quality
13	Sun Jan 28 13:51:26 2001	MV	more perl quality
14	Tue Jan 30 03:03:17 2001	MV	more perl quality
15	Sat Feb  3 03:39:36 2001	MV	make all papers papers
16	Sat Feb  3 23:41:08 2001	MV	perl documentation
17	Mon Feb  5 03:21:02 2001	MV	more perl quality
18	Tue Feb  6 01:04:52 2001	MV	perl qulity code
19	Tue Feb  6 07:02:13 2001	MV	more perl code quality
20	Tue Feb  6 08:47:46 2001	MV	more perl quality
21	Tue Feb  6 22:19:51 2001	MV	revision change
22	Thu Feb  8 00:23:21 2001	MV	betern general cook schemes
end of revision info

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

=cut
