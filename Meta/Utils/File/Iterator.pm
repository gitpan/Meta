#!/bin/echo This is a perl module and should not be run

package Meta::Utils::File::Iterator;

use strict qw(vars refs subs);
use Meta::Class::MethodMaker qw();
use Meta::Ds::Stack qw();

our($VERSION,@ISA);
$VERSION="0.14";
@ISA=qw();

#sub BEGIN();
#sub init($);
#sub add_directory($$);
#sub start($);
#sub next($);
#sub fini($);
#sub TEST($);

#__DATA__

sub BEGIN() {
	Meta::Class::MethodMaker->new_with_init("new");
	Meta::Class::MethodMaker->get_set(
		-java=>"_want_files",
		-java=>"_want_dirs",
		-java=>"_curr",
		-java=>"_over",
	);
}

sub init($) {
	my($self)=@_;
	$self->set_want_files(1);
	$self->set_want_dirs(0);
	$self->{STACK_DIR}=Meta::Ds::Stack->new();
	$self->{STACK_FILE}=Meta::Ds::Stack->new();
}

sub add_directory($$) {
	my($self,$valx)=@_;
	$self->{STACK_DIR}->push($valx);
}

sub start($) {
	my($self)=@_;
	$self->set_over(0);
	$self->next();
}

sub next($) {
	my($self)=@_;
	my($stack_file)=$self->{STACK_FILE};
	my($stack_dir)=$self->{STACK_DIR};
	if($stack_file->empty()) {#need to get more files
		my($stop)=0;
		while($stack_dir->notempty() && !$stop) {
			my($dire)=$stack_dir->pop();
			#Meta::Utils::Output::print("doing [".$dire."]\n");
			opendir(DIR,$dire) || Meta::Utils::System::die("unable to open directory [".$dire."]");
			my($file);
			while(defined($file=readdir(DIR))) {
				my($curr)=$dire."/".$file;
				if(-d $curr) {
					if($file ne "." && $file ne "..") {
						$stack_dir->push($curr);
						if($self->get_want_dirs()) {
							if(!$stop) {
								$self->set_curr($curr);
								$stop=1;
							}
						}
					}
				}
				if(-f $curr) {
					if($self->get_want_files()) {
						if(!$stop) {
							$self->set_curr($curr);
							$stop=1;
						} else {
							$stack_file->push($curr);
						}
					}
				}
			}
			closedir(DIR) || Meta::Utils::System::die("unable to close directory [".$dire."]");
		}
		if(!$stop) {#its all over
			$self->set_over(1);
		}
	} else {
		$self->set_curr($stack_file->pop());
	}
}

sub fini($) {
	my($self)=@_;
	$self->set_over(0);
	#emtpy the stacks here
}

sub TEST($) {
	my($context)=@_;
	return(1);
}

1;

__END__

=head1 NAME

Meta::Utils::File::Iterator - iterate files in directories.

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

	MANIFEST: Iterator.pm
	PROJECT: meta
	VERSION: 0.14

=head1 SYNOPSIS

	package foo;
	use Meta::Utils::File::Iterator qw();
	my($iterator)=Meta::Utils::File::Iterator->new();
	$iterator->add_directory("/home/mark");
	$iterator->start();
	while(!$iterator->get_over()) {
		print $iterator->get_curr()."\n";
		$iterator->next();
	}
	$iterator->fini();

=head1 DESCRIPTION

This is an iterator object which allows you to streamline work which
has to do with recursing subdirs. Give this object a subdir to
recurse and it will give you the next file to work on whenever you
ask it to. The reason this method is more streamlined is that you
dont need to know anything about iterating file systems and still
you dont get all the filenames that you will be working on in RAM
at the same time. Lets say that you're working on 100,000 files
(which is more than the number of arguments that you can give
to a utility program on a UNIX system by default...). How will you
work on it ? If you want to get the filenames on the command line
you have to use something like xargs which is an ugly hack since
it runs your utility way too many times (one time for each file).
If you don't want the xargs overhead then what you want is to
put the iterator in your source. Again, two methods are available.
Either you scan the file system and produce a list of the files
which you will be working on. This means that the RAM that your
program will take will be proportional to the number of files
you will be working on (and since you may not need knowledge
of all of them at the same time and you may even need them
one at a time with no relation to the others) - this is quite
a ram load. The other method is the method presented here:
use this iterator.

This iterator can give you directory names or just the files.
The default behaviour is to iterate just the files.

=head1 FUNCTIONS

	BEGIN()
	init($)
	add_directory($)
	start($)
	next($)
	fini($)
	TEST($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<BEGIN()>

This method creates the accessor methods for the following attributes:
"want_files", "want_dirs", "curr", "over".

=item B<init($)>

This is an internal post-constructor.

=item B<add_directory($$)>

This method will set the directory that this iterator will
scan. Right now, if you add the same directory with different
names, it will get iteraterd twice. This is on the todo list.

=item B<start($)>

This will initialize the iterator. After that you can
start calling get_over in a loop and in the loop use
get_curr and next.

=item B<next($)>

This method iterates to the next value. You need to check
if there are more entries to iterate using the "get_over"
method after using this one.

=item B<fini($)>

This method wraps the iterator up (does various cleanup).
You're not obliged to call this one but for future purposes
you better...:)

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

	0.00 MV more perl packaging
	0.01 MV PDMT
	0.02 MV md5 project
	0.03 MV database
	0.04 MV perl module versions in files
	0.05 MV movies and small fixes
	0.06 MV movie stuff
	0.07 MV graph visualization
	0.08 MV more thumbnail stuff
	0.09 MV thumbnail user interface
	0.10 MV more thumbnail issues
	0.11 MV website construction
	0.12 MV web site development
	0.13 MV web site automation
	0.14 MV SEE ALSO section fix

=head1 SEE ALSO

Meta::Class::MethodMaker(3), Meta::Ds::Stack(3), strict(3)

=head1 TODO

-enable breadth vs depth first search.

-enable different options for filtering which files get delivered (suffixes, regexps, types etc...).

-enable receiving directories too.

-when doing add_directory translate it to cannonical form and add it to a HashStack which will only keep distinct values.
