#!/usr/bin/env perl

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Opts::Opts qw();
use Meta::Projects::Dbman::Page qw();
use Meta::Projects::Dbman::Section qw();
use Meta::Utils::File::Iter qw();
use Meta::Utils::Output qw();
use Meta::Utils::File::File qw();
use Compress::Zlib qw();
use Meta::Tool::Groff qw();
use Meta::Utils::Progress qw();

my($sections,$pages,$demo,$import_description,$import_troff,$import_ascii,$import_ps,$import_dvi,$import_html);
my($opts)=Meta::Utils::Opts::Opts->new();
$opts->set_standard();
$opts->def_bool("sections","import sections ?",1,\$sections);
$opts->def_bool("pages","import pages ?",1,\$pages);
$opts->def_bool("demo","fake it ?",0,\$demo);
$opts->def_bool("import_description","import description ?",1,\$import_description);
$opts->def_bool("import_troff","import troff format ?",1,\$import_troff);
$opts->def_bool("import_ascii","import ascii format ?",1,\$import_ascii);
$opts->def_bool("import_ps","import ps format ?",1,\$import_ps);
$opts->def_bool("import_dvi","import dvi format ?",1,\$import_dvi);
$opts->def_bool("import_html","import html format ?",1,\$import_html);
$opts->set_free_allo(0);
$opts->analyze(\@ARGV);

my(%map_hash)=(
	"1","1",
	"2","2",
	"3","3",
	"4","4",
	"5","5",
	"6","6",
	"7","7",
	"8","8",
	"9","9",
	"n","n",
	"h","n",
	"l","n",
	"1ssl","1",
	"1m","1",
	"1x","1",
	"3pm","3",
	"3x","3",
	"3thr","3",
	"3qt","3",
	"3t","3",
	"3ncp","3",
	"3ssl","3",
	"5ssl","5",
	"5x","5",
	"6x","6",
	"7ssl","7",
	"8c","8",
);
my($names)=[
	"Section 1",
	"Section 2",
	"Section 3",
	"Section 4",
	"Section 5",
	"Section 6",
	"Section 7",
	"Section 8",
	"Section 9",
	"Section n",
];
my($descriptions)=[
	"User Commands",
	"System Calls",
	"Subroutines",
	"Devices",
	"File Formats",
	"Games",
	"Miscellaneous",
	"System Administration",
	"Kernel",
	"New",
];
my($tags)=[
	"1",
	"2",
	"3",
	"4",
	"5",
	"6",
	"7",
	"8",
	"9",
	"n",
];

if($sections) {
	#setup all the sections
	for(my($i)=0;$i<=$#$names;$i++) {
		my($name)=$names->[$i];
		my($description)=$descriptions->[$i];
		my($tag)=$tags->[$i];
		if(!$demo) {
			my($section)=Meta::Projects::Dbman::Section->create({});
			$section->name($name);
			$section->description($description);
			$section->tag($tag);
			$section->commit();
		}
	}
}

