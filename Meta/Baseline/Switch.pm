#!/bin/echo This is a perl module and should not be run

package Meta::Baseline::Switch;

use strict qw(vars refs subs);
use Meta::Ds::Array qw();
use Meta::Utils::System qw();
use Meta::Baseline::Lang::Aspe qw();
use Meta::Baseline::Lang::Temp qw();
use Meta::Baseline::Lang::Ccxx qw();
use Meta::Baseline::Lang::Cxxx qw();
use Meta::Baseline::Lang::Sgml qw();
use Meta::Baseline::Lang::Java qw();
use Meta::Baseline::Lang::Lily qw();
use Meta::Baseline::Lang::Perl qw();
use Meta::Baseline::Lang::Pyth qw();
use Meta::Baseline::Lang::Rule qw();
use Meta::Baseline::Lang::Txtx qw();
use Meta::Baseline::Lang::Data qw();
use Meta::Baseline::Lang::Rcxx qw();
use Meta::Baseline::Lang::Html qw();
use Meta::Baseline::Lang::Cssx qw();
use Meta::Baseline::Lang::Dirx qw();
use Meta::Baseline::Lang::Cook qw();
use Meta::Baseline::Lang::Aegi qw();
use Meta::Baseline::Lang::Xmlx qw();
use Meta::Baseline::Lang::Pngx qw();
use Meta::Baseline::Lang::Jpgx qw();
use Meta::Baseline::Lang::Epsx qw();
use Meta::Baseline::Lang::Awkx qw();
use Meta::Baseline::Lang::Conf qw();
use Meta::Baseline::Lang::Targ qw();
use Meta::Baseline::Lang::Texx qw();
use Meta::Baseline::Lang::Deps qw();
use Meta::Baseline::Lang::Chec qw();
use Meta::Baseline::Lang::Clas qw();
use Meta::Baseline::Lang::Dvix qw();
use Meta::Baseline::Lang::Chun qw();
use Meta::Baseline::Lang::Objs qw();
use Meta::Baseline::Lang::Psxx qw();
use Meta::Baseline::Lang::Info qw();
use Meta::Baseline::Lang::Rtfx qw();
use Meta::Baseline::Lang::Mifx qw();
use Meta::Baseline::Lang::Midi qw();
use Meta::Baseline::Lang::Bins qw();
use Meta::Baseline::Lang::Dlls qw();
use Meta::Baseline::Lang::Libs qw();
use Meta::Baseline::Lang::Pyob qw();
use Meta::Baseline::Lang::Dtdx qw();
use Meta::Baseline::Lang::Swig qw();
use Meta::Baseline::Lang::Gzxx qw();
use Meta::Baseline::Lang::Pack qw();
use Meta::Baseline::Lang::Dslx qw();
use Meta::Baseline::Lang::Pdfx qw();
use Meta::Baseline::Lang::Dbxx qw();
use Meta::Baseline::Lang::Manx qw();
use Meta::Baseline::Lang::Nrfx qw();
use Meta::Baseline::Lang::Late qw();
use Meta::Baseline::Lang::Lyxx qw();
use Meta::Ds::Enum qw();
use Meta::Utils::Output qw();
use Meta::Pdmt::BuildInfo qw();

our($VERSION,@ISA);
$VERSION="0.48";
@ISA=qw();

#sub get_count($);
#sub get_own($);
#sub get_module($);
#sub get_type_enum();
#sub get_lang_enum();
#sub run_module($$$$$$);

my($arra);

