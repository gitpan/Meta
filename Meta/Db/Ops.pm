#!/bin/echo This is a perl module and should not be run

package Meta::Db::Ops;

use strict qw(vars refs subs);
use Meta::Sql::Stat qw();
use Meta::Sql::Stats qw();
use Meta::Db::Dbi qw();
use Meta::Utils::Output qw();
use Meta::Xml::Writer qw();
use Meta::Utils::System qw();
use Meta::Xml::Parsers::Dbdata qw();
use Meta::Db::Info qw();

our($VERSION,@ISA);
$VERSION="0.11";
@ISA=qw();

#sub act($$);
#sub export_writ($$$$);
#sub export_hand($$$$);
#sub export_file($$$$);
#sub import($);
#sub san($$$$$$$$);
#sub sindex($$$);
#sub TEST($);

#__DATA__

sub act($$) {
	my($conn,$defx)=@_;
	my($verb)=0;
	my($demo)=0;
	if($verb) {
		$conn->print(Meta::Utils::Output::get_file());
		$defx->print(Meta::Utils::Output::get_file());
	}
	my($info)=Meta::Db::Info->new();
	$info->set_name($defx->get_name());
	$info->set_type($conn->get_type());
	my($stats)=Meta::Sql::Stats->new();
	$defx->getsql_drop($stats,$info,1);
	$defx->getsql_create($stats,$info);
	my($dbi)=Meta::Db::Dbi->new();
	$dbi->connect($conn);
	$dbi->execute($stats,$conn,$info);
	$dbi->disconnect($conn);
	return(1);
}

sub export_writ($$$$) {
	my($conn,$defx,$writ,$info)=@_;
	my($dbi)=Meta::Db::Dbi->new();
	$dbi->connect_def($conn,$defx);
	my($tables)=$defx->get_tables();
	$writ->startTag("dbdata");
	$writ->dataElement("name",$defx->get_name());
	$writ->startTag("tables");
	for(my($i)=0;$i<$tables->size();$i++) {
		$writ->startTag("table");
		my($table)=$tables->elem($i);
		$writ->dataElement("name",$table->get_name());
		$writ->startTag("records");
		my($fields)=$table->get_fields();
		my($select)=$fields->getsql_select($info);
		my($stat)=$dbi->prepare("SELECT ".$select." FROM ".$table->get_name());
		if(!$stat) {
			Meta::Utils::System::die("unable to prepare statement");
		}
		my($return)=$stat->execute();
		if(!$return) {
			Meta::Utils::System::die("unable to execute statement");
		}
		my($set)=$stat->fetchrow_arrayref();
		while($set) {
			$writ->startTag("record");
			for(my($k)=0;$k<$fields->size();$k++) {
				$writ->startTag("field");
				my($field)=$fields->elem($k);
				my($name)=$field->get_name();
				my($data)=$set->[$k];
				$writ->dataElement("name",$name);
				$writ->dataElement("data",$data);
				$writ->endTag("field");
			}
			$writ->endTag("record");
			$set=$stat->fetchrow_arrayref();
		}
		$writ->endTag("records");
		$writ->endTag("table");
	}
	$dbi->disconnect($conn);
	$writ->endTag("tables");
	$writ->endTag("dbdata");
}

sub export_hand($$$$) {
	my($conn,$defx,$hand,$info)=@_;
	my($writ)=Meta::Xml::Writer->new(OUTPUT=>$hand,DATA_INDENT=>1,DATA_MODE=>1,UNSAFE=>1);
	$writ->xmlDecl();
	$writ->base_comment();
	$writ->doctype(
		"dbdata",
		"-//META//DTD DBDATA XML V1.0//EN",
		"deve/xml/dbdata.dtd"
	);
	export_writ($conn,$defx,$writ,$info);
}

sub export_file($$$$) {
	my($conn,$defx,$file,$info)=@_;
	open(FILE,"> ".$file) || Meta::Utils::System::die("unable to open file [".$file."]");
	export_hand($conn,$defx,*FILE,$info);
	close(FILE) || Meta::Utils::System::die("unable to close file [".$file."]");
}

sub import($) {
	my($xmlx)=@_;
	my($parser)=Meta::Xml::Parsers::Dbdata->new();
	$parser->parsefile($xmlx);
	return(1);
}

sub san($$$$$$$$) {
	my($verb,$demo,$type,$host,$user,$password,$database,$schema)=@_;
	my($dsnx)="dbi:$type";
	if(defined($host)) {
		#$dsnx.=":host=".$host;
	}
	if(defined($database)) {
		$dsnx.=":database=".$database;
	}
	my($dbxx)=DBI->connect($dsnx,$user,$password);
	if(!$dbxx) {
		Meta::Utils::System::die("error in connect");
	}
	my($defx)=Meta::Db::Def->new();
	$defx->read($schema);
	my($scod)=1;
	my($icod)=sindex($dbxx,$defx,$verb);
	if(!$icod) {
		$scod=0;
	}
	my($resu)=$dbxx->disconnect();
	if(!$resu) {
		Meta::Utils::System::die("error in disconnect");
	}
	return(1);
}

