#!/usr/bin/env perl

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Opts::Opts qw();
use Meta::Db::Def qw();
use Meta::Db::Connections qw();
use Meta::Db::Dbi qw();
use Meta::Utils::File::Iter qw();
use Meta::Utils::File::Prop qw();
use Fcntl qw();
use Meta::Digest::MD5 qw();
use File::Basename qw();
use Meta::Utils::Time qw();
use Meta::Ds::Array qw();
use Meta::Sql::Stats qw();
use Meta::Db::Info qw();
use Meta::Baseline::Aegis qw();

my($def_file,$connections_file,$name,$con_name,$clean,$dire,$verb);
my($opts)=Meta::Utils::Opts::Opts->new();
$opts->set_standard();
$opts->def_stri("def_file","which definition file to use ?","xmlx/def/md5.xml",\$def_file);
$opts->def_stri("connections_file","which connections file to use ?","xmlx/connections/connections.xml",\$connections_file);
$opts->def_stri("name","which database name ?",undef,\$name);
$opts->def_stri("con_name","which connection name ?",undef,\$con_name);
$opts->def_bool("clean","clean the database before import ?",0,\$clean);
$opts->def_dire("directory","what directory to scan ?",Meta::Baseline::Aegis::baseline()."/jpgx",\$dire);
$opts->def_bool("verbose","should I be noisy ?",1,\$verb);
$opts->set_free_allo(0);
$opts->analyze(\@ARGV);

my($def)=Meta::Db::Def->new_deve($def_file);
if(!defined($name)) {
	$name=$def->get_name();
}
my($connections)=Meta::Db::Connections->new_deve($connections_file);
my($connection);
if(defined($con_name)) {
	$connection=$connections->get($con_name);
} else {
	$connection=$connections->get_def_con();
}
my($dbi)=Meta::Db::Dbi->new();
$dbi->connect_name($connection,$name);

my($info)=Meta::Db::Info->new();
$info->set_name($name);
$info->set_type($connection->get_type());

if($clean) {
	my($stats)=Meta::Sql::Stats->new();
	$def->getsql_clean($stats,$info);
	$dbi->execute($stats,$connection,$info);
}

$dbi->begin_work();

#start transaction
#prepare the insert statement
my($stat)=$dbi->prepare("INSERT into node (id,type,mod_time,inode,name,size,checksum) VALUES (?,?,?,?,?,?,?);");
#prepare the insert edge statement
my($stat2)=$dbi->prepare("INSERT into edge (fr_node,to_node) VALUES (?,?);");

my($arra)=Meta::Ds::Array->new();