BEGIN {
	$arra=Meta::Ds::Array->new();
	$arra->push("Meta::Baseline::Lang::Aspe");
	$arra->push("Meta::Baseline::Lang::Temp");
	$arra->push("Meta::Baseline::Lang::Ccxx");
	$arra->push("Meta::Baseline::Lang::Cxxx");
	$arra->push("Meta::Baseline::Lang::Sgml");
	$arra->push("Meta::Baseline::Lang::Java");
	$arra->push("Meta::Baseline::Lang::Lily");
	$arra->push("Meta::Baseline::Lang::Perl");
	$arra->push("Meta::Baseline::Lang::Pyth");
	$arra->push("Meta::Baseline::Lang::Rule");
	$arra->push("Meta::Baseline::Lang::Txtx");
	$arra->push("Meta::Baseline::Lang::Data");
	$arra->push("Meta::Baseline::Lang::Rcxx");
	$arra->push("Meta::Baseline::Lang::Html");
	$arra->push("Meta::Baseline::Lang::Cssx");
	$arra->push("Meta::Baseline::Lang::Dirx");
	$arra->push("Meta::Baseline::Lang::Cook");
	$arra->push("Meta::Baseline::Lang::Aegi");
	$arra->push("Meta::Baseline::Lang::Xmlx");
	$arra->push("Meta::Baseline::Lang::Pngx");
	$arra->push("Meta::Baseline::Lang::Jpgx");
	$arra->push("Meta::Baseline::Lang::Epsx");
	$arra->push("Meta::Baseline::Lang::Awkx");
	$arra->push("Meta::Baseline::Lang::Conf");
	$arra->push("Meta::Baseline::Lang::Targ");
	$arra->push("Meta::Baseline::Lang::Texx");
	$arra->push("Meta::Baseline::Lang::Deps");
	$arra->push("Meta::Baseline::Lang::Chec");
	$arra->push("Meta::Baseline::Lang::Clas");
	$arra->push("Meta::Baseline::Lang::Dvix");
	$arra->push("Meta::Baseline::Lang::Chun");
	$arra->push("Meta::Baseline::Lang::Objs");
	$arra->push("Meta::Baseline::Lang::Psxx");
	$arra->push("Meta::Baseline::Lang::Info");
	$arra->push("Meta::Baseline::Lang::Rtfx");
	$arra->push("Meta::Baseline::Lang::Mifx");
	$arra->push("Meta::Baseline::Lang::Midi");
	$arra->push("Meta::Baseline::Lang::Bins");
	$arra->push("Meta::Baseline::Lang::Dlls");
	$arra->push("Meta::Baseline::Lang::Libs");
	$arra->push("Meta::Baseline::Lang::Pyob");
	$arra->push("Meta::Baseline::Lang::Dtdx");
	$arra->push("Meta::Baseline::Lang::Swig");
	$arra->push("Meta::Baseline::Lang::Gzxx");
	$arra->push("Meta::Baseline::Lang::Pack");
	$arra->push("Meta::Baseline::Lang::Dslx");
	$arra->push("Meta::Baseline::Lang::Pdfx");
	$arra->push("Meta::Baseline::Lang::Dbxx");
	$arra->push("Meta::Baseline::Lang::Manx");
	$arra->push("Meta::Baseline::Lang::Nrfx");
	$arra->push("Meta::Baseline::Lang::Late");
	$arra->push("Meta::Baseline::Lang::Lyxx");
}

#__DATA__

sub get_count($) {
	my($modu)=@_;
#	Meta::Utils::Output::print("arra is [".$Meta::Baseline::Switch::arra."]\n");
	my($count)=0;
	for(my($i)=0;$i<$arra->size();$i++) {
		my($curr)=$arra->getx($i);
		if($curr->my_file($modu)) {
			$count++;
		}
	}
	return($count);
}

sub get_own($) {
	my($modu)=@_;
#	Meta::Utils::Output::print("arra is [".$Meta::Baseline::Switch::arra."]\n");
	my(@arra);
	for(my($i)=0;$i<$arra->size();$i++) {
		my($curr)=$arra->getx($i);
		if($curr->my_file($modu)) {
			push(@arra,$curr);
		}
	}
	return(\@arra);
}

sub get_module($) {
	my($modu)=@_;
#	Meta::Utils::Output::print("arra is [".$Meta::Baseline::Switch::arra."]\n");
	for(my($i)=0;$i<$arra->size();$i++) {
		my($curr)=$arra->getx($i);
		if($curr->my_file($modu)) {
			return($curr);
		}
	}
	Meta::Utils::System::die("havent found module for [".$modu."]");
	return(undef);
}

