#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Baseline::Lang::Perl - doing Perl specific stuff in the baseline.

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

MANIFEST: Perl.pm
PROJECT: meta

=head1 SYNOPSIS

C<package foo;>
C<use Meta::Baseline::Lang::Perl qw();>
C<my($resu)=Meta::Baseline::Lang::Perl::env();>

=head1 DESCRIPTION

This package contains stuff specific to Perl in the baseline:
0. produce code to set Perl specific vars in the baseline.
1. check Perl files for correct Perl syntax in the baseline.
etc...

=head1 EXPORTS

C<env()>
C<c2chec($)>
C<check($$$)>
C<check_use($$$$$$)>
C<check_lint($$$$$$)>
C<check_doc($$$$$$)>
C<check_misc($$$$$$)>
C<check_mods($$$$$$)>
C<check_fl($$$$$$)>
C<check_pods($$$$$$)>
C<module_to_file($)>
C<module_to_search_file($)>
C<file_to_module($)>
C<c2deps($)>
C<get_use($$$)>
C<get_pod($)>
C<get_pods($)>
C<check_list($$$)>
C<check_list_pl($$$)>
C<check_list_pm($$$)>
C<run($)>
C<man($)>
C<runline($$$$$)>
C<docify($)>
C<c2objs($)>
C<c2manx($)>
C<c2nrfx($)>
C<c2html($)>
C<c2late($)>
C<c2txtx($)>
C<my_file($$)>
C<source_file($$)>
C<create_file($$)>
C<pod2code($)>
C<fix_history($$)>
C<fix_license($$)>
C<fix_author($$)>

=cut

package Meta::Baseline::Lang::Perl;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT);
use Meta::Utils::File::Path qw();
use Meta::Baseline::Aegis qw();
use Meta::Baseline::Cook qw();
use Meta::Baseline::Utils qw();
use Meta::Utils::Text::Lines qw();
use Meta::Utils::List qw();
use Meta::Utils::File::Remove qw();
use Meta::Utils::File::Move qw();
use Meta::Utils::File::Copy qw();
use Meta::Utils::File::File qw();
use Meta::Baseline::Lang qw();
use Template qw();
use Pod::Text qw();
use Pod::Html qw();
use Pod::Checker qw();
use Pod::LaTeX qw();
use DB_File qw();
use Meta::Tool::Aegis qw();
use Meta::Utils::Output qw();
use Meta::Lang::Perl::Deps qw();

$VERSION="1.00";
@ISA=qw(Exporter Meta::Baseline::Lang);
@EXPORT_OK=qw();
@EXPORT=qw();

#sub env();
#sub c2chec($);
#sub check($$$);
#sub check_use($$$$$$);
#sub check_lint($$$$$$);
#sub check_doc($$$$$$);
#sub check_misc($$$$$$);
#sub check_mods($$$$$$);
#sub check_fl($$$$$$);
#sub check_pods($$$$$$);
#sub module_to_file($);
#sub module_to_search_file($);
#sub file_to_module($);
#sub c2deps($);
#sub get_use($$$);
#sub get_pod($);
#sub get_pods($);
#sub check_list($$$);
#sub check_list_pl($$$);
#sub check_list_pm($$$);
#sub run($);
#sub man($);
#sub runline($$$$$);
#sub docify($);
#sub c2objs($);
#sub c2manx($);
#sub c2nrfx($);
#sub c2html($);
#sub c2late($);
#sub c2txtx($);
#sub my_file($$);
#sub source_file($$);
#sub create_file($$);
#sub pod2code($);
#sub fix_history($$);
#sub fix_license($$);
#sub fix_author($$);

#__DATA__

=head1 FUNCTION DOCUMENTATION

=over

=item B<env()>

This routie returns a hash of environment variables which are essential for
running Perl scripts.

=cut

sub env() {
	my($vers)="5.005";
	my($plat)="linux";
	my($arch)="i386";
	my($lang)="perl5";
	my(%hash);
	my($path)="";
	my($perl)="";
	my($sear)=Meta::Baseline::Aegis::search_path_list();
	for(my($i)=0;$i<=$#$sear;$i++) {
		my($curr)=$sear->[$i];
		$path=Meta::Utils::File::Path::add_path($path,
			$curr."/perl/Meta/bin",":");
		$path=Meta::Utils::File::Path::add_path($path,
			$curr."/perl/Meta/bin/Baseline",":");
		$perl=Meta::Utils::File::Path::add_path($perl,
			$curr."/perl/lib/Meta",":");
		$perl=Meta::Utils::File::Path::add_path($perl,
			$curr."/perl/import/lib/".$lang."/".$arch."-".$plat."/".$vers,":");
		$perl=Meta::Utils::File::Path::add_path($perl,
			$curr."/perl/import/lib/".$lang,":");
		$perl=Meta::Utils::File::Path::add_path($perl,
			$curr."/perl/import/lib/".$lang."/site_perl/".$arch."-".$plat,":");
		$perl=Meta::Utils::File::Path::add_path($perl,
			$curr."/perl/import/lib/".$lang."/site_perl",":");
	}
	$hash{"PATH"}=$path;
	$hash{"PERL5LIB"}=$perl;
	return(\%hash);
}

=item B<c2chec($)>

