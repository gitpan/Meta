#!/bin/echo This is a perl module and should not be run

package Meta::Utils::Opti;

use strict qw(vars refs subs);
use Meta::Utils::Output qw();

our($VERSION,@ISA);
$VERSION="0.25";
@ISA=qw();

#sub opti_read_file($);
#sub opti_get_scal($);
#sub opti_exis_scal($);
#sub opti_get_arra($$);

#__DATA__

sub opti_read_file($) {
	my($file)=@_;

	open(OPTI,$file) || Meta::Utils::System::die("cannot open option file [".$file."]");

	my($line);
	my($scope);
	while($line=<OPTI> || 0) {
		chop $line;
		if($line !~/\w/) {
			next;
		}
		if($line=~/\[.*\]\s*$/) {
			($scope)=($line=~/\[(.*)\]\s*$/);
			$scope=lc($scope);
			next;
		}
		if($line=~/=\s*\{\s*\D\s*\d+\s*/) {
			my($name)=($line=~/(\w*)\s*=/);
			my($rest)=($line=~/\{\s*\D\s*\d+\s*(.*)$/);
			$name=lc($name);
			if(!defined($rest) || $rest eq "") {
				$line=<OPTI> || 0;
				chop $line;
			} else {
				$line=$rest;
			}
			my($stop)=0;
			my($count)=0;
			while(!$stop && $line) {
				if($line=~/\}/) {
					$stop=1;
					($line)=($line=~/(.*)\}/);
					if($line eq "") {
						next;
					}
				}
				my(@f)=split("\t",$line);
				my($v);
				for $v (@f) {
					$::xfer_opti_arra{$scope."::".$name."::".$count}=$v;
					$count++;
				}
				if(!$stop) {
					$line=<OPTI> || 0;
					chop $line;
				}
			}
			next;
		}
		if($line=~/=/) {
			my($name,$val)=split(/\s*=\s*/,$line);
			$name=lc($name);
			$::xfer_opti{$scope."::".$name}=$val;
			next;
		}
		Meta::Utils::Output::print("bad option file line [".$line."]\n");
	}
}

sub opti_get_scal($) {
	my($opt_name)=@_;
	my($lopt)=lc($opt_name);
	if(!exists($::xfer_opti{$lopt})) {
		Meta::Utils::System::die("Required option [".$lopt."] not found\n");
	}
	return($::xfer_opti{$lopt});
}

sub opti_exis_scal($) {
	my($opt_name)=@_;
	my($lopt)=lc($opt_name);
	return(exists($::xfer_opti{$lopt}));
}

sub opti_get_arra($$) {
	my($arra,$opt_name)=@_;

	# Check if there are options

	if(!exists($::xfer_opti_arra{$opt_name."::0"})) {
		modu::logx::diex("Required option array $opt_name not found\n");
	}
	#this is not the right way to write perl but its late,fix it !!
	my($i)=0;

	while(exists($::xfer_opti_arra{$opt_name."::".$i})) {
		$$arra[$i]=$::xfer_opti_arra{$opt_name."::".$i};
		$i++;
	}
}

1;

__END__

=head1 NAME

Meta::Utils::Opti - misc utility library for many functions.

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

	MANIFEST: Opti.pm
	PROJECT: meta
	VERSION: 0.25

=head1 SYNOPSIS

	package foo;
	use Meta::Utils::Opti qw();
	my($result)=Meta::Utils::Opti::opti_read_file([params]);

=head1 DESCRIPTION

This is yet another options library to help you read option files.
All of these need to merged someday...

=head1 FUNCTIONS

	opti_read_file($)
	opti_get_scal($)
	opti_exis_scal($)
	opti_get_arra($$)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<opti_read_file($)>

This will read an options file for you and store the values in RAM.

=item B<opti_get_scal($)>

This will get a scalar variable from the current options for you.

=item B<opti_exis_scal($)>

This will return a boolean value according to whether a specific scalar
exists in the options or not.

=item B<opti_get_arra($$)>

This will return an array from the options for you.

=back

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mark2776@yahoo.com
	WWW: http://www.geocities.com/mark2776
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV initial code brought in
	0.01 MV c++ and perl code quality checks
	0.02 MV more perl checks
	0.03 MV make Meta::Utils::Opts object oriented
	0.04 MV tests for Opts in every .pl
	0.05 MV check that all uses have qw
	0.06 MV fix todo items look in pod documentation
	0.07 MV more on tests/more checks to perl
	0.08 MV more perl code quality
	0.09 MV correct die usage
	0.10 MV perl code quality
	0.11 MV more perl quality
	0.12 MV more perl quality
	0.13 MV perl documentation
	0.14 MV more perl quality
	0.15 MV perl qulity code
	0.16 MV more perl code quality
	0.17 MV revision change
	0.18 MV languages.pl test online
	0.19 MV perl packaging
	0.20 MV md5 project
	0.21 MV database
	0.22 MV perl module versions in files
	0.23 MV movies and small fixes
	0.24 MV thumbnail user interface
	0.25 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

Nothing.
