#!/usr/bin/env perl

use strict qw(vars refs subs);
use POSIX qw();
use File::Basename qw();
use Carp qw();

sub develop_misc_bada($) {
	my($valx)=@_;
	if(!$valx) {
		Carp::confess("develop_misc_bada: error: got [".$valx."] from check routine");
	}
}

sub develop_misc_prog() {
	return(File::Basename::basename($0));
}

sub develop_syst_runx($) {
	my($comm)=@_;
	my($text);
	open(FILE,$comm." |") || Carp::confess("develop_aegi_subx: unable to run [".$comm."]");
	my($line);
	while($line=<FILE> || 0) {
		$text.=$line;
	}
	close(FILE) || Carp::confess("develop_aegi_subx: unable to close file [".$comm."]");
	chop($text);
	return($text);
}

sub develop_file_temp() {
	return(POSIX::tmpnam());
}

sub develop_chec_dire($) {
	my($para)=@_;
	return(-d $para);
}

sub develop_chec_mdir($$) {
	my($sepa,$para)=@_;
	my(@vals)=split($sepa,$para);
	for(my($i)=0;$i<=$#vals;$i++) {
		my($curr)=$vals[$i];
		if(!develop_chec_dire($curr)) {
			return(0);
		}
	}
	return(1);
}

sub develop_chec_file($) {
	my($para)=@_;
	return(-f $para);
}

sub develop_chec_mfil($$) {
	my($sepa,$para)=@_;
	my(@vals)=split($sepa,$para);
	for(my($i)=0;$i<=$#vals;$i++) {
		my($curr)=$vals[$i];
		if(!develop_chec_file($curr)) {
			return(0);
		}
	}
	return(1);
}

sub develop_chec_exec($) {
	my($para)=@_;
	return(-x $para);
}

sub develop_chec_ynxx($) {
	my($para)=@_;
	if($para!=0 && $para!=1) {
		return(0);
	} else {
		return(1);
	}
}

sub develop_chec_stri($) {
	my($para)=@_;
	return(1);
}

sub develop_chec_path($) {
	my($para)=@_;
	return(1);
}

sub develop_aegi_vars($$$) {
	my($verb,$pprj,$pchn)=@_;
	my($uid)=POSIX::getuid();
	my($home)=(POSIX::getpwuid($uid))[7];
	my($file)=$home."/.aegisrc";
	my($text);
	open(FILE,$file) || Carp::confess("unable to open [$file]");
	my($line);
	while($line=<FILE> || 0) {
		$text.=$line;
	}
	close(FILE) || Carp::confess("unable to close [$file]");
	my(@stat)=split(";",$text);
	my(%hash);
	for(my($i)=0;$i<=$#stat;$i++) {
		my($curr)=$stat[$i];
		if($verb) {
			print "curr is [$curr]\n";
		}
		if(!($curr=~/^s*$/)) {
			my($varx,$valx)=($curr=~/^\s*(.*)\s*=\s*(.*)\s*$/);
			$hash{$varx}=$valx;
		}
	}
	$$pprj=$hash{"default_project_name"};
	$$pchn=$hash{"default_change_number"};
	$$pprj=substr($$pprj,1,length($$pprj)-2);
}

sub develop_aegi_subx($$$$) {
	my($aesu,$proj,$chan,$para)=@_;
	my($args)=$aesu." --Project \"".$proj."\" --Change ".$chan." ".$para." |";
	my($text);
	open(FILE,$args) || Carp::confess("develop_aegi_subx: unable to sub [$para]");
	my($line);
	while($line=<FILE> || 0) {
		$text.=$line;
	}
	close(FILE) || Carp::confess("develop_aegi_subx: unable to close file");
	chop($text);
	return($text);
}

sub develop_aegi_chan($$$) {
	my($aesu,$proj,$chan)=@_;
	return(develop_aegi_subx($aesu,$proj,$chan,"\\\${Development_Directory}"));
}

sub develop_aegi_inte($$$) {
	my($aesu,$proj,$chan)=@_;
	return(develop_aegi_subx($aesu,$proj,$chan,"\\\${Integration_Directory}"));
}