This routine checks a file for the following things:
	0. check the first line (#!/usr/bin/env perl).
	1. check every use actually used.
	2. check name of package with each part with capital.
	3. check use strict and diagnostics and exporter and loader.
	4. check documentation (check out the podchecker executable).
	5. check syntax by running the interpreter in syntax check mode.
	6. What about perl cc ? what does it do ?
	7. check for bad strings ";\n" "\t " two spaces etc..

=cut

sub c2chec($) {
	my($buil)=@_;
	my($resu)=check($buil->get_modu(),$buil->get_srcx(),$buil->get_path());
	if($resu) {
		Meta::Baseline::Utils::file_emblem($buil->get_targ());
	}
	return($resu);
}

=item B<check($$$)>

This method does the actual checking and returns the result.

=cut

sub check($$$) {
	my($modu,$srcx,$path)=@_;
	my($text)=Meta::Utils::File::File::load($srcx);
	my($test)=($srcx=~/perl\/bin\/Meta\/Tests/);
	my($module);
	if($srcx=~/\.pl$/) {
		$module=0;
	} else {
		if($srcx=~/\.pm$/) {
			$module=1;
		} else {
			die("what kind of file is [".$srcx."]");
		}
	}
	my($resu)=1;
	my($cod0)=check_use($srcx,$path,$text,$test,$module,$modu);
	if(!$cod0) {
		$resu=0;
	}
#	Meta::Utils::Output::print("in here with resu [".$resu."]\n");
#	my($cod1)=check_lint($srcx,$path,$text,$test,$module,$modu);
#	if(!$cod1) {
#		$resu=0;
#	}
#	Meta::Utils::Output::print("in here with resu [".$resu."]\n");
	my($cod2)=check_doc($srcx,$path,$text,$test,$module,$modu);
	if(!$cod2) {
		$resu=0;
	}
#	Meta::Utils::Output::print("in here with resu [".$resu."]\n");
	my($cod3)=check_misc($srcx,$path,$text,$test,$module,$modu);
	if(!$cod3) {
		$resu=0;
	}
#	Meta::Utils::Output::print("in here with resu [".$resu."]\n");
	my($cod4)=check_mods($srcx,$path,$text,$test,$module,$modu);
	if(!$cod4) {
		$resu=0;
	}
#	Meta::Utils::Output::print("in here with resu [".$resu."]\n");
	my($cod5)=check_fl($srcx,$path,$text,$test,$module,$modu);
	if(!$cod5) {
		$resu=0;
	}
#	Meta::Utils::Output::print("in here with resu [".$resu."]\n");
	my($cod6)=check_pods($srcx,$path,$text,$test,$module,$modu);
	if(!$cod6) {
		$resu=0;
	}
#	Meta::Utils::Output::print("in here with resu [".$resu."]\n");
	return($resu);
}

=item B<check_use($$$$$$)>

This is my own module to check for "use module" which is not really in use.

=cut

sub check_use($$$$$$) {
	my($perl,$path,$text,$test,$modu,$module)=@_;
	my(@lines)=split("\n",$text);
	my(%hash);
	for(my($i)=0;$i<=$#lines;$i++) {
		my($line)=$lines[$i];
		if($line=~/^use Meta::.* qw\(.*\);$/) {
			my($string)=($line=~/^use (.*) qw\(.*\);$/);
			if(!defined($string)) {
				Meta::Utils::System::die("bad our use in [".$line."]");
			} else {
				$hash{$string}="defined our";
			}
		} else {
			if($line=~/^use .*;$/) {
				my($string)=($line=~/^use (.*) qw\(.*\);$/);
				if(!defined($string)) {
					Meta::Utils::System::die("bad basic use in [".$line."]");
				} else {
					$hash{$string}="defined basic";
				}
			} else {
				while(my($keyx,$valx)=each(%hash)) {
					if($line=~/$keyx/) {
						$hash{$keyx}="used";
					}
				}
			}
		}
	}
	my($resu)=1;
	while(my($keyx,$valx)=each(%hash)) {
		if($valx eq "defined our") {
			Meta::Utils::Output::print("imported (internal) but not used [".$keyx."]\n");
			$resu=0;
		}
		if($valx eq "defined basic") {
			if($keyx ne "strict" && $keyx ne "vars") {
				Meta::Utils::Output::print("imported (external) but not used [".$keyx."]\n");
				$resu=0;
			}
		}
	}
	return($resu);
}

=item B<check_lint($$$$$$)>

This one will run the B::Lint module and make sure that it comes up empty.
This one needs to be changed to catch the output of the command and process it.

=cut

sub check_lint($$$$$$) {
	my($perl,$path,$text,$test,$modu,$module)=@_;
	my($outt);
	my($ccod);
	if($modu) {
		$ccod=Meta::Utils::System::system_err_nodie(\$outt,"perl",["-MO=Lint","-Mstrict",$perl]);#-Mdiagnostics
	} else {
		$ccod=Meta::Utils::System::system_err_nodie(\$outt,"perl",["-MO=Lint","-Mstrict",$perl]);#-Mdiagnostics
	}
	if($ccod) {
#		Meta::Utils::Output::print("outt is [".$outt."]\n");
		my($obje)=Meta::Utils::Text::Lines->new();
		$obje->set_text($outt,"\n");
		$obje->remove_line($perl." syntax OK");
		$obje->remove_line("Undefined value assigned to typeglob at /local/tools/lib/perl5/5.6.0/i686-linux/B/Lint.pm line 291.");
		$obje->remove_line("defined(\@array) is deprecated at /local/tools/lib/perl5/site_perl/5.6.0/Expect.pm line 922.");
		$obje->remove_line("\t(Maybe you should just omit the defined()?)");
		my($fina)=$obje->get_text_fixed();
		if($fina eq "") {
				return(1);
		} else {
			Meta::Utils::Output::print($fina);
			return(0);
		}
	} else {
		Meta::Utils::Output::print($outt);
		return(0);
	}
}

=item B<check_doc($$$$$$)>

This method will check the documentation of an object.
This means that every method is documented and all the headers are there.
Currently it does nothing.

=cut

sub check_doc($$$$$$) {
	my($perl,$path,$text,$test,$modu,$module)=@_;
	return(1);
}

=item B<check_misc($$$$$$)>

This will check miscelleneous text features that we dont like in the baseline.

=cut

sub check_misc($$$$$$) {
	my($perl,$path,$text,$test,$modu,$module)=@_;
	my(@array)=
	(
		"\\\ \\\n",
		"\\\n\\\ ",
		"\\\t\\\n",
		"\\\ \\\ ",
		"\\\r\\\n",
		"\\\ \\\;",
		"\\\(\\\ ",
		"\\\ \\\)",
		"\\\;\\\ ",
		"\\\ \\\;",
		"\\\=\\\ ",
		"\\\ \\\=",
		"\\\$\\\_",
		"\\\,\\\ ",
		"\\\ \\\,",
	);
	if($text!~m/SPECIAL STDERR FILE/) {
		push(@array,"STD"."OUT");
		push(@array,"STD"."ERR");
	}
	my($code)=pod2code($text);
	my($result)=1;
	my($size)=$#array+1;
	for(my($i)=0;$i<$size;$i++) {
		my($curr)=$array[$i];
#		Meta::Utils::Output::print("In here with curr [".$curr."]");
		if($code=~m/$curr/) {
			Meta::Utils::Output::print("[".$curr."] matched in text\n");
			$result=0;
		}
	}
	my(@must_array_pl)=
	(
		"=head1 NAME",
		"=head1 COPYRIGHT",
		"=head1 LICENSE",
		"=head1 DETAILS",
		"=head1 SYNOPSIS",
		"=head1 DESCRIPTION",
		"=head1 OPTIONS",
		"=head1 BUGS",
		"=head1 AUTHOR",
		"=head1 HISTORY",
		"=head1 SEE ALSO",
		"=head1 TODO",
	);
	my(@must_array_pm)=
	(
		"=head1 NAME",
		"=head1 COPYRIGHT",
		"=head1 LICENSE",
		"=head1 DETAILS",
		"=head1 SYNOPSIS",
		"=head1 DESCRIPTION",
		"=head1 EXPORTS",
		"=head1 FUNCTION DOCUMENTATION",
		"=head1 BUGS",
		"=head1 AUTHOR",
		"=head1 HISTORY",
		"=head1 SEE ALSO",
		"=head1 TODO",
	);
	my($poin);
	if($modu) {
		$poin=\@must_array_pm;
	} else {
		$poin=\@must_array_pl;
	}
	my($pod)=get_pod($text);
#	Meta::Utils::List::print(Meta::Utils::Output::get_file(),$poin);
	if(!Meta::Utils::List::equa($poin,$pod)) {
		Meta::Utils::Output::print("problem with pod:\n");
		Meta::Utils::List::print(Meta::Utils::Output::get_file(),$pod);
		Meta::Utils::Output::print("pod expected:\n");
		Meta::Utils::List::print(Meta::Utils::Output::get_file(),$poin);
		$result=0;
	}
#	my($must_size)=$#must_array+1;
#	for(my($j)=0;$j<$must_size;$j++) {
#		my($curr)=$must_array[$j];
#		if($text!~$curr) {
#			Meta::Utils::Output::print("[".$curr."] not matched in text\n");
#			$result=0;
#		}
#	}
	my($temp)=Meta::Utils::Utils::get_temp_file();
	my($cod2)=Pod::Checker::podchecker($perl,$temp);
	if($cod2) {
		my($text)=Meta::Utils::File::File::load($temp);
		Meta::Utils::Output::print($text);
		$result=0;
	} else {
		Meta::Utils::File::Remove::rm($temp);
	}
	return($result);
}

=item B<check_mods($$$$$$)>

This will check modules which must be used in different file types.

=cut

sub check_mods($$$$$$) {
	my($perl,$path,$text,$test,$modu,$module)=@_;
	if($text=~/STANDALONE SPECIAL FILE/) {
		return(1);
	}
	my($arra)=get_use($text,1,1);
	my(@must);
	if($modu) {
		push(@must,"strict");
		push(@must,"Exporter");
		push(@must,"vars");
	} else {
		if($test) {
			push(@must,"strict");
			push(@must,"Meta::Utils::System");
			push(@must,"Meta::Utils::Opts::Opts");
			push(@must,"Meta::Baseline::Test");
		} else {
			push(@must,"strict");
			push(@must,"Meta::Utils::System");
			push(@must,"Meta::Utils::Opts::Opts");
		}
	}
#	Meta::Utils::Output::print("arra is [".$arra."]\n");
#	Meta::Utils::Output::print("must is [".@must."]\n");
	if(Meta::Utils::List::is_prefix(\@must,$arra)) {
		return(1);
	} else {
		Meta::Utils::Output::print("usage does not comply with prefix\n");
		Meta::Utils::Output::print("your usage pattern:\n");
		Meta::Utils::List::print(Meta::Utils::Output::get_file(),$arra);
		Meta::Utils::Output::print("needed usage pattern:\n");
		Meta::Utils::List::print(Meta::Utils::Output::get_file(),\@must);
		return(0);
	}
}

=item B<check_fl($$$$$$)>

This will check the first line of a perl script or module.

=cut

sub check_fl($$$$$$) {
	my($perl,$path,$text,$test,$modu,$module)=@_;
	my(@line)=split('\n',$text);
	my($firs)=$line[0];
	my($chec);
	if($modu) {
		$chec="\#\!\/bin\/echo This is a perl module and should not be run";
	} else {
		$chec="\#\!\/usr\/bin\/env perl";
	}
	if($firs eq $chec) {
		return(1);
	} else {
		Meta::Utils::Output::print("found bad first line [".$firs."]\n");
		Meta::Utils::Output::print("fist line should be [".$chec."]\n");
		return(0);
	}
}

=item B<check_pods($$$$$$)>

This check will check the content of the pods.

=cut

sub check_pods($$$$$$) {
	my($perl,$path,$text,$test,$modu,$module)=@_;
	my($hash)=get_pods($text);
	my($resu)=1;
	# check NAME
	my($name)=$hash->{"NAME"};
	my($matc);
	if($modu) {
		$matc=file_to_module($perl);
	} else {
		$matc=File::Basename::basename($perl);
	}
	if($name!~/^\n$matc - .*\.\n$/) {
		Meta::Utils::Output::print("NAME found is [".$name."]\n");
		$resu=0;
	}
	# check LICENSE
	my($lice)=Meta::Utils::File::File::load(Meta::Baseline::Aegis::which("data/baseline/lice/lice.txt"));
	if($hash->{"LICENSE"} ne "\n".$lice) {
		Meta::Utils::Output::print("LICENSE found is [".$hash->{"LICENSE"}."]\n");
		Meta::Utils::Output::print("and should be [\n".$lice."]\n");
		$resu=0;
	}
	# check COPYRIGHT
	my($copy)=Meta::Utils::File::File::load(Meta::Baseline::Aegis::which("data/baseline/lice/copy.txt"));
	if($hash->{"COPYRIGHT"} ne "\n".$copy) {
		Meta::Utils::Output::print("COPYRIGHT found is [".$hash->{"COPYRIGHT"}."]\n");
		Meta::Utils::Output::print("and should be [\n".$copy."]\n");
		$resu=0;
	}
	# check AUTHOR
	my($auth_file)=Meta::Baseline::Aegis::which("xmlx/author/author.xml");
	my($author)=Meta::Info::Author::new_file($auth_file);
	my($auth)=$author->get_perl_makefile();
	if($hash->{"AUTHOR"} ne "\n".$auth."\n") {
		Meta::Utils::Output::print("AUTHOR found is [".$hash->{AUTHOR}."]\n");
		Meta::Utils::Output::print("and should be [\n".$auth."\n"."]\n");
		$resu=0;
	}
	# build hash of SYNOPSIS
	my($syno)=$hash->{"SYNOPSIS"};
	my($shor)=substr($syno,1,-1);
	my(@lines)=split("\n",$shor);
	for(my($i)=0;$i<=$#lines;$i++) {
		my($curr)=$lines[$i];
		if($curr!~/^C\<.*\>$/) {
			Meta::Utils::Output::print("what kind of SYNOPSIS line is [".$curr."]\n");
			$resu=0;
		}
	}
	# check EXPORTS
	my($expo)=$hash->{"EXPORTS"};
	$expo=substr($expo,1,-1);
	my(@expo_line)=split("\n",$expo);
	for(my($i)=0;$i<$#expo_line;$i++) {
		my($curr)=$expo_line[$i];
		if($curr!~/^C\<.*\>$/) {
			Meta::Utils::Output::print("what kind of EXPORT line is [".$curr."]\n");
			$resu=0;
		}
	}
	# check DETAILS
	my($deta)=$hash->{"DETAILS"};
	my($expect)="\nMANIFEST: ".File::Basename::basename($perl)."\nPROJECT: ".Meta::Baseline::Aegis::project()."\n";
	if($deta ne $expect) {
		Meta::Utils::Output::print("what kind of DETAILS is [".$deta."]\n");
		Meta::Utils::Output::print("expecting [".$expect."]\n");
		$resu=0;
	}
	# check HISTORY
#	my($hist)=$hash->{HISTORY};
#	my($revision_info)=Meta::Tool::Aegis::history($module);
#	my($perl_hist)=$revision_info->string();
#	my($hist_need)="\n".$perl_hist."\n";
#	if($hist ne $hist_need) {
#		Meta::Utils::Output::print("what kind of HISTORY is [".$hist."]\n");
#		Meta::Utils::Output::print("expecting [".$hist_need."]\n");
#		$resu=0;
#	}
	return($resu);
}

=item B<module_to_file($)>

This will translate a module name to a baseline relative file name.

=cut

sub module_to_file($) {
	my($modu)=@_;
	$modu=~s/::/\//g;
	$modu="perl/lib/".$modu.".pm";
	return($modu);
}

=item B<module_to_search_file($)>

This will translate a module name to a module file to search for (without
the perl/lib prefix...

=cut

sub module_to_search_file($) {
	 my($modu)=@_;
	$modu=~s/::/\//g;
	$modu.=".pm";
	return($modu);
}

=item B<file_to_module($)>

This will translate a file name to a module name.

=cut

sub file_to_module($) {
	my($file)=@_;
	my($modu)=($file=~/^.*perl\/lib\/(.*)\.pm$/);
	$modu=~s/\//::/g;
	return($modu);
}

=item B<c2deps($)>

This will generate a dep file from a perl file.

=cut

sub c2deps($) {
	my($buil)=@_;
	my($deps)=Meta::Lang::Perl::Deps::c2deps($buil);
	if(defined($deps)) {
		Meta::Baseline::Cook::print_deps($deps,$buil->get_targ());
		return(1);
	} else {
		return(0);
	}
}

=item B<get_use($$$)>

This method gets a perl file and returns the list of modules this file uses
in the order it is using them. The module can be made to bring external
and internal uses or either one.

=cut

sub get_use($$$) {
	my($text,$inte,$exte)=@_;
	my(@lines)=split('\n',$text);
	my($size)=$#lines+1;
	my(@arra);
	for(my($i)=0;$i<$size;$i++) {
		my($line)=$lines[$i];
		if($line=~/^use .* qw\(.*\);$/) {
			if($line=~/^use Meta::.* qw\(.*\);$/) {
				my($modu)=($line=~/^use (.*) qw\(.*\);$/);
				if($inte) {
					push(@arra,$modu);
				}
			} else {
				my($modu)=($line=~/^use (.*) qw\(.*\);$/);
				if($exte) {
					push(@arra,$modu);
				}
			}
		}
	}
	return(\@arra);
}

=item B<get_pod($)>

This method returns all pod directives in a text.

=cut

sub get_pod($) {
	my($text)=@_;
	my(@lines)=split('\n',$text);
	my($size)=$#lines+1;
	my(@arra);
	for(my($i)=0;$i<$size;$i++) {
		my($curr)=$lines[$i];
		if($curr=~/^=/) {
			if($curr ne "=head1 COMMENT" && $curr ne "=begin COMMENT" && $curr ne "=end COMMENT" && $curr ne "=cut COMMENT" && $curr ne "=over" && $curr ne "=cut" && $curr!~/^=item B/ && $curr ne "=back" && $curr ne "=head1 MAIN FUNCTION DOCUMENTATION") {
				push(@arra,$curr);
#				Meta::Utils::Output::print("pushing [".$curr."]\n");
			}
		}
	}
	return(\@arra);
}

=item B<get_pods($)>

This method returns all pod directives in a text in a hash.

=cut

sub get_pods($) {
	my($text)=@_;
	my(@lines)=split('\n',$text);
	my($size)=$#lines+1;
	my($inde)=undef;#init the variable
	my(%hash);
	for(my($i)=0;$i<$size;$i++) {
		my($curr)=$lines[$i];
		if($curr=~/^=/) {
			if($curr=~/^=head1 /) {
				($inde)=($curr=~/^=head1 (.*)$/);
			} else {
				$inde=undef;#init the variable
			}
		} else {
			if(defined($inde)) {
#				Meta::Utils::Output::print("adding [".$curr."] to [".$inde."]\n");
				if(exists($hash{$inde})) {
					$hash{$inde}.="\n".$curr;
				} else {
					$hash{$inde}=$curr;
				}
			}
		}
	}
	return(\%hash);
}

=item B<check_list($$$)>

Check the syntax of a number of perl files.
Inputs are the list of files, be verbose or not and die or not on error.

=cut

sub check_list($$$) {
	my($list,$verb,$stop)=@_;
	my($resu)=1;
	for(my($i)=0;$i<=$#$list;$i++) {
		my($file)=$list->[$i];
		if($verb) {
			Meta::Utils::Output::print("checking [".$file."]\n");
		}
		my($cres)=Meta::Utils::System::system("perl",["-wc",$file]);
		if($cres) {
			if($stop) {
				die("failed check of [".$file."]");
			}
		}
		$cres=Meta::Utils::Utils::bnot($cres);
		$resu=$resu && $cres;
	}
	return($resu);
}

=item B<check_list_pl($$$)>

Routine that calls check_list for all items

=cut

sub check_list_pl($$$) {
	my($var1,$var2,$var3)=@_;
	check_list($var1,$var2,$var3);
}

=item B<check_list_pm($$$)>

Routine that calls check_list for all items

=cut

sub check_list_pm($$$) {
	my($var1,$var2,$var3)=@_;
	check_list($var1,$var2,$var3);
}

=item B<run($)>

Routine to run the perl script it receives as input.

=cut

sub run($) {
	my($modu)=@_;
	return(Meta::Utils::System::system_nodie("perl",[$modu]));
}

=item B<man($)>

Routine to show a manual page of a perl module (the parameter).

=cut

sub man($) {
	my($modu)=@_;
	return(Meta::Utils::System::system_nodie("perldoc",[$modu]));
}

=item B<runline($$$$$)>

This routine changes the runline in all perl scripts in the baseline.
This script receives:
0. demo - whether to actually change or just demo.
1. verb - whether to be verbose or not.
2. line - which line to plant in all the perl scripts.
3. chec - whether to do a check that the current runline in the scripts is
	something.
4. cstr - what is the check string to check against.


=cut

sub runline($$$$$) {
	my($demo,$verb,$line,$chec,$cstr)=@_;
	my($dirx)=Meta::Baseline::Aegis::development_directory();
	my($list)=Meta::Baseline::Aegis::change_files_list(1,1,0,1,1,1);
	$list=Meta::Utils::List::filter_prefix($list,$dirx."/perl/bin");
	$list=Meta::Utils::List::filter_suffix($list,".pl");
	my($resu)=1;
	for(my($i)=0;$i<=$#$list;$i++) {
		my($file)=$list->[$i];
		if($verb) {
			Meta::Utils::Output::print("replacing runline on file [".$file."]\n");
		}
		if(!$demo) {
			my(@arra);
			tie(@arra,"DB_File",$file,$DB_File::O_RDWR,0666,$DB_File::DB_RECNO) or Meta::Utils::System::die("cannot tie [".$file."]");
			my($doit)=0;
			if($chec) {
				if($arra[0] eq $cstr) {
					$doit=1;
				} else {
					$doit=0;
					$resu=0;
				}
			} else {
				$doit=1;
			}
			if($doit) {
				$arra[0]=$line;
			}
			untie(@arra) || Meta::Utils::System::die("cannot untie [".$file."]");
		}
	}
	return($resu);
}

=item B<docify($)>

This method is here because I needed it for the html conversion but eventualy
didnt use it. Try to use it in the future.

=cut

sub docify($) {
	my($str)=@_;
	$str=lc $str;
	$str=~s/(\.\w+)/substr ($1,0,4)/ge;
	$str=~s/(\w+)/substr ($1,0,8)/ge;
	return($str);
}

=item B<c2objs($)>

This methos will compile perl to bytecode.
This method returns an error code.
Currently this does nothing.

=cut

sub c2objs($) {
	my($buil)=@_;
	Meta::Baseline::Utils::file_emblem($buil->get_targ());
	return(1);
}

=item B<c2manx($)>

This method will generate manual pages from perl source files.
This method returns an error code.

=cut

sub c2manx($) {
	my($buil)=@_;
	my($scod)=Meta::Utils::System::system_shell_nodie("pod2man ".$buil->get_srcx()." > ".$buil->get_targ());
	return($scod);
}

=item B<c2nrfx($)>

This method will convert perl source files into nroff output.

=cut

sub c2nrfx($) {
	my($buil)=@_;
	Meta::Baseline::Utils::file_emblem($buil->get_targ());
	return(1);
}

=item B<c2html($)>

This method will convert perl source files into html documentation.
This method returns an error code.

=cut

sub c2html($) {
	my($buil)=@_;
	my($scod)=Pod::Html::pod2html(
		"--infile",$buil->get_srcx(),
		"--outfile",$buil->get_targ(),
		"--noindex",
		"--flush",
		"--norecurse",
		"--podroot","/",
		"--podpath",$buil->get_path()
	);
	my($fil0)="pod2htmd.x~~";
	my($fil1)="pod2htmi.x~~";
	Meta::Utils::File::Remove::rm_nodie($fil0);
	Meta::Utils::File::Remove::rm_nodie($fil1);
	return(1);
}

=item B<c2late($)>

This method will convert perl source files into latex documentation.
This method returns an error code.

=cut

sub c2late($) {
	my($buil)=@_;
	my($parser)=Pod::LaTeX->new();
	my($scod)=$parser->parse_from_file($buil->get_srcx(),$buil->get_targ());
	return($scod);
#	my($file)=Meta::Utils::Utils::get_temp_file();
#	my($resu)=$file."\.tex";
#	Meta::Utils::File::Copy::copy($srcx,$file);
#	my($scod)=Meta::Utils::System::system_err_silent_nodie("pod2latex",[$file]);
#	if($scod) {
#		$scod=Meta::Utils::File::Move::mv_nodie($resu,$targ);
#		if($scod) {
#			Meta::Utils::File::Remove::rm($file);
#		} else {
#			Meta::Utils::Output::print("unable to move file [".$resu."] to [".$targ."]\n");
#			Meta::Utils::File::Remove::rm_nodie($resu);
#		}
#	} else {
#		Meta::Utils::File::Remove::rm_nodie($resu);
#	}
#	return($scod);
}

=item B<c2txtx($)>

This method will convert perl source files into text documentation.
This method returns an error code.

=cut

sub c2txtx($) {
	my($buil)=@_;
	my($parser)=Pod::Text->new();
	my($scod)=$parser->parse_from_file($buil->get_srcx(),$buil->get_targ());
	return($scod);
}

=item B<my_file($$)>

This method will return true if the file received should be handled by this
module.

=cut

sub my_file($$) {
	my($self,$file)=@_;
#	Meta::Utils::Output::print("in here with file [".$file."]\n");
	if($file=~/^perl\/.*\.pl$/) {
		return(1);
	}
	if($file=~/^perl\/.*\.pm$/) {
		return(1);
	}
	if($file=~/^perl\/.*\.MANIFEST$/) {
		return(1);
	}
	return(0);
}

=item B<source_file($$)>

This method will return true if the file received is a source of this module.

=cut

sub source_file($$) {
	my($self,$file)=@_;
	if($file=~/^perl\/.*\.pl$/) {
		return(1);
	}
	if($file=~/^perl\/.*\.pm$/) {
		return(1);
	}
	return(0);
}

=item B<create_file($$)>

This method will create a file template.

=cut

sub create_file($$) {
	my($self,$file)=@_;
	my($tmpl);
	if($file=~/^perl\/.*\.pl$/) {
		$tmpl="aegi/tmpl/plxx.aegis";
	}
	if($file=~/^perl\/.*\.pm$/) {
		$tmpl="aegi/tmpl/pmxx.aegis";
	}
	my($dire)=File::Basename::dirname($file);
	my($base)=File::Basename::basename($file);
	my($modu)=file_to_module($file);
	my($lice)="data/baseline/lice/lice.txt";
	$lice=Meta::Baseline::Aegis::which($lice);
	$lice=Meta::Utils::File::File::load($lice);
	my($copy)="data/baseline/lice/copy.txt";
	$copy=Meta::Baseline::Aegis::which($copy);
	$copy=Meta::Utils::File::File::load($copy);
	my($vars)={
		"search_path",Meta::Baseline::Aegis::search_path(),
		"baseline",Meta::Baseline::Aegis::baseline(),
		"project",Meta::Baseline::Aegis::project(),
		"change",Meta::Baseline::Aegis::change(),
		"version",Meta::Baseline::Aegis::version(),
		"architecture",Meta::Baseline::Aegis::architecture(),
		"state",Meta::Baseline::Aegis::state(),
		"developer",Meta::Baseline::Aegis::developer(),
		"developer_list",Meta::Baseline::Aegis::developer_list(),
		"reviewer_list",Meta::Baseline::Aegis::reviewer_list(),
		"integrator_list",Meta::Baseline::Aegis::integrator_list(),
		"administrator_list",Meta::Baseline::Aegis::administrator_list(),
		"perl_copyright"=>$copy,
		"perl_license"=>$lice,
		"file_name"=>$file,
		"directroy"=>$dire,
		"base_name"=>$base,
		"module_name"=>$modu,
	};
	my($template)=Template->new(
		INCLUDE_PATH=>Meta::Baseline::Aegis::search_path(),
	);
	my($scod)=$template->process($tmpl,$vars,$file);
	if(!$scod) {
		Meta::Utils::System::die("could not process template with error [".$template->error()."]");
	}
}

=item B<pod2code($)>

This method receives the text of a program and returns the code part of the
pod.

=cut

sub pod2code($) {
	my($text)=@_;
	my(@lines)=split('\n',$text);
	my(@code,@pode);
	my($state)="in_code";
	for(my($i)=0;$i<=$#lines;$i++) {
		my($curr)=$lines[$i];
#		Meta::Utils::Output::print("curr is [".$curr."] and state is [".$state."]\n");
		if($curr eq "=cut") {
#			Meta::Utils::Output::print("in here with curr [".$curr."]\n");
			if($state eq "in_code") {
				Meta::Utils::System::die("cut in code?");
			} else {#in_pod
				$state="in_code";
			}
		} else {
			if($curr=~/^=/) {
				if($state eq "in_code") {
#					Meta::Utils::Output::print("changing\n");
					$state="in_pod";
				} else {#in_pod
					#pod in pod is ok.
				}
			} else {
				if($state eq "in_code") {
					push(@code,$curr);
				} else {#in_pod
					push(@pode,$curr);
				}
			}
		}
#		Meta::Utils::Output::print("end curr is [".$curr."] and state is [".$state."]\n");
	}
	return(join('\n',@code));#I can return pod here too
}

=item B<fix_history($$)>

This will fix the =head1 HISTORY pod tag to reflect aegis history.

=cut

sub fix_history($$) {
	my($self,$curr)=@_;
	my($file)=Meta::Baseline::Aegis::which($curr);
	my($text)=Meta::Utils::File::File::load($file);
	my($revision)=Meta::Tool::Aegis::history($curr);
	my($rev_string)="\n=head1 HISTORY\n\n".$revision->string()."\n\n=head1 SEE ALSO\n";
	if($text=~m/\n=head1 HISTORY\n.*\n\n=head1 SEE ALSO\n/s) {
		Meta::Utils::Output::print("doing [".$curr."]\n");
		$text=~s/\n=head1 HISTORY\n.*\n\n=head1 SEE ALSO\n/$rev_string/s;
		Meta::Utils::File::File::save($file,$text);
	} else {
		Meta::Utils::System::die("cannot find HISTORY tag in [".$curr."]");
	}
}

=item B<fix_license($$)>

This will fix the LICENSE tag.

=cut

sub fix_license($$) {
	my($self,$curr)=@_;
	my($file)=Meta::Baseline::Aegis::which($curr);
	my($text)=Meta::Utils::File::File::load($file);
	my($content)=Meta::Utils::File::File::load(Meta::Baseline::Aegis::which("data/baseline/lice/lice.txt"));
	my($sub)="\n=head1 LICENSE\n\n".$content."\n=head1 DETAILS\n";
	if($text=~m/\n=head1 LICENSE\n\n.*\n\n=head1 DETAILS\n/s) {
		Meta::Utils::Output::print("doing [".$curr."]\n");
		$text=~s/\n=head1 LICENSE\n\n.*\n=head1 DETAILS\n/$sub/s;
		Meta::Utils::File::File::save($file,$text);
	} else {
		Meta::Utils::System::die("cannot find LICENSE tag in [".$curr."]");
	}
}

=item B<fix_author($$)>

This will fix the AUTHOR tag.

=cut

sub fix_author($$) {
	my($self,$curr)=@_;
	my($file)=Meta::Baseline::Aegis::which($curr);
	my($text)=Meta::Utils::File::File::load($file);
	my($content)=Meta::Utils::File::File::load(Meta::Baseline::Aegis::which("data/baseline/lice/auth.txt"));
	my($sub)="\n=head1 AUTHOR\n\n".$content."\n=head1 HISTORY\n";
	if($text=~m/\n=head1 AUTHOR\n\n.*\n\n=head1 HISTORY\n/s) {
		Meta::Utils::Output::print("doing [".$curr."]\n");
		$text=~s/\n=head1 AUTHOR\n\n.*\n=head1 HISTORY\n/$sub/s;
		Meta::Utils::File::File::save($file,$text);
	} else {
		Meta::Utils::System::die("cannot find AUTHOR tag in [".$curr."]");
	}
}

1;

=back

=head1 BUGS

None.

=head1 AUTHOR

Mark Veltzer <mark2776@yahoo.com>

=head1 HISTORY

start of revision info
1	Mon Jan  1 16:38:12 2001	MV	initial code brought in
2	Sat Jan  6 02:40:51 2001	MV	Another change
3	Sat Jan  6 11:39:39 2001	MV	make quality checks on perl code
4	Sat Jan  6 17:14:09 2001	MV	more perl checks
5	Sun Jan  7 18:17:29 2001	MV	make Meta::Utils::Opts object oriented
6	Tue Jan  9 08:56:56 2001	MV	tests for Opts in every .pl
7	Tue Jan  9 17:00:22 2001	MV	fix up perl checks
8	Tue Jan  9 18:15:19 2001	MV	check that all uses have qw
8	Tue Jan  9 19:29:31 2001	MV	fix todo items look in pod documentation
9	Wed Jan 10 12:05:55 2001	MV	more on tests/more checks to perl
10	Wed Jan 10 18:31:05 2001	MV	more perl code quality
11	Thu Jan 11 17:46:02 2001	MV	silense all tests
12	Thu Jan 11 19:25:00 2001	MV	more quality testing
13	Thu Jan 11 22:31:19 2001	MV	more perl code quality
14	Fri Jan 12 09:25:33 2001	MV	more perl quality
15	Sun Jan 14 02:26:10 2001	MV	introduce docbook into the baseline
16	Sun Jan 14 05:25:04 2001	MV	fix up perl cooking a lot
16	Thu Jan 18 15:59:13 2001	MV	correct die usage
17	Thu Jan 18 19:33:43 2001	MV	fix expect.pl test
18	Fri Jan 19 12:38:57 2001	MV	more organization
19	Sat Jan 27 19:56:28 2001	MV	perl quality change
20	Sun Jan 28 02:34:56 2001	MV	perl code quality
21	Sun Jan 28 13:51:26 2001	MV	more perl quality
22	Mon Jan 29 20:54:18 2001	MV	chess and code quality
23	Tue Jan 30 03:03:17 2001	MV	more perl quality
24	Wed Jan 31 15:28:22 2001	MV	get basic Simul up and running
25	Sat Feb  3 03:39:36 2001	MV	make all papers papers
26	Sat Feb  3 23:41:08 2001	MV	perl documentation
27	Mon Feb  5 03:21:02 2001	MV	more perl quality
28	Tue Feb  6 01:04:52 2001	MV	perl qulity code
29	Tue Feb  6 07:02:13 2001	MV	more perl code quality
30	Tue Feb  6 08:47:46 2001	MV	more perl quality
31	Tue Feb  6 22:19:51 2001	MV	revision change
32	Fri Feb  9 09:22:45 2001	MV	revision for perl files and better sanity checks
end of revision info

=head1 SEE ALSO

Nothing.

=head1 TODO

-get a better version of the Pod::Text package (the current one sucks). take care of the return code to the os (it is always success now).

-remove the output file if any error occurs in the process.

-put all the conversion stuff in the perl.pm module and not here and just call it from here.

-use the B:: compiler to do what we do here and not my stupid script.

-nroff conversion currently does nothing. How do you convert pod to nroff ?

-the option causes the cache to be flushed before every activation. We use this module file by file so there should be no cache and so I dont realy think this is neccessary so I dropped it.

-On the other hand we do need to remove the cache once the pod2html is over and that is tougher since the Pod::Html module has no provisioning for that. We do this by hacking a bit and removing the cache ourselves by accessing the modules private variables which are the names of the cache files and removing them ourselves. I contancted Tom Christiasen about it and asked him for the feature.

-Another remark: The result of pod2html is undocumented but it seems that it does not return anything (I looked in the code). I asked for this feature too from Tom but its still not in. In the meantime this utility will always succeed...:)

-byte compilation currently does nothing. Do it.

-the docify routine here is also something from the html conversion.

-maybe a better check is not to activate the perl compiler but rather to do an eval on the file ?

-What about the location of this module ? are there so much location specific stuff to justify it being here ? Why is it in Meta::Baseline ? maybe it should be in Meta::Utils::Perl ?

-can we activate a perl compiler and precompile all the perl modules ?.

-c2html always returns 1 because the error code from the module seems to be no good. How can I take care of that ?

-pod2latex is used in a bad way. Why cant it just produce the output in the
	place I want it to ? change it...

-stopped using -MO=lint,all and -w in the lint processing because of errors-
	bring that back.

=cut