my($iterator)=Meta::Utils::File::Iter->new();
$iterator->add_directory($dire);
$iterator->set_want_dirs(1);
$iterator->start();
# this needs to be the next available id from the db
my($data_id)=1;
$arra->setx(0,$data_id);
while(!$iterator->get_over()) {
	my($curr)=$iterator->get_curr();
	if($verb) {
		Meta::Utils::Output::print("doing [".$curr."]\n");
	}
	my($sb)=Meta::Utils::File::Prop::stat($curr);
	my($data_type);
	my($found)=0;
	if(Fcntl::S_ISREG($sb->mode())) {
		$data_type="file";
		$found=1;
	}
	if(Fcntl::S_ISDIR($sb->mode())) {
		$data_type="directory";
		$found=1;
	}
	if(!$found) {
		Meta::Utils::System::die("no type for [".$curr."]");
	}
	my($data_mod_time)=Meta::Utils::Time::stat2mysql($sb->mtime());
	#Meta::Utils::Output::print("data_mod_time is [".$data_mod_time."]\n");
	my($data_inode)=$sb->ino();
	my($data_name)=File::Basename::basename($curr);
	my($data_size)=$sb->size();
	my($data_checksum)=Meta::Digest::MD5::get_filename_digest($curr);
	#Meta::Utils::Output::print("data_type is [".$data_type."]\n");
	my($rv1)=$stat->bind_param(1,$data_id);
	if(!$rv1) { Meta::Utils::System::die("unable to bind param 1");}
	my($rv2)=$stat->bind_param(2,$data_type);
	if(!$rv2) { Meta::Utils::System::die("unable to bind param 2");}
	my($rv3)=$stat->bind_param(3,$data_mod_time);
	if(!$rv3) { Meta::Utils::System::die("unable to bind param 3");}
	my($rv4)=$stat->bind_param(4,$data_inode);
	if(!$rv4) { Meta::Utils::System::die("unable to bind param 4");}
	my($rv5)=$stat->bind_param(5,$data_name);
	if(!$rv5) { Meta::Utils::System::die("unable to bind param 5");}
	my($rv6)=$stat->bind_param(6,$data_size);
	if(!$rv6) { Meta::Utils::System::die("unable to bind param 6");}
	my($rv7)=$stat->bind_param(7,$dbi->quote($data_checksum,DBI::SQL_BINARY),{ TYPE=>"SQL_BINARY" });
	if(!$rv7) { Meta::Utils::System::die("unable to bind param 7");}
	my($rv8)=$stat->execute();
	if(!$rv8) {
		Meta::Utils::System::die("unable to execute statement 1");
	}
	#if this was a directory then remmember its id
	if(Fcntl::S_ISDIR($sb->mode())) {
		my($level)=$iterator->get_level()+1;
		$arra->setx($level,$data_id);
	}
	my($cont_id)=$arra->getx($iterator->get_level());
	#Meta::Utils::Output::print("binding [".$cont_id."] [".$data_id."]\n");
	my($r1)=$stat2->bind_param(1,$cont_id);
	if(!$r1) { Meta::Utils::System::die("unable to bind param 1");
	}
	my($r2)=$stat2->bind_param(2,$data_id);
	if(!$r2) { Meta::Utils::System::die("unable to bind param 2");
	}
	my($r3)=$stat2->execute();
	if(!$r3) {
		Meta::Utils::System::die("unable to execute statement 2");
	}
	$data_id++;
	$iterator->next();
}
$iterator->fini();

$dbi->commit();
$dbi->disconnect();

Meta::Utils::System::exit(1);

__END__

=head1 NAME

md5_import.pl - import directory md5 data into a database.

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

	MANIFEST: md5_import.pl
	PROJECT: meta
	VERSION: 0.10

=head1 SYNOPSIS

	md5_import.pl [options]

=head1 DESCRIPTION

This script receives a directory, traverses it, and adds it's data
to a given Md5 database. The resulting data base will have most of
the information about the hirarchy of the directory and checksum
information on each file.

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

=item B<def_file> (type: stri, default: xmlx/def/md5.xml)

which definition file to use ?

=item B<connections_file> (type: stri, default: xmlx/connections/connections.xml)

which connections file to use ?

=item B<name> (type: stri, default: )

which database name ?

=item B<con_name> (type: stri, default: )

which connection name ?

=item B<clean> (type: bool, default: 0)

clean the database before import ?

=item B<directory> (type: dire, default: /local/development/projects/meta/baseline/jpgx)

what directory to scan ?

=item B<verbose> (type: bool, default: 1)

should I be noisy ?

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

	0.00 MV movie stuff
	0.01 MV more thumbnail code
	0.02 MV more thumbnail stuff
	0.03 MV thumbnail user interface
	0.04 MV import tests
	0.05 MV more thumbnail issues
	0.06 MV md5 project
	0.07 MV website construction
	0.08 MV improve the movie db xml
	0.09 MV web site automation
	0.10 MV SEE ALSO section fix

=head1 SEE ALSO

Fcntl(3), File::Basename(3), Meta::Baseline::Aegis(3), Meta::Db::Connections(3), Meta::Db::Dbi(3), Meta::Db::Def(3), Meta::Db::Info(3), Meta::Digest::MD5(3), Meta::Ds::Array(3), Meta::Sql::Stats(3), Meta::Utils::File::Iter(3), Meta::Utils::File::Prop(3), Meta::Utils::Opts::Opts(3), Meta::Utils::System(3), Meta::Utils::Time(3), strict(3)

=head1 TODO

-do an update version of this script which only changes the information which is no longer needed.

-fix the problem that we always start with an ID of 1.