sub sindex($$$) {
	my($dbxx,$defx,$verb)=@_;
	my($size)=$defx->num_table();
	if($verb) {
		Meta::Utils::Output::print("in here with size [".$size."]\n");
	}
	my(%hash);
	for(my($i)=0;$i<$size;$i++) {
		my($ctab)=$defx->get_table_i($i);
		my($name)=$ctab->get_name();
		if($verb) {
			Meta::Utils::Output::print("doing [".$name."]\n");
		}
		my($stat)="SELECT id FROM ".$name.";";
		my($resu)=$dbxx->selectall_arrayref($stat);
		if(!defined($resu)) {
			my($resu)=$dbxx->disconnect();
			if(!$resu) {
				Meta::Utils::System::die("error in disconnect");
			}
			Meta::Utils::System::die("error in issuing [".$i."] [".$stat."]");
		}
		for(my($j)=0;$j<=$#$resu;$j++) {
			my($curr)=$resu->[$j]->[0];
			$hash{$name,$curr}=defined;
		}
	}
	for(my($i)=0;$i<$size;$i++) {
		my($ctab)=$defx->get_table_i($i);
		my($name)=$ctab->get_name();
		if($verb) {
			Meta::Utils::Output::print("doing [".$name."]\n");
		}
		my($fiel)=$ctab->num_field();
		for(my($j)=0;$j<$fiel;$j++) {
			my($cfil)=$ctab->get_field_i($j);
			my($ctyp)=$cfil->get_type();
			my($cnam)=$cfil->get_name();
			my($inde)=$ctyp->is_inde();
			my($tabl)=$ctyp->get_tabl();
			if($inde) {
				if($verb) {
					Meta::Utils::Output::print("checking [".$cnam."]\n");
				}
				my($stat)="SELECT $cnam FROM $name;";
				my($resu)=$dbxx->selectall_arrayref($stat);
				if(!defined($resu)) {
					my($resu)=$dbxx->disconnect();
					if(!$resu) {
						Meta::Utils::System::die("error in disconnect");
					}
					Meta::Utils::System::die("error in issuing [".$i."] [".$stat."]");
				}
				for(my($j)=0;$j<=$#$resu;$j++) {
					my($curr)=$resu->[$j]->[0];
					if(!defined($hash{$tabl,$curr})) {
						Meta::Utils::System::die("error in $name,$cnam,$curr pointing to $tabl");
					}
				}
			}
		}
	}
	return(1);
}

sub TEST($) {
	my($context)=@_;
	return(1);
}

1;

__END__

=head1 NAME

Meta::Db::Ops - Perl module to create a database for you.

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

	MANIFEST: Ops.pm
	PROJECT: meta
	VERSION: 0.11

=head1 SYNOPSIS

	package foo;
	use Meta::Db::Ops qw();
	my($scod)=Meta::Db::Ops::act($connection,$dbdef);

=head1 DESCRIPTION

Give this module a few parameters and it will create a database for you.

=head1 FUNCTIONS

	act($$)
	export_writ($$$$)
	export_hand($$$$)
	export_file($$$$)
	import($)
	san($$$$$$$$)
	sindex($$$)
	TEST($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<act($$)>

This will actually do the work of creating.
You need to supply a connection object and a definition object.

=item B<export_writ($$$$)>

This method will export the content of a database to an XML::Writer object.
This method does not prepare statements since when you prepare a statement
you have to know the exact number of parameters that you want and we dont:
for each table the statement should be "SELECT (f1,f2,f3,...,fn) FROM table;"
and the number of fields is changing. We do NOT wish to use a stupid:
"SELECT * FROM table;" since we know which fields are there and we could
avoid errros by doing this.

=item B<export_hand($$$$)>

This method does the same as export_writ except it writes everything to
a file handle and takes care of the writer itself.

=item B<export_file($$$$)>

This method does the same as export_hand except it actually creates a new file.

=item B<import($)>

This method will import the content of an XML file into a database.
It uses a parser to achieve this (the idea is not store the entire XML
in RAM and then import it but rather do it record by record).

=item B<san($$$$$$$$)>

This will actually do the sanity tests.

=item B<sindex($$$)>

This will check that all indices are ok in the database.

=item B<TEST($)>

Test suite for this object.

=back

=head1 SUPER CLASSES

None.

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mailto:veltzer@cpan.org
	WWW: http://www.veltzer.org
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV more database issues
	0.01 MV md5 project
	0.02 MV database
	0.03 MV perl module versions in files
	0.04 MV movies and small fixes
	0.05 MV movie stuff
	0.06 MV thumbnail user interface
	0.07 MV more thumbnail issues
	0.08 MV website construction
	0.09 MV improve the movie db xml
	0.10 MV web site automation
	0.11 MV SEE ALSO section fix

=head1 SEE ALSO

Meta::Db::Dbi(3), Meta::Db::Info(3), Meta::Sql::Stat(3), Meta::Sql::Stats(3), Meta::Utils::Output(3), Meta::Utils::System(3), Meta::Xml::Parsers::Dbdata(3), Meta::Xml::Writer(3), strict(3)

=head1 TODO

-make a routine to just provide the statement lists for creation.
