#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Utils::File::Path - module to handle path names.

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

MANIFEST: Path.pm
PROJECT: meta

=head1 SYNOPSIS

C<package foo;>
C<use Meta::Utils::File::Path qw();>
C<my($full)=Meta::Utils::File::Path::add_path("/usr/bin:/bin","/sbin:/usr/sbin",":");>

=head1 DESCRIPTION

This package is intended to help you handle paths. For example - remove
automounted parts from your path, get cannonic paths, get absolute paths,
get paths with as few ".." as possible, reduce paths to a minimum etc...

=head1 EXPORTS

C<add_path($$$)>
C<add_path_min($$$)>
C<min_path($$)>
C<resolve_nodie($$$)>
C<resolve($$$)>
C<append($$$)>
C<remove_path($$$)>
C<remove_nonexist($$)>

=cut

package Meta::Utils::File::Path;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT);
use Meta::Utils::System qw();
use Meta::Utils::Output qw();
use Meta::Utils::Utils qw();

$VERSION="1.00";
@ISA=qw(Exporter);
@EXPORT_OK=qw();
@EXPORT=qw();

#sub add_path($$$);
#sub add_path_min($$$);
#sub min_path($$);
#sub resolve_nodie($$$);
#sub resolve($$$);
#sub append($$$);
#sub remove_path($$$);
#sub remove_nonexist($$);

#__DATA__

=head1 FUNCTION DOCUMENTATION

=over

=item B<add_path($$$)>

This functions receives:
1. A first path component.
2. A second path component.
3. A separator used for those paths.
And returns a path which is the catenation of those two paths.
If one of them is nothing then the extra separator will be
ommited.

=cut

sub add_path($$$) {
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
			return($onex.$sepa.$twox);
		}
	}
}

=item B<add_path_min($$$)>

This method does exactly as add_path except it also minimizes the path
of the catenation if indeed catenation takes place (if no catenation
takes place the path is kept the same as the first or second element
which must be already minimized if you with the result ot be minimized).

=cut

sub add_path_min($$$) {
	my($onex,$twox,$sepa)=@_;
	my($resu)=add_path($onex,$twox,$sepa);
	return(min_path($resu,$sepa));
}

=item B<min_path($$)>

This function receives:
0. A string which is a path name.
1. A separator.
This function assumes that the string is a path name with the second argument
is the separator and returns a string which is in effect the same path but has
no two entries which are the same.
The algorithm is to construct a new path and remember the old parts as not
to repeat them.

=cut

sub min_path($$) {
	my($path,$sepa)=@_;
	my(%hash,@retu);
	my(@fiel)=split($sepa,$path);
	for(my($i)=0;$i<=$#fiel;$i++) {
		my($curr)=$fiel[$i];
		if(!exists($hash{$curr})) {
			push(@retu,$curr);
			$hash{$curr}=defined;
		}
	}
	return(join($sepa,@retu));
}

=item B<resolve_nodie($$$)>

This method receives a path and a file and returns the resolution of them:
meaning the abosolute file name of the first file in the path that matches
the file.

=cut

sub resolve_nodie($$$) {
	my($path,$file,$sepa)=@_;
#	Meta::Utils::Output::print("got path [".$path."] and file [".$file."]\n");
	my(@part)=split($sepa,$path);
	for(my($i)=0;$i<=$#part;$i++) {
		my($cpth)=$part[$i];
		my($curr)=$cpth."/".$file;
#		Meta::Utils::Output::print("curr is [".$curr."]\n");
		if(-f $curr) {
			return($curr);
		}
	}
	return(undef);
}

=item B<resolve($$$)>

This method is the same as resolve_nodie expect it dies if it cannot find
the file.

=cut

sub resolve($$$) {
	my($path,$file,$sepa)=@_;
	my($resu)=resolve_nodie($path,$file,$sepa);
	if(!defined($resu)) {
		Meta::Utils::System::die("unable to find file [".$file."] in path [".$path."]");
	}
	return($resu);
}

=item B<append($$$)>

This will append a suffix to the path. This means all elements in the path.

=cut

sub append($$$) {
	my($path,$suff,$sepa)=@_;
	my(@fiel)=split($sepa,$path);
	my(@list);
	for(my($i)=0;$i<=$#fiel;$i++) {
		my($curr)=$fiel[$i];
		push(@list,$curr.$suff);
	}
	return(join($sepa,@list));
}

=item B<remove_path($$$)>

This method reveices a path (and a separator) and a path name.
The method assumes that file is in one of the elements in the
path and returns the relative part of the file name.

=cut

sub remove_path($$$) {
	my($path,$sepa,$file)=@_;
	my(@fiel)=split($sepa,$path);
	for(my($i)=0;$i<=$#fiel;$i++) {
		my($curr)=$fiel[$i]."/";
		#Meta::Utils::Output::print("checking [".$file."] vs [".$curr."]\n");
		if(Meta::Utils::Utils::is_prefix($file,$curr)) {
			return(Meta::Utils::Utils::minus($file,$curr));
		}
	}
	Meta::Utils::System::die("is not a prefix of any [".$path."] [".$sepa."] [".$file."]");
}

=item B<remove_nonexist($$)>

This method return a path which is like the original given to
it except it removes the parts of the path which are not
real directories.

=cut

sub remove_nonexist($$) {
	my($path,$sepa)=@_;
	my(@retu);
	my(@fiel)=split($sepa,$path);
	for(my($i)=0;$i<=$#fiel;$i++) {
		my($curr)=$fiel[$i];
		if(-d $curr) {
			push(@retu,$curr);
		}
	}
	return(join($sepa,@retu));
}

1;

=back

=head1 BUGS

None.

=head1 AUTHOR

Mark Veltzer <mark2776@yahoo.com>

=head1 HISTORY

start of revision info
end of revision info

=head1 SEE ALSO

Nothing.

=head1 TODO

Nothing.

=cut
