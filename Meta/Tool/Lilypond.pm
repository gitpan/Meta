#!/bin/echo This is a perl module and should not be run

package Meta::Tool::Lilypond;

use strict qw(vars refs subs);
use Meta::Baseline::Utils qw();
use Meta::Utils::File::Remove qw();
use Meta::Utils::File::Move qw();
use Meta::Utils::File::Symlink qw();
use Meta::Utils::Utils qw();
use Meta::Utils::Output qw();
use Meta::Utils::Env qw();

our($VERSION,@ISA);
$VERSION="0.10";
@ISA=qw();

#sub c2chec($);
#sub c2midi($);
#sub c2texx($);
#sub c2psxx($);
#sub c2dvix($);
#sub c2deps($);
#sub myfile($$);

#__DATA__

sub c2chec($) {
	my($buil)=@_;
	Meta::Baseline::Utils::file_emblem($buil->get_targ());
	return(1);
}

sub c2midi($) {
	my($buil)=@_;
	my($srcx)=$buil->get_srcx();
	my($targ)=$buil->get_targ();
	my($prog)="/local/tools/bin/lilypond";
	my(@args);
	push(@args,"--no-paper");
	push(@args,"--output=".$targ);
	push(@args,$srcx);
	Meta::Utils::Env::set("LD_LIBRARY_PATH","/local/tools/lib");
	#Meta::Utils::Output::print("args are [".CORE::join(",",@args)."]\n");
	return(Meta::Utils::System::system_err_silent_nodie($prog,\@args));
}

sub c2texx($) {
	my($buil)=@_;
	my($srcx)=$buil->get_srcx();
	my($targ)=$buil->get_targ();
	my($prog)="/local/tools/bin/lilypond";
	my(@args);
	push(@args,"--format=tex");
	push(@args,"--output=".$targ);
	push(@args,$srcx);
	Meta::Utils::Env::set("LD_LIBRARY_PATH","/local/tools/lib");
	#Meta::Utils::Output::print("args are [".CORE::join(",",@args)."]\n");
	my($res)=Meta::Utils::System::system_err_silent_nodie($prog,\@args);
	my($extra)=Meta::Utils::Utils::remove_suffix($targ).".midi";
	Meta::Utils::File::Remove::rm_nodie($extra);
	return($res);
}

sub c2psxx($) {
	my($buil)=@_;
	my($srcx)=$buil->get_srcx();
	my($targ)=$buil->get_targ();
	my($prog)="/local/tools/bin/lilypond";
	my(@args);
	push(@args,"--format=ps");
	push(@args,"--output=".$targ);
	push(@args,$srcx);
	Meta::Utils::Env::set("LD_LIBRARY_PATH","/local/tools/lib");
	#Meta::Utils::Output::print("args are [".CORE::join(",",@args)."]\n");
	my($res)=Meta::Utils::System::system_err_silent_nodie($prog,\@args);
	my($extra)=Meta::Utils::Utils::remove_suffix($targ).".midi";
	Meta::Utils::File::Remove::rm_nodie($extra);
	return($res);
}

sub c2dvix($) {
	my($buil)=@_;
	my($srcx)=$buil->get_srcx();
	my($targ)=$buil->get_targ();
	Meta::Utils::Env::set("LD_LIBRARY_PATH","/local/tools/lib");
	#return(Meta::Utils::System::system_err_silent_nodie("ly2dvi",["--output=",$targ,$srcx]));
	#return(Meta::Utils::System::system_err_silent_nodie("lilypond",["--format=dvi","--output=".$targ,$srcx]));
	my($dire)=Meta::Utils::Utils::get_temp_dire();
	my($file)=$dire."/tmp.ly";
	my($outf)=$dire."/tmp.dvi";
	my($oldd)=Meta::Utils::Utils::pwd();
	Meta::Utils::Utils::chdir($dire);
	my($full)=Meta::Baseline::Aegis::which_f($srcx);
	Meta::Utils::File::Symlink::symlink($full,$file);
	my($resu)=Meta::Utils::System::system_err_silent_nodie("ly2dvi",[$file]);
	Meta::Utils::Utils::chdir($oldd);
	if($resu) {
		Meta::Utils::File::Move::mv($outf,$targ);
	}
	Meta::Utils::File::Remove::rmrecursive($dire);
	return($resu);
}