sub develop_aegi_base($$$) {
	my($aesu,$proj,$chan)=@_;
	return(develop_aegi_subx($aesu,$proj,$chan,"\\\${Baseline}"));
}

sub develop_aegi_stat($$$) {
	my($aesu,$proj,$chan)=@_;
	return(develop_aegi_subx($aesu,$proj,$chan,"\\\${State}"));
}

sub develop_aegi_sear($$$) {
	my($aesu,$proj,$chan)=@_;
	return(develop_aegi_subx($aesu,$proj,$chan,"\\\${Search_Path}"));
}

sub develop_aegi_inch($$$) {
	my($aesu,$proj,$chan)=@_;
	my($stat)=develop_aegi_stat($aesu,$proj,$chan);
	return(
		($stat eq "being_developed") ||
		($stat eq "being_integrated") ||
		($stat eq "being_reviewed") ||
		($stat eq "awaiting_integration")
	);
}

sub develop_aegi_find($$$$) {
	my($aesu,$proj,$chan,$file)=@_;
	return(develop_aegi_subx($aesu,$proj,$chan,"\${Source \"".$file."\" Absolute}"));
}

sub develop_aegi_sour($$$$) {
	my($aesu,$proj,$chan,$file)=@_;
	return(develop_chec_file(develop_aegi_find($aesu,$proj,$chan,$file)));
}

sub develop_path_addx($$$) {
	my($onex,$twox,$sepa)=@_;
	if($onex eq "") {
		if($twox eq "") {
			return("");
		} else {
			return($twox);
		}
	} else {
		if($twox eq "") {
			return($onex);
		} else {
			return(join($sepa,$onex,$twox));
		}
	}
}

sub develop_path_mini($$) {
	my($valx,$sepa)=@_;
	my(@arra)=split($sepa,$valx);
	my(%hash);
	my(@narr);
	for(my($i)=0;$i<=$#arra;$i++) {
		my($curr)=$arra[$i];
		if(!exists($hash{$curr})) {
			push(@narr,$curr);
			$hash{$curr}=defined;
		}
	}
	my($resu)=join($sepa,@narr);
	return($resu);
}

sub develop_envx_getx($) {
	my($varx)=@_;
	if(!exists($ENV{$varx})) {
#		Carp::confess("develop_envx_getx: error: unable to find [$varx] in the envrionment");
		return(undef);
	} else {
		return($ENV{$varx});
	}
}

sub develop_envx_setx($$) {
	my($varx,$valx)=@_;
	$ENV{$varx}=$valx;
}

sub develop_envx_addx($$$$) {
	my($varx,$sepa,$valx,$star)=@_;
	my($curr)=develop_envx_getx($varx);
	my($nval);
	if(defined($curr)) {
		if($curr eq "") {
			$nval=$valx;
		} else {
			if($star) {
				$nval=join($sepa,$valx,$curr);
			} else {
				$nval=join($sepa,$curr,$valx);
			}
		}
	} else {
		$nval=$valx;
	}
	my($mini)=develop_path_mini($nval,$sepa);
	develop_envx_setx($varx,$mini);
}

sub develop_envx_addx_mult($$$$$) {
	my($varx,$sepa,$list,$suff,$star)=@_;
	my(@vals)=split(":",$list);
	my(@resu);
	for(my($i)=0;$i<=$#vals;$i++) {
		push(@resu,$vals[$i].$suff);
	}
	my($resx)=join($sepa,@resu);
	develop_envx_addx($varx,$sepa,$resx,$star);
}

sub develop_scri_addx($$) {
	my($list,$para)=@_;
	push(@$list,$para);
}

