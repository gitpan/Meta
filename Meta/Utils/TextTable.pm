#!/bin/echo This is a perl module and should not be run

package Meta::Utils::TextTable;

use strict qw(vars refs subs);
use IO qw();
use Meta::Utils::Output qw();

our($VERSION,@ISA);
$VERSION="0.29";
@ISA=qw();

#sub new($);
#sub get_name($);
#sub read_all($$);
#sub delete_all($);
#sub prepare_write($$);
#sub write_rec($);
#sub read_head($);
#sub index_fields($$$);
#sub TEST($);

#__DATA__

sub new($) {
	my($clas)=@_;
	my($self)={};
	bless($self,$clas);

	$self->{NAME}=defined;
	my($name)="foo";
	#Meta::Utils::Output::print("will open [".$name."]\n");

	$self->{file}=new IO::File;
	if(!($self->{file}->open("+<$name"))) {
		#Meta::Utils::Output::print("could not open [".$name."] in constructing text table object");
		return(undef);
	}
	$self->{recstruct}=();
	$self->read_head();

	return($self);
}

sub get_name($) {
	my($self)=@_;
	return($self->{name});
}

sub read_all($$) {
	my($self,$fields)=@_;

	my($file)=$self->{file};
	seek($file,0,0);

	<$file> || 0;#skip header
	Meta::Utils::Output::print("in read all,fref is [".$file."]\n");

	my(@fnames)=split(/\s*,\s*/,$fields);
	my(@rec);
	$self->index_fields(\@fnames,\@rec);

	my($table)=[];
	my($count)=0;
	my($line);
	while($line=<$file> || 0) {
		chop($line);
		my(@f)=split("\t",$line);
		$table->[$count]=();
		for(my($i)=0;$i<=$#rec;$i++) {
			$table->[$count]->[$i]=$f[$rec[$i]];
		}
		$count++;
	}
	return($table);
}

sub delete_all($) {
	my($self)=@_;

	Meta::Utils::Output::print("will delete all\n");
	my($file)=$self->{file};
	seek($file,0,0) || Meta::Utils::System::die("cannot seek");
	Meta::Utils::Output::print("done seek\n");
	<$file> || 0;
	my($head_length)=tell($file);
	truncate($file,$head_length);
}

sub prepare_write($$) {
	my($self,$fields)=@_;

	my(@f)=split(/\s*,\s*/,$fields);

	my(@index);

	$self->{write_noof}=$#f;
	for(my($i)=0;$i<=$#f;$i++) {
		Meta::Utils::Output::print("The val :".$self->{name_field}->{$f[$i]}."\n");
		if(!exists($self->{name_field}->{$f[$i]})) {
			Meta::Utils::Output::print("cannot write non existing field [".$f[$i]."]\n");
			return(0);
		}
		my($fid)=$self->{name_field}->{$f[$i]};
		$index[$fid]=$i;
	}
	$self->{write_index}=\@index;
	return(1);
}

sub write_rec($) {
	my($self)=shift;

	if($#_!=$self->{write_noof}) {
		Meta::Utils::Output::print("bad number of field in write [".$#_."] instead ".$self->{write_noof}."\n");
		return(0);
	}

	my($fref)=$self->{file};
	Meta::Utils::Output::print("in write_rec,fref is [".$fref."]\n");
	my(@rec);
	my($fname_ref)=$self->{field_name};
	my($max_i)=$#$fname_ref;
	for(my($i)=0;$i<=$max_i;$i++) {
		if(defined($self->{write_index}->[$i])) {
			$rec[$i]=@_[$self->{write_index}->[$i]];
		} else {
			$rec[$i]=0;
		}
	}
	print $fref join("\t",@rec)."\n";
	Meta::Utils::Output::print("should have print :".join("\t",@rec)."\n");

	return(1);
}

sub read_head($) {
	my($self)=@_;

	my($file)=$self->{file};
	my($head)=<$file> || 0;
	chop $head;

	Meta::Utils::Output::print("read header [".$head."]\n");

	my(@f)=split("\t",$head);

	Meta::Utils::Output::print("num of fields [".$#f."]\n");

	$self->{field_name}=\@f;
	$self->{name_field}=();
	for(my($i)=0;$i<=$#f;$i++) {
		Meta::Utils::Output::print("name field [".$f[$i]."] is [".$i."]\n");
		$self->{name_field}->{$f[$i]}=$i;
	}
}

sub index_fields($$$) {
	my($self,$names,$index)=@_;

	for(my($i)=0;$i<=$#$names;$i++) {
		$index->[$i]=$self->{name_field}->{$names->[$i]};
	}
}

sub TEST($) {
	my($context)=@_;
	return(1);
}

1;

__END__

=head1 NAME

Meta::Utils::TextTable - provide services to read and write headed, field delimited text files.

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

	MANIFEST: TextTable.pm
	PROJECT: meta
	VERSION: 0.29

=head1 SYNOPSIS

	my($object)=Meta::Utils::TextTable->new();

=head1 DESCRIPTION

Provide interface to database tables, mask database
implementation from its users.

=head1 FUNCTIONS

	new($)
	get_name($)
	read_all($$)
	delete_all($)
	prepare_write($$)
	write_rec($)
	read_head($);
	index_fields($$$);
	TEST($);

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<new($)>

This constructor creates a new Meta::Utils::TextTable object.

=item B<TEST($)>

Test suite for this module.

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

	0.00 MV initial code brought in
	0.01 MV bring databases on line
	0.02 MV c++ and perl code quality checks
	0.03 MV more perl checks
	0.04 MV make Meta::Utils::Opts object oriented
	0.05 MV fix todo items look in pod documentation
	0.06 MV more on tests/more checks to perl
	0.07 MV more perl code quality
	0.08 MV correct die usage
	0.09 MV perl code quality
	0.10 MV more perl quality
	0.11 MV more perl quality
	0.12 MV perl documentation
	0.13 MV more perl quality
	0.14 MV perl qulity code
	0.15 MV more perl code quality
	0.16 MV revision change
	0.17 MV languages.pl test online
	0.18 MV perl packaging
	0.19 MV PDMT
	0.20 MV md5 project
	0.21 MV database
	0.22 MV perl module versions in files
	0.23 MV movies and small fixes
	0.24 MV graph visualization
	0.25 MV thumbnail user interface
	0.26 MV more thumbnail issues
	0.27 MV website construction
	0.28 MV web site automation
	0.29 MV SEE ALSO section fix

=head1 SEE ALSO

IO(3), Meta::Utils::Output(3), strict(3)

=head1 TODO

Nothing.