if($pages) {
	#create a tag -> section id mapping
	my(%mapping);
	my(@sections)=Meta::Projects::Dbman::Section->retrieve_all();
	for(my($i)=0;$i<=$#sections;$i++) {
		my($curr)=$sections[$i];
		$mapping{$curr->tag()}=$curr->id();
	}
	my($dirs)=[
#		"/local/tools/man",
#		"/usr/share/man",
		"/usr/local/man",
#		"/usr/X11R6/man",
#		"/usr/kerberos/man",
#		"/usr/lib/perl5/man",
#		"/usr/man",
#		"/local/tools/share/aegis/en",
#		"/local/tools/share/aegis",
	];

	my($iter)=Meta::Utils::File::Iter->new();
	for(my($i)=0;$i<=$#$dirs;$i++) {
		my($curr)=$dirs->[$i];
		$iter->add_directory($curr);
	}
	$iter->set_want_dirs(0);
	$iter->nstart();
	my($progress)=Meta::Utils::Progress->new();
	$progress->start();
	while(!($iter->get_over())) {
		my($curr)=$iter->get_curr();
		#Meta::Utils::Output::print("curr is [".$curr."]\n");
		my($doit)=0;
		my($name,$description,$tag,$content_troff,$content_troff_unzipped);
		#uncompressed file
		if($curr=~m/\/man.*\/.*\..*$/) {
			#Meta::Utils::Output::print("curr is [".$curr."]\n");
			$content_troff_unzipped=Meta::Utils::File::File::load($curr);
			#compress is
			$content_troff=Compress::Zlib::memGzip($content_troff_unzipped);
			($name,$tag)=($curr=~/\/man.*\/(.*)\.(.*)$/);
			$doit=1;
		}
		#compressed file
		if($curr=~m/\/man.*\/.*\..*\.gz$/) {
			$content_troff=Meta::Utils::File::File::load($curr);
			$content_troff_unzipped=Compress::Zlib::memGunzip($content_troff);
			($name,$tag)=($curr=~/\/man.*\/(.*)\.(.*)\.gz$/);
			$doit=1;
		}
		#find the section id
		#this is db oriented code - currently commented
		#my($section);
		#my($sect_obj)=Meta::Projects::Dbman::Section->search('tag',$tag);
		#if(!defined($sect_obj)) {
		#	Meta::Utils::Output::print("cannot find tag for [".$curr."]\n");
		#	$doit=0;
		#} else {
		#	$section=$sect_obj->id();
		#}
		#find the section id
		my($section);
		if(exists($map_hash{$tag})) {
			my($map_tag)=$map_hash{$tag};
			if(exists($mapping{$map_tag})) {
				$section=$mapping{$map_tag};
			} else {
				Meta::Utils::System::die("internal mapping problem");
			}
		} else {
			$doit=0;
		}
		if($doit) {
			#extract description from content
			if(!$demo) {
				my($page)=Meta::Projects::Dbman::Page->create({});
				$page->section($section);
				$page->name($name);
				if($import_description) {
					$description=Meta::Tool::Groff::get_oneliner($content_troff_unzipped);
					$page->description($description);
				}
				if($import_troff) {
					$page->content_troff($content_troff);
				}
				if($import_ascii) {
					my($content_ascii)=Compress::Zlib::memGzip(Meta::Tool::Groff::process($content_troff_unzipped));
					$page->content_ascii($content_ascii);
				}
				if($import_ps) {
				}
				if($import_dvi) {
				}
				if($import_html) {
				}
				$page->commit();
			}
		} else {
			Meta::Utils::Output::print("not matched [".$curr."]\n");
		}
		$iter->nnext();
		$progress->report();
	}
	$iter->fini();
	$progress->finish();
}

Meta::Utils::System::exit(1);

__END__

=head1 NAME

dbman_import.pl - import manual pages into the dbman database.

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

	MANIFEST: dbman_import.pl
	PROJECT: meta
	VERSION: 0.06

=head1 SYNOPSIS

	dbman_import.pl [options]

=head1 DESCRIPTION

This program imports the on-disk manual pages specified by a search path
and puts them into the dbman RDBMS.

=head1 OPTIONS

=over 4

=item B<help> (type: bool, default: 0)

display help message

=item B<pod> (type: bool, default: 0)

display pod options snipplet

=item B<man> (type: bool, default: 0)

display manual page

=item B<quit> (type: bool, default: 0)

quit without doing anything

=item B<gtk> (type: bool, default: 0)

run a gtk ui to get the parameters

=item B<license> (type: bool, default: 0)

show license and exit

=item B<copyright> (type: bool, default: 0)

show copyright and exit

=item B<history> (type: bool, default: 0)

show history and exit

=item B<sections> (type: bool, default: 1)

import sections ?

=item B<pages> (type: bool, default: 1)

import pages ?

=item B<demo> (type: bool, default: 0)

fake it ?

=item B<import_description> (type: bool, default: 1)

import description ?

=item B<import_troff> (type: bool, default: 1)

import troff format ?

=item B<import_ascii> (type: bool, default: 1)

import ascii format ?

=item B<import_ps> (type: bool, default: 1)

import ps format ?

=item B<import_dvi> (type: bool, default: 1)

import dvi format ?

=item B<import_html> (type: bool, default: 1)

import html format ?

=back

no free arguments are allowed

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mailto:veltzer@cpan.org
	WWW: http://www.veltzer.org
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV import tests
	0.01 MV dbman package creation
	0.02 MV more thumbnail issues
	0.03 MV website construction
	0.04 MV improve the movie db xml
	0.05 MV web site automation
	0.06 MV SEE ALSO section fix

=head1 SEE ALSO

Compress::Zlib(3), Meta::Projects::Dbman::Page(3), Meta::Projects::Dbman::Section(3), Meta::Tool::Groff(3), Meta::Utils::File::File(3), Meta::Utils::File::Iter(3), Meta::Utils::Opts::Opts(3), Meta::Utils::Output(3), Meta::Utils::Progress(3), Meta::Utils::System(3), strict(3)

=head1 TODO

-use time stamps and inodes in the database to determine if things need to be updated.

-take care of all the warnings that come out when doing a full import.

-make the list of directories to be scanned be read from an option file.

-make the db user and password and connection info also be read from a configuration file.

-do the ps,dvi and html importing.