sub get_type_enum() {
	my($type_enum)=Meta::Ds::Enum->new();
	$type_enum->insert("aspe");
	$type_enum->insert("temp");
	$type_enum->insert("ccxx");
	$type_enum->insert("cxxx");
	$type_enum->insert("sgml");
	$type_enum->insert("chun");
	$type_enum->insert("java");
	$type_enum->insert("lily");
	$type_enum->insert("perl");
	$type_enum->insert("pyth");
	$type_enum->insert("rule");
	$type_enum->insert("txtx");
	$type_enum->insert("data");
	$type_enum->insert("rcxx");
	$type_enum->insert("html");
	$type_enum->insert("cssx");
	$type_enum->insert("dirx");
	$type_enum->insert("cook");
	$type_enum->insert("aegi");
	$type_enum->insert("xmlx");
	$type_enum->insert("pngx");
	$type_enum->insert("jpgx");
	$type_enum->insert("epsx");
	$type_enum->insert("awkx");
	$type_enum->insert("conf");
	$type_enum->insert("targ");
	$type_enum->insert("texx");
	$type_enum->insert("deps");
	$type_enum->insert("chec");
	$type_enum->insert("clas");
	$type_enum->insert("dvix");
	$type_enum->insert("chun");
	$type_enum->insert("objs");
	$type_enum->insert("psxx");
	$type_enum->insert("info");
	$type_enum->insert("rtfx");
	$type_enum->insert("mifx");
	$type_enum->insert("midi");
	$type_enum->insert("bins");
	$type_enum->insert("dlls");
	$type_enum->insert("libs");
	$type_enum->insert("pyob");
	$type_enum->insert("dtdx");
	$type_enum->insert("swig");
	$type_enum->insert("gzxx");
	$type_enum->insert("pack");
	$type_enum->insert("dslx");
	$type_enum->insert("pdfx");
	$type_enum->insert("dbxx");
	$type_enum->insert("manx");
	$type_enum->insert("nrfx");
	$type_enum->insert("late");
	$type_enum->insert("lyxx");
	return($type_enum);
}

sub get_lang_enum() {
	my($lang_enum)=Meta::Ds::Enum->new();
	$lang_enum->insert("aspe");
	$lang_enum->insert("temp");
	$lang_enum->insert("ccxx");
	$lang_enum->insert("cxxx");
	$lang_enum->insert("sgml");
	$lang_enum->insert("chun");
	$lang_enum->insert("java");
	$lang_enum->insert("lily");
	$lang_enum->insert("perl");
	$lang_enum->insert("pyth");
	$lang_enum->insert("rule");
	$lang_enum->insert("txtx");
	$lang_enum->insert("data");
	$lang_enum->insert("rcxx");
	$lang_enum->insert("html");
	$lang_enum->insert("cssx");
	$lang_enum->insert("dirx");
	$lang_enum->insert("cook");
	$lang_enum->insert("aegi");
	$lang_enum->insert("xmlx");
	$lang_enum->insert("pngx");
	$lang_enum->insert("jpgx");
	$lang_enum->insert("epsx");
	$lang_enum->insert("awkx");
	$lang_enum->insert("conf");
	$lang_enum->insert("targ");
	$lang_enum->insert("texx");
	$lang_enum->insert("deps");
	$lang_enum->insert("chec");
	$lang_enum->insert("clas");
	$lang_enum->insert("dvix");
	$lang_enum->insert("chun");
	$lang_enum->insert("objs");
	$lang_enum->insert("psxx");
	$lang_enum->insert("info");
	$lang_enum->insert("rtfx");
	$lang_enum->insert("mifx");
	$lang_enum->insert("midi");
	$lang_enum->insert("bins");
	$lang_enum->insert("dlls");
	$lang_enum->insert("libs");
	$lang_enum->insert("pyob");
	$lang_enum->insert("dtdx");
	$lang_enum->insert("swig");
	$lang_enum->insert("gzxx");
	$lang_enum->insert("pack");
	$lang_enum->insert("dslx");
	$lang_enum->insert("pdfx");
	$lang_enum->insert("dbxx");
	$lang_enum->insert("manx");
	$lang_enum->insert("nrfx");
	$lang_enum->insert("late");
	$lang_enum->insert("lyxx");
	return($lang_enum);
}