my($prog)=develop_misc_prog();
if($ARGV[0] eq "--pod") {
	print "None.\n";
	exit(0);
}
if($#ARGV!=-1) {
	Carp::confess($prog." : usage: ".$prog." [options]");
}
# where is your aegis located (DIRECTORY)
my($aegi)=$ARGV[0];
# extra path for the shell runner (DIRECTORY LIST)
my($tvbi)=$ARGV[1];
# extra path for the dynamic linkder (DIRECTORY LIST)
my($tvld)=$ARGV[2];
# extra path for the man pager (DIRECTORY_LIST)
my($tvma)=$ARGV[3];
# extra path for the info pager (DIRECTORY_LIST)
my($tvin)=$ARGV[4];
# extra path for the XML catalogs (FILE_LIST)
my($xmli)=$ARGV[5];
# extra path for the SGML catalogs (FILE_LIST)
my($sgmi)=$ARGV[6];
# extra path for the sgml path (DIRECTORY_LIST)
my($sgpi)=$ARGV[7];
# what is the binary platform you are working on (STRING)
my($bplt)=$ARGV[8];
# what is the dll platform you are working on (STRING)
my($dplt)=$ARGV[9];
# what is the architecture you are working on (STRING)
my($shel)=$ARGV[10];
# do you want to set the PATH variable for tools ?
my($tbin)=$ARGV[11];
# do you want to set the LD_LIBRARY_PATH variable for tools ?
my($tldx)=$ARGV[12];
# do you want to set the MANPATH variable for tools ?
my($tman)=$ARGV[13];
# do you want to set the INFOPATH variable for tools ?
my($tinf)=$ARGV[14];
# do you want to set the XML_CATALOG_FILES variable for tools ?
my($txml)=$ARGV[15];
# do you want to set the SGML_CATALOG_FILES variable for tools ?
my($tsgm)=$ARGV[16];
# do you want to set the SGML_SEARCH_PATH variable for tools ?
my($tsgp)=$ARGV[17];
# do you want to set the SGML_PATH variable for tools ?
my($tsgs)=$ARGV[18];
# do you want to set the PATH variable for development ?
my($binx)=$ARGV[19];
# do you want to 7et the LD_LIBRARY_PATH for development ?
my($ldxx)=$ARGV[20];
# do you want to set the MANPATH for development ?
my($manx)=$ARGV[21];
# do you want to set the INFOPATH for development ?
my($info)=$ARGV[22];
# do you want to set the CLASSPATH for development ?
my($java)=$ARGV[23];
# do you want to set the PERL5LIB for development ?
my($perl)=$ARGV[24];
# do you want to set the XML_CATALOG_FILES for development ?
my($txmd)=$ARGV[25];
# do you want to set the SGML_CATALOG_FILES for development ?
my($sgml)=$ARGV[26];
# do you want to set the SGML_SEARCH_PATH for development ?
my($sgpl)=$ARGV[27];
# do you want to set the PYTHONPATH for development ?
my($pyth)=$ARGV[28];
# do you want perl baseline executables settings (this is for libs and bins) ?
my($base)=$ARGV[29];
# do you want to set the CDPATH for development ?
my($cdpa)=$ARGV[30];
# do you want to cd to your change on login ?
my($cdch)=$ARGV[31];
# do you want ls coloring ?
my($colo)=$ARGV[32];
# do you want ls color aliasing ?
my($lsco)=$ARGV[33];
# do you want --long opt for ls coloring ?
my($long)=$ARGV[34];
# do you want aegis type (peter) shortcuts (only valid for bash) ?
my($pete)=$ARGV[35];
# do you want to set your AEGIS_PROJECT from your aegis prefs ?
my($nprj)=$ARGV[36];
# do you want to set your AEGIS_CHANGE from your aegis prefs ?
my($nchn)=$ARGV[37];
# do you want to set the BL environment variable to point to the baseline ?
my($blxx)=$ARGV[38];
# do you want to set the CH environment variable to point to the change ?
my($chxx)=$ARGV[39];
# do you want to set the PS1 environment variable for the shell ?
my($ps1x)=$ARGV[40];
# do you want to set the PAGER environment varialbe ?
my($page)=$ARGV[41];
# do you want to set the MANPAGER variable ?
my($manp)=$ARGV[42];
# do you want verbosity ?
my($verb)=$ARGV[43];

#Default values for all the variables