sub c2deps($) {
	my($buil)=@_;
	Meta::Baseline::Utils::file_emblem($buil->get_targ());
	return(1);
}

sub my_file($$) {
	my($self,$file)=@_;
	if($file=~/^lily\/.*\.ly$/) {
		return(1);
	}
	return(0);
}

1;

__END__

=head1 NAME

Meta::Tool::Lilypond - what does your module/class do.

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

	MANIFEST: Lilypond.pm
	PROJECT: meta
	VERSION: 0.10

=head1 SYNOPSIS

	package foo;
	use Meta::Tool::Lilypond qw();
	my($object)=Meta::Tool::Lilypond->new();
	my($result)=$object->method();

=head1 DESCRIPTION

This tool handles all Lilypond stuff in the baseline. It does the
following:
1. checks lilypond sources.
2. converts lilypond sources to various formats: midi,tex,ps,dvi. 
3. extracts dependency information from lilypond sources.
This assumes usage of lilypond 1.4.3 or higher and compatible (as far as
command line interaction) versions.
Mind you, that 1.2/3 versions will not work as the command line interface
was changed and the actual source format for lilypond has changed.

We are using two lilypond supplied command line tools to do what we do
here: lilypond and ly2dvi.

There are a couple of problems with running lilypond:
1. the --output switch doesnt work. it still creates the output in the
	current directory and not in the specified file.
2. it leaves junk behind.
because of these reasons we surround lilypond with a protective shield
(temp dir, moving of target etc...).
3. Its postscript backend produces postscript files which dont contain
	the fonts (i.e. bad postscript). On the other hand, the dvi
	output is good so if you convert lilypond to dvi and then
	use dvips to convert to postscript the results are good.

There are two problems with just running ly2dvi:
1. it leaves the midi file behind.
2. it adds the suffix .dvi to your specification of the output file.
because of these reasons we surround ly2dvi with a protective shield
(temp dir, moving of target etc...).

Please also read the instructions I have about installing lilypond
(there are some font issues there...).

Also note that the order of arguments to lilypond is crutial (the source
should be the last one).

Another funny thing is that ly2dvi adds a ".dvi" suffix to whatever
file you want it to create.

=head1 FUNCTIONS

	c2chec($)
	c2midi($)
	c2texx($)
	c2psxx($)
	c2dvix($)
	c2deps($)
	myfile($$)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<c2chec($)>

This routine verifies the lilypond source.
Currently it does nothing.
This method returns an error code.

=item B<c2midi($)>

This routine will convert lilypond files to midi files.
This method returns an error code.

=item B<c2texx($)>

This routine will convert lilypond files to tex.
This method returns an error code.
This methdd remove the extra midi file which gets created in the process.

=item B<c2psxx($)>

This routine will convert lilypond files to Postscript.
This method returns an error code.
This methdd remove the extra midi file which gets created in the process.

=item B<c2dvix($)>

This routine will convert lilypond files to Dvi format.
This method returns an error code.
In this method, unlike the previous ones, we use the ly2dvi executable rather
than the lilypond executable which seems to crash when asked to create a dvi
output. The original lilypond version is remarked.
The reason that we use the long version here is because ly2dvi
adds a ".dvi" suffix to its output.

=item B<c2deps($)>

This method will convert lilypond source files to dependency listings.
This method currently does nothing.
This method returns an error code.

=item B<my_file($$)>

This method will return true if the file received should be handled by this
module.

=back

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mark2776@yahoo.com
	WWW: http://www.geocities.com/mark2776
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV pics with db support
	0.01 MV spelling and papers
	0.02 MV perl packaging
	0.03 MV BuildInfo object change
	0.04 MV data sets
	0.05 MV md5 project
	0.06 MV database
	0.07 MV perl module versions in files
	0.08 MV movies and small fixes
	0.09 MV thumbnail user interface
	0.10 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

-add includes using the --include lilypond directive.

-do actual dependency calculations for lilypond source files (either with my own parser or use the lilypond parser - or both...)

-do actual checking of lilypond sources (my own parser since lilypond doesnt provide things like that...).