sub run_module($$$$$$) {
	my($modu,$srcx,$targ,$path,$type,$lang)=@_;
	my($buil)=Meta::Pdmt::BuildInfo->new();
	$buil->set_modu($modu);
	$buil->set_srcx($srcx);
	$buil->set_targ($targ);
	$buil->set_path($path);
	if(0) {
		Meta::Utils::Output::print("modu is [".$modu."]\n");
		Meta::Utils::Output::print("srcx is [".$srcx."]\n");
		Meta::Utils::Output::print("targ is [".$targ."]\n");
		Meta::Utils::Output::print("path is [".$path."]\n");
		Meta::Utils::Output::print("type is [".$type."]\n");
		Meta::Utils::Output::print("lang is [".$lang."]\n");
	}
	my($scod);
	my($foun)=0;
	if($lang eq "aspe") {
	}
	if($lang eq "temp") {
		if($type eq "deps") {
			$scod=Meta::Baseline::Lang::Temp::c2deps($buil);
			$foun=1;
		}
		if($type eq "chec") {
			$scod=Meta::Baseline::Lang::Temp::c2chec($buil);
			$foun=1;
		}
		if($type eq "sgml") {
			$scod=Meta::Baseline::Lang::Temp::c2some($buil);
			$foun=1;
		}
		if($type eq "html") {
			$scod=Meta::Baseline::Lang::Temp::c2some($buil);
			$foun=1;
		}
	}
	if($lang eq "ccxx") {
		if($type eq "deps") {
			$scod=Meta::Baseline::Lang::Ccxx::c2deps($buil);
			$foun=1;
		}
		if($type eq "chec") {
			$scod=Meta::Baseline::Lang::Ccxx::c2chec($buil);
			$foun=1;
		}
		if($type eq "html") {
			$scod=Meta::Baseline::Lang::Ccxx::c2html($buil);
			$foun=1;
		}
		if($type eq "objs") {
			$scod=Meta::Baseline::Lang::Ccxx::c2objs($buil);
			$foun=1;
		}
	}
	if($lang eq "cxxx") {
	}
	if($lang eq "sgml") {
		if($type eq "chec") {
			$scod=Meta::Baseline::Lang::Sgml::c2chec($buil);
			$foun=1;
		}
		if($type eq "deps") {
			$scod=Meta::Baseline::Lang::Sgml::c2deps($buil);
			$foun=1;
		}
		if($type eq "texx") {
			$scod=Meta::Baseline::Lang::Sgml::c2texx($buil);
			$foun=1;
		}
		if($type eq "dvix") {
			$scod=Meta::Baseline::Lang::Sgml::c2dvix($buil);
			$foun=1;
		}
		if($type eq "psxx") {
			$scod=Meta::Baseline::Lang::Sgml::c2psxx($buil);
			$foun=1;
		}
		if($type eq "txtx") {
			$scod=Meta::Baseline::Lang::Sgml::c2txtx($buil);
			$foun=1;
		}
		if($type eq "html") {
			$scod=Meta::Baseline::Lang::Sgml::c2html($buil);
			$foun=1;
		}
		if($type eq "rtfx") {
			$scod=Meta::Baseline::Lang::Sgml::c2rtfx($buil);
			$foun=1;
		}
		if($type eq "manx") {
			$scod=Meta::Baseline::Lang::Sgml::c2manx($buil);
			$foun=1;
		}
		if($type eq "mifx") {
			$scod=Meta::Baseline::Lang::Sgml::c2mifx($buil);
			$foun=1;
		}
		if($type eq "info") {
			$scod=Meta::Baseline::Lang::Sgml::c2info($buil);
			$foun=1;
		}
		if($type eq "pdfx") {
			$scod=Meta::Baseline::Lang::Sgml::c2pdfx($buil);
			$foun=1;
		}
		if($type eq "chun") {
			$scod=Meta::Baseline::Lang::Sgml::c2chun($buil);
			$foun=1;
		}
		if($type eq "xmlx") {
			$scod=Meta::Baseline::Lang::Sgml::c2xmlx($buil);
			$foun=1;
		}
		if($type eq "late") {
			$scod=Meta::Baseline::Lang::Sgml::c2late($buil);
			$foun=1;
		}
		if($type eq "lyxx") {
			$scod=Meta::Baseline::Lang::Sgml::c2lyxx($buil);
			$foun=1;
		}
		if($type eq "gzxx") {
			$scod=Meta::Baseline::Lang::Sgml::c2gzxx($buil);
			$foun=1;
		}
	}
	if($lang eq "chun") {
	}
	if($lang eq "java") {
		if($type eq "deps") {
			$scod=Meta::Baseline::Lang::Java::c2deps($buil);
			$foun=1;
		}
		if($type eq "clas") {
			$scod=Meta::Baseline::Lang::Java::c2clas($buil);
			$foun=1;
		}
		if($type eq "html") {
			$scod=Meta::Baseline::Lang::Java::c2html($buil);
			$foun=1;
		}
		if($type eq "chec") {
			$scod=Meta::Baseline::Lang::Java::c2chec($buil);
			$foun=1;
		}
	}
	if($lang eq "lily") {
		if($type eq "chec") {
			$scod=Meta::Baseline::Lang::Lily::c2chec($buil);
			$foun=1;
		}
		if($type eq "midi") {
			$scod=Meta::Baseline::Lang::Lily::c2midi($buil);
			$foun=1;
		}
		if($type eq "texx") {
			$scod=Meta::Baseline::Lang::Lily::c2texx($buil);
			$foun=1;
		}
		if($type eq "psxx") {
			$scod=Meta::Baseline::Lang::Lily::c2psxx($buil);
			$foun=1;
		}
		if($type eq "dvix") {
			$scod=Meta::Baseline::Lang::Lily::c2dvix($buil);
			$foun=1;
		}
		if($type eq "deps") {
			$scod=Meta::Baseline::Lang::Lily::c2deps($buil);
			$foun=1;
		}
	}
	if($lang eq "perl") {
		if($type eq "deps") {
			$scod=Meta::Baseline::Lang::Perl::c2deps($buil);
			$foun=1;
		}
		if($type eq "objs") {
			$scod=Meta::Baseline::Lang::Perl::c2objs($buil);
			$foun=1;
		}
		if($type eq "manx") {
			$scod=Meta::Baseline::Lang::Perl::c2manx($buil);
			$foun=1;
		}
		if($type eq "nrfx") {
			$scod=Meta::Baseline::Lang::Perl::c2nrfx($buil);
			$foun=1;
		}
		if($type eq "html") {
			$scod=Meta::Baseline::Lang::Perl::c2html($buil);
			$foun=1;
		}
		if($type eq "late") {
			$scod=Meta::Baseline::Lang::Perl::c2late($buil);
			$foun=1;
		}
		if($type eq "txtx") {
			$scod=Meta::Baseline::Lang::Perl::c2txtx($buil);
			$foun=1;
		}
		if($type eq "chec") {
			$scod=Meta::Baseline::Lang::Perl::c2chec($buil);
			$foun=1;
		}
	}
	if($lang eq "pyth") {
		if($type eq "deps") {
			$scod=Meta::Baseline::Lang::Pyth::c2deps($buil);
			$foun=1;
		}
		if($type eq "pyob") {
			$scod=Meta::Baseline::Lang::Pyth::c2objs($buil);
			$foun=1;
		}
		if($type eq "html") {
			$scod=Meta::Baseline::Lang::Pyth::c2html($buil);
			$foun=1;
		}
		if($type eq "chec") {
			$scod=Meta::Baseline::Lang::Pyth::c2chec($buil);
			$foun=1;
		}
	}
	if($lang eq "rule") {
		if($type eq "deps") {
			$scod=Meta::Baseline::Lang::Rule::c2deps($buil);
			$foun=1;
		}
	}
	if($lang eq "txtx") {
		if($type eq "chec") {
			$scod=Meta::Baseline::Lang::Txtx::c2chec($buil);
			$foun=1;
		}
		if($type eq "gzxx") {
			$scod=Meta::Baseline::Lang::Txtx::c2gzxx($buil);
			$foun=1;
		}
	}
	if($lang eq "data") {
	}
	if($lang eq "rcxx") {
	}
	if($lang eq "html") {
		if($type eq "deps") {
			$scod=Meta::Baseline::Lang::Html::c2deps($buil);
			$foun=1;
		}
		if($type eq "chec") {
			$scod=Meta::Baseline::Lang::Html::c2chec($buil);
			$foun=1;
		}
	}
	if($lang eq "cssx") {
	}
	if($lang eq "dirx") {
	}
	if($lang eq "cook") {
	}
	if($lang eq "aegi") {
	}
	if($lang eq "xmlx") {
		if($type eq "deps") {
			$scod=Meta::Baseline::Lang::Xmlx::c2deps($buil);
			$foun=1;
		}
		if($type eq "chec") {
			$scod=Meta::Baseline::Lang::Xmlx::c2chec($buil);
			$foun=1;
		}
		if($type eq "chun") {
			$scod=Meta::Baseline::Lang::Xmlx::c2chun($buil);
			$foun=1;
		}
		if($type eq "sgml") {
			$scod=Meta::Baseline::Lang::Xmlx::c2sgml($buil);
			$foun=1;
		}
		if($type eq "dbxx") {
			$scod=Meta::Baseline::Lang::Xmlx::c2dbxx($buil);
			$foun=1;
		}
		if($type eq "targ") {
			$scod=Meta::Baseline::Lang::Xmlx::c2targ($buil);
			$foun=1;
		}
		if($type eq "rule") {
			$scod=Meta::Baseline::Lang::Xmlx::c2rule($buil);
			$foun=1;
		}
		if($type eq "perl") {
			$scod=Meta::Baseline::Lang::Xmlx::c2perl($buil);
			$foun=1;
		}
		if($type eq "gzxx") {
			$scod=Meta::Baseline::Lang::Xmlx::c2gzxx($buil);
			$foun=1;
		}
	}
	if($lang eq "pngx") {
	}
	if($lang eq "jpgx") {
	}
	if($lang eq "epsx") {
	}
	if($lang eq "awkx") {
	}
	if($lang eq "conf") {
	}
	if($lang eq "targ") {
	}
	if($lang eq "texx") {
	}
	if($lang eq "deps") {
	}
	if($lang eq "chec") {
	}
	if($lang eq "clas") {
	}
	if($lang eq "dvix") {
		if($type eq "chec") {
			$scod=Meta::Baseline::Lang::Dvix::c2chec($buil);
			$foun=1;
		}
		if($type eq "psxx") {
			$scod=Meta::Baseline::Lang::Dvix::c2psxx($buil);
			$foun=1;
		}
		if($type eq "gzxx") {
			$scod=Meta::Baseline::Lang::Dvix::c2gzxx($buil);
			$foun=1;
		}
	}
	if($lang eq "chun") {
	}
	if($lang eq "objs") {
	}
	if($lang eq "psxx") {
		if($type eq "gzxx") {
			$scod=Meta::Baseline::Lang::Psxx::c2gzxx($buil);
			$foun=1;
		}
	}
	if($lang eq "info") {
	}
	if($lang eq "rtfx") {
		if($type eq "gzxx") {
			$scod=Meta::Baseline::Lang::Rtfx::c2gzxx($buil);
			$foun=1;
		}
	}
	if($lang eq "mifx") {
	}
	if($lang eq "midi") {
	}
	if($lang eq "bins") {
	}
	if($lang eq "dlls") {
	}
	if($lang eq "libs") {
	}
	if($lang eq "pyob") {
	}
	if($lang eq "dtdx") {
		if($type eq "deps") {
			$scod=Meta::Baseline::Lang::Dtdx::c2deps($buil);
			$foun=1;
		}
		if($type eq "chec") {
			$scod=Meta::Baseline::Lang::Dtdx::c2chec($buil);
			$foun=1;
		}
		if($type eq "html") {
			$scod=Meta::Baseline::Lang::Dtdx::c2html($buil);
			$foun=1;
		}
	}
	if($lang eq "swig") {
		if($type eq "deps") {
			$scod=Meta::Baseline::Lang::Swig::c2deps($buil);
			$foun=1;
		}
		if($type eq "chec") {
			$scod=Meta::Baseline::Lang::Swig::c2chec($buil);
			$foun=1;
		}
		if($type eq "pmxx") {
			$scod=Meta::Baseline::Lang::Swig::c2pmxx($buil);
			$foun=1;
		}
		if($type eq "pmcc") {
			$scod=Meta::Baseline::Lang::Swig::c2pmcc($buil);
			$foun=1;
		}
	}
	if($lang eq "gzxx") {
	}
	if($lang eq "pack") {
	}
	if($lang eq "dslx") {
	}
	if($lang eq "pdfx") {
		if($type eq "gzxx") {
			$scod=Meta::Baseline::Lang::Pdfx::c2gzxx($buil);
			$foun=1;
		}
	}
	if($lang eq "dbxx") {
	}
	if($lang eq "manx") {
	}
	if($lang eq "nrfx") {
	}
	if($lang eq "late") {
	}
	if($lang eq "lyxx") {
	}
	if(!$foun) {
		Meta::Utils::System::die("havent found module [".$lang."][".$type."]");
	}
	return($scod);
}