$aegi="/local/tools/bin";
$tvbi="/usr/sbin:/local/tools/bin";
$tvld="/local/tools/lib";
$tvma="/local/tools/man";
$tvin="/local/tools/info";
$xmli="";
$sgmi="";
$sgpi="";
$bplt="reg.cpp.bin.dbg";
$dplt="reg.cpp.dll.dbg";
$shel="bash2";
$tbin=1;
$tldx=1;
$tman=1;
$tinf=1;
$tsgm=0;
$tsgp=0;
$tsgs=0;
$binx=1;
$ldxx=1;
$manx=0;
$info=0;
$java=1;
$perl=0;
$sgml=0;
$sgpl=0;
$pyth=1;
$base=1;
$cdpa=1;
$cdch=1;
$colo=1;
$lsco=1;
$long=1;
$pete=1;
$nprj=1;
$nchn=1;
$blxx=1;
$chxx=1;
$ps1x=1;
$page=1;
$manp=1;
$verb=0;

# Checking all the variables values

develop_misc_bada(develop_chec_dire($aegi));
develop_misc_bada(develop_chec_mdir(":",$tvbi));
develop_misc_bada(develop_chec_mdir(":",$tvld));
develop_misc_bada(develop_chec_mdir(":",$tvma));
develop_misc_bada(develop_chec_mdir(":",$tvin));
develop_misc_bada(develop_chec_mfil(":",$xmli));
develop_misc_bada(develop_chec_mfil(":",$sgmi));
develop_misc_bada(develop_chec_mdir(":",$sgpi));
develop_misc_bada(develop_chec_stri($bplt));
develop_misc_bada(develop_chec_stri($dplt));
develop_misc_bada(develop_chec_path($shel));
develop_misc_bada(develop_chec_ynxx($tbin));
develop_misc_bada(develop_chec_ynxx($tldx));
develop_misc_bada(develop_chec_ynxx($tman));
develop_misc_bada(develop_chec_ynxx($tinf));
develop_misc_bada(develop_chec_ynxx($tsgm));
develop_misc_bada(develop_chec_ynxx($tsgp));
develop_misc_bada(develop_chec_ynxx($tsgs));
develop_misc_bada(develop_chec_ynxx($binx));
develop_misc_bada(develop_chec_ynxx($ldxx));
develop_misc_bada(develop_chec_ynxx($manx));
develop_misc_bada(develop_chec_ynxx($info));
develop_misc_bada(develop_chec_ynxx($java));
develop_misc_bada(develop_chec_ynxx($perl));
develop_misc_bada(develop_chec_ynxx($sgml));
develop_misc_bada(develop_chec_ynxx($sgpl));
develop_misc_bada(develop_chec_ynxx($pyth));
develop_misc_bada(develop_chec_ynxx($base));
develop_misc_bada(develop_chec_ynxx($cdpa));
develop_misc_bada(develop_chec_ynxx($cdch));
develop_misc_bada(develop_chec_ynxx($colo));
develop_misc_bada(develop_chec_ynxx($lsco));
develop_misc_bada(develop_chec_ynxx($long));
develop_misc_bada(develop_chec_ynxx($pete));
develop_misc_bada(develop_chec_ynxx($nprj));
develop_misc_bada(develop_chec_ynxx($nchn));
develop_misc_bada(develop_chec_ynxx($blxx));
develop_misc_bada(develop_chec_ynxx($chxx));
develop_misc_bada(develop_chec_ynxx($ps1x));
develop_misc_bada(develop_chec_ynxx($page));
develop_misc_bada(develop_chec_ynxx($manp));
develop_misc_bada(develop_chec_ynxx($verb));

# First lets get the aesub and aegis programs

my($progaesu)=$aegi."/aesub";
my($progaegi)=$aegi."/aegis";

# Lets find out if they are there...

develop_chec_exec($progaesu);
develop_chec_exec($progaegi);

# Lets get the project and change from the aegis file

my($proj,$chan);
develop_aegi_vars(0,\$proj,\$chan);

# Lets get the change directory,baseline directory and search path
# from the aesub program

my($aegi_base)=develop_aegi_base($progaesu,$proj,$chan);
my($aegi_stat)=develop_aegi_stat($progaesu,$proj,$chan);
my($aegi_sear)=develop_aegi_sear($progaesu,$proj,$chan);
my($aegi_inch)=develop_aegi_inch($progaesu,$proj,$chan);

# Lets print out the current state of the change and its number

print "current project is [".$proj."]\n";
print "current change is [".$chan."]\n";
print "current state is [".$aegi_stat."]\n";

# Lets declare the script variable to hold the script

my(@scri);

# Lets give MANPATH its own value so we could (potentially) change it

my($mpth)=develop_syst_runx("man --path");
develop_envx_setx("MANPATH",$mpth);
develop_envx_setx("INFOPATH","/usr/share/info");

# Lets start handling of the options.

if($binx) {
	develop_envx_addx_mult("PATH",":",$aegi_sear,"/bins/".$bplt,1);
}
if($ldxx) {
	develop_envx_addx_mult("LD_LIBRARY_PATH",":",$aegi_sear,"/dlls/".$dplt,1);
}
if($manx) {
	develop_envx_addx_mult("MANPATH",":",$aegi_sear,"/manx",1);
}
if($info) {
	develop_envx_addx_mult("INFOPATH",":",$aegi_sear,"/info",1);
}
if($java) {
	develop_envx_addx_mult("CLASSPATH",":",$aegi_sear,"/objs/java/lib",1);
}
if($perl) {
	develop_envx_addx_mult("PERL5LIB",":",$aegi_sear,"/perl/lib",1);
}
if($txml) {
	develop_envx_addx_mult("XML_CATALOG_FILES",":",$aegi_sear,"/dtdx/CATALOG",1);
}
if($sgml) {
	develop_envx_addx_mult("SGML_CATALOG_FILES",":",$aegi_sear,"/dtdx/CATALOG",1);
}
if($sgpl) {
	develop_envx_addx_mult("SGML_SEARCH_PATH",":",$aegi_sear,"/dtdx",1);
}
if($pyth) {
	develop_envx_addx_mult("PYTHONPATH",":",$aegi_sear,"/pyth/lib",1);
}
if($base) {
	develop_envx_addx_mult("PERL5LIB",":",$aegi_sear,"/perl/lib",1);
	develop_envx_addx_mult("PATH",":",$aegi_sear,"/perl/bin/Meta/Baseline",1);
}
if($cdpa) {
	develop_envx_addx_mult("CDPATH",":",$aegi_sear,"",1);
	develop_envx_addx("CDPATH",":",".",1);
}
if($cdch) {
	if($aegi_inch) {
		my($chan)=develop_aegi_chan($progaesu,$proj,$chan);
		develop_scri_addx(\@scri,"cd ".$chan);
	}
}
if($colo) {
#	my($scri)=develop_aegi_find($progaesu,$proj,$chan,"perl/bin/Meta/Baseline/develop_cook_colors.pl");
#	my($opt);
#	if($long) {
#		$opt="--longopt";
#	} else {
#		$opt="--nolongopt";
#	}
#	FIXME
#	my($colors=$(develop_aegi_find "perl/bin/Meta/Baseline/develop_cook_colors.pl")
#	eval $($colors $opt)
}
if($lsco) {
	develop_scri_addx(\@scri,"alias ls=\'ls --color=auto'");
}
if($long) {
#	develop_scri_addx(\@scri,"long",1);
}
if($pete) {
	develop_scri_addx(\@scri,"if [ -r ~/.aegi_profile ]");
	develop_scri_addx(\@scri,"then");
	develop_scri_addx(\@scri,"\tsource ~/.aegi_profile");
	develop_scri_addx(\@scri,"else");
	develop_scri_addx(\@scri,"\techo \"cannot source ~/.aegi_profile\"");
	develop_scri_addx(\@scri,"fi");
}
if($nprj) {
	develop_envx_setx("AEGIS_PROJECT",$proj);
}
if($nchn) {
	if($aegi_inch) {
		develop_envx_setx("AEGIS_CHANGE",$chan);
	}
}
if($blxx) {
	develop_envx_setx("BL",develop_aegi_base($progaesu,$proj,$chan));
}
if($chxx) {
	if($aegi_inch) {
		develop_envx_setx("CH",develop_aegi_chan($progaesu,$proj,$chan));
	}
}
if($ps1x) {
	develop_envx_setx("PS1","\\u:\\h:\\w> ");
}
if($page) {
	develop_envx_setx("PAGER","less -csi");
}
if($manp) {
	develop_envx_setx("MANPAGER","less -csi");
}
if($tbin) {
	develop_envx_addx_mult("PATH",":",$tvbi,"",1);
}
if($tldx) {
	develop_envx_addx_mult("LD_LIBRARY_PATH",":",$tvld,"",1);
}
if($tman) {
	develop_envx_addx_mult("MANPATH",":",$tvma,"",1);
}
if($tinf) {
	develop_envx_addx_mult("INFOPATH",":",$tvin,"",1);
}
if($txmd) {
	develop_envx_addx_mult("XML_CATALOG_FILES",":",$xmli,"",0);
}
if($tsgm) {
	develop_envx_addx_mult("SGML_CATALOG_FILES",":",$sgmi,"",0);
}
if($tsgp) {
	develop_envx_addx_mult("SGML_SEARCH_PATH",":",$sgpi,"",0);
}
if($tsgs) {
	develop_envx_addx_mult("SGML_PATH",":",$sgpi,"",0);
}
if($verb) {
	print "progaesu=[".$progaesu."]\n";
	print "progaegi=[".$progaegi."]\n";
	print "proj=[".$proj."]\n";
	print "chan=[".$chan."]\n";
	print "aegi_base=[".$aegi_base."]\n";
	print "aegi_stat=[".$aegi_stat."]\n";
	print "aegi_sear=[".$aegi_sear."]\n";
	print "aegi_inch=[".$aegi_inch."]\n";
}