1;

__END__

=head1 NAME

Meta::Baseline::Switch - module to help to sort through all available languages.

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

	MANIFEST: Switch.pm
	PROJECT: meta
	VERSION: 0.48

=head1 SYNOPSIS

	package foo;
	use Meta::Baseline::Switch qw();
	my($module)=Meta::Baseline::Switch::get_module("my.pm");

=head1 DESCRIPTION

This is the "switch" library between all language modules.

=head1 FUNCTIONS

	get_count($)
	get_own($)
	get_module($)
	get_type_enum()
	get_lang_enum()
	run_module($$$$$$)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<get_count($)>

This will return the number of modules which report that the file given
is theirs.

=item B<get_own($)>

This method will return a perl list of all the modules which think they
own the file (mainly for debuggin purposes).

=item B<get_module($)>

This will look at a filename and will find the language responsible for
it or will die.

=item B<get_type_enum()>

This method will return an Enum type which has all the possible conversions.

=item B<get_lang_enum()>

This method will return an enum type which has all the possible languages.

=item B<run_module($$$$$$)>

This will run a module for you.

=back

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mark2776@yahoo.com
	WWW: http://www.geocities.com/mark2776
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV perl quality change
	0.01 MV perl code quality
	0.02 MV more perl quality
	0.03 MV more perl quality
	0.04 MV get basic Simul up and running
	0.05 MV perl documentation
	0.06 MV more perl quality
	0.07 MV perl qulity code
	0.08 MV more perl code quality
	0.09 MV revision change
	0.10 MV better general cook schemes
	0.11 MV cook updates
	0.12 MV pictures in docbooks
	0.13 MV revision in files
	0.14 MV revision for perl files and better sanity checks
	0.15 MV languages.pl test online
	0.16 MV history change
	0.17 MV add rtf format to website,work on papers,add dtd lang
	0.18 MV introduce docbook xml and docbook deps
	0.19 MV cleanups
	0.20 MV good xml support
	0.21 MV more on data sets
	0.22 MV move def to xml directory
	0.23 MV bring back sgml to working condition
	0.24 MV automatic data sets
	0.25 MV web site and docbook style sheets
	0.26 MV write some papers and custom dssls
	0.27 MV spelling and papers
	0.28 MV fix docbook and other various stuff
	0.29 MV add zipping subsystem
	0.30 MV convert dtd to html
	0.31 MV PDMT/SWIG support
	0.32 MV Revision in DocBook files stuff
	0.33 MV PDMT stuff
	0.34 MV C++ and temp stuff
	0.35 MV finish lit database and convert DocBook to SGML
	0.36 MV update web site
	0.37 MV XML rules
	0.38 MV perl packaging
	0.39 MV perl packaging
	0.40 MV BuildInfo object change
	0.41 MV PDMT
	0.42 MV md5 project
	0.43 MV database
	0.44 MV perl module versions in files
	0.45 MV movies and small fixes
	0.46 MV graph visualization
	0.47 MV thumbnail user interface
	0.48 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

-make the get_type_enum and get_lang_enum return variables which are prepared in BEGIN.