# Lets get a temp file for the script. Open it,put the script in,and close it

my($temp)=develop_file_temp();
open(TEMP,"> ".$temp) || Carp::confess($prog.": error: unable to open temp file [".$temp."]");
for(my($i)=0;$i<=$#scri;$i++) {
	print TEMP $scri[$i]."\n";
}
print TEMP "rm -f ".$temp."\n";# Watch closly now. Are you watching now ?
close(TEMP) || Carp::confess($prog.": error: unable to close temp file [".$temp."]");

# Thats it. Lets run the shell,and tell it to read our initialization to make
# everything uniform...

exec($shel,"--rcfile",$temp);

__END__

=head1 NAME

develop_bash.pl - a development startup script.

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

	MANIFEST: develop_bash.pl
	PROJECT: meta
	VERSION: 0.00

=head1 SYNOPSIS

	develop_bash.pl

=head1 DESCRIPTION

STANDALONE SPECIAL FILE

"AEGIS - the best project manager this side of the sahara..."
As usual - take heed...
This is the standard text to be a Meta developer.
Place this text in a fixed location (~/.develop_bash /etc/develop_bash
etc...) and source it at startup.
some explanation on this file:
This file exists because when we want to work on the baseline we have to
set a few environment variables for the command line to work (we do work
on the command line...).
setting environment variables is not done from perl or other language
scripts but rather from a shell script (the same one your'e using -
currently bash2)
because:
0. its not a practice to change your parent process data (it seems to me
that you cant realy do that without the concent of your parent process).
1. its difficut.
2. its non standard.
3. I hate it.
4. Its impossible.
Therefore we wrote this script.
This script should be "sourced" as this is the only way to change the
env variables of the calling process.
Routines here are characterised by the fact that they change the
environment parameters of the calling shell.
A rule of thumb about putting routines here should be:
if the routine is supposed to deal with environment parameters it
should be here
if not - write a perl script instead.
The routines here change the runtime affecting values of variables - not
the compile time ones...

Important for developers:

It is important that all the interactive stuff be done AFTER the basic path
settings since they may run a few executables and those will need to path
settings in order to run...

=head1 OPTIONS

None.

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mailto:veltzer@cpan.org
	WWW: http://www.veltzer.org
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV move tests to modules

=head1 SEE ALSO

Carp(3), File::Basename(3), POSIX(3), strict(3)

=head1 TODO

-use long opt for all the options (and maybe even store them in a file ?!?).

-get the $- variable from the shell as input (the shell has it) and use it to make checks whether this script runs interactivly or not...

-make the file name where Peters shortcuts are to be a parameter.

-make this script with an option just to write the changes to be made to the environment and not do them and so we could run this without the shell at the end and just execute the stuff its telling us to.

-make routine in here more accessible in that users could change their platform / architecture in the middle of a shell session.

-make options to put the development stuff ahead of everything and the reverse.

-make the develop_chec_path function work.

-make stuff here more generic (all the variables are handled pretty much the same...).
