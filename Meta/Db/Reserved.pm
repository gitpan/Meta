#!/bin/echo This is a perl module and should not be run

package Meta::Db::Reserved;

use strict qw(vars refs subs);

our($VERSION,@ISA);
$VERSION="0.04";
@ISA=qw();

#sub BEGIN();
#sub check($);
#sub make_sure($);
#sub TEST($);

#__DATA__

our(%hash);

sub BEGIN() {
	$hash{"ABS"};
	$hash{"ABSOLUTE"};
	$hash{"ACCESS"};
	$hash{"ACTION"};
	$hash{"ADA"};
	$hash{"ADD"};
	$hash{"ADMIN"};
	$hash{"AFTER"};
	$hash{"AGGREGATE"};
	$hash{"ALIAS"};
	$hash{"ALL"};
	$hash{"ALLOCATE"};
	$hash{"ALTER"};
	$hash{"ANALYSE"};
	$hash{"ANALYZE"};
	$hash{"AND"};
	$hash{"ANY"};
	$hash{"ARE"};
	$hash{"ARRAY"};
	$hash{"AS"};
	$hash{"ASC"};
	$hash{"ASENSITIVE"};
	$hash{"ASSERTION"};
	$hash{"ASSIGNMENT"};
	$hash{"ASYMMETRIC"};
	$hash{"AT"};
	$hash{"ATOMIC"};
	$hash{"AUTHORIZATION"};
	$hash{"AVG"};
	$hash{"BACKWARD"};
	$hash{"BEFORE"};
	$hash{"BEGIN"};
	$hash{"BETWEEN"};
	$hash{"BINARY"};
	$hash{"BIT"};
	$hash{"BITVAR"};
	$hash{"BIT_LENGTH"};
	$hash{"BLOB"};
	$hash{"BOOLEAN"};
	$hash{"BOTH"};
	$hash{"BREADTH"};
	$hash{"BY"};
	$hash{"C"};
	$hash{"CACHE"};
	$hash{"CALL"};
	$hash{"CALLED"};
	$hash{"CARDINALITY"};
	$hash{"CASCADE"};
	$hash{"CASCADED"};
	$hash{"CASE"};
	$hash{"CAST"};
	$hash{"CATALOG"};
	$hash{"CATALOG_NAME"};
	$hash{"CHAIN"};
	$hash{"CHAR"};
	$hash{"CHARACTER"};
	$hash{"CHARACTERISTICS"};
	$hash{"CHARACTER_LENGTH"};
	$hash{"CHARACTER_SET_CATALOG"};
	$hash{"CHARACTER_SET_NAME"};
	$hash{"CHARACTER_SET_SCHEMA"};
	$hash{"CHAR_LENGTH"};
	$hash{"CHECK"};
	$hash{"CHECKED"};
	$hash{"CHECKPOINT"};
	$hash{"CLASS"};
	$hash{"CLASS_ORIGIN"};
	$hash{"CLOB"};
	$hash{"CLOSE"};
	$hash{"CLUSTER"};
	$hash{"COALESCE"};
	$hash{"COBOL"};
	$hash{"COLLATE"};
	$hash{"COLLATION"};
	$hash{"COLLATION_CATALOG"};
	$hash{"COLLATION_NAME"};
	$hash{"COLLATION_SCHEMA"};
	$hash{"COLUMN"};
	$hash{"COLUMN_NAME"};
	$hash{"COMMAND_FUNCTION"};
	$hash{"COMMAND_FUNCTION_CODE"};
	$hash{"COMMENT"};
	$hash{"COMMIT"};
	$hash{"COMMITTED"};
	$hash{"COMPLETION"};
	$hash{"CONDITION_NUMBER"};
	$hash{"CONNECT"};
	$hash{"CONNECTION"};
	$hash{"CONNECTION_NAME"};
	$hash{"CONSTRAINT"};
	$hash{"CONSTRAINTS"};
	$hash{"CONSTRAINT_CATALOG"};
	$hash{"CONSTRAINT_NAME"};
	$hash{"CONSTRAINT_SCHEMA"};
	$hash{"CONSTRUCTOR"};
	$hash{"CONTAINS"};
	$hash{"CONTINUE"};
	$hash{"CONVERT"};
	$hash{"COPY"};
	$hash{"CORRESPONDING"};
	$hash{"COUNT"};
	$hash{"CREATE"};
	$hash{"CREATEDB"};
	$hash{"CREATEUSER"};
	$hash{"CROSS"};
	$hash{"CUBE"};
	$hash{"CURRENT"};
	$hash{"CURRENT_DATE"};
	$hash{"CURRENT_PATH"};
	$hash{"CURRENT_ROLE"};
	$hash{"CURRENT_TIME"};
	$hash{"CURRENT_TIMESTAMP"};
	$hash{"CURRENT_USER"};
	$hash{"CURSOR"};
	$hash{"CURSOR_NAME"};
	$hash{"CYCLE"};
	$hash{"DATA"};
	$hash{"DATABASE"};
	$hash{"DATE"};
	$hash{"DATETIME_INTERVAL_CODE"};
	$hash{"DATETIME_INTERVAL_PRECISION"};
	$hash{"DAY"};
	$hash{"DEALLOCATE"};
	$hash{"DEC"};
	$hash{"DECIMAL"};
	$hash{"DECLARE"};
	$hash{"DEFAULT"};
	$hash{"DEFERRABLE"};
	$hash{"DEFERRED"};
	$hash{"DEFINED"};
	$hash{"DEFINER"};
	$hash{"DELETE"};
	$hash{"DELIMITERS"};
	$hash{"DEPTH"};
	$hash{"DEREF"};
	$hash{"DESC"};
	$hash{"DESCRIBE"};
	$hash{"DESCRIPTOR"};
	$hash{"DESTROY"};
	$hash{"DESTRUCTOR"};
	$hash{"DETERMINISTIC"};
	$hash{"DIAGNOSTICS"};
	$hash{"DICTIONARY"};
	$hash{"DISCONNECT"};
	$hash{"DISPATCH"};
	$hash{"DISTINCT"};
	$hash{"DO"};
	$hash{"DOMAIN"};
	$hash{"DOUBLE"};
	$hash{"DROP"};
	$hash{"DYNAMIC"};
	$hash{"DYNAMIC_FUNCTION"};
	$hash{"DYNAMIC_FUNCTION_CODE"};
	$hash{"EACH"};
	$hash{"ELSE"};
	$hash{"ENCODING"};
	$hash{"END"};
	$hash{"END-EXEC"};
	$hash{"EQUALS"};
	$hash{"ESCAPE"};
	$hash{"EVERY"};
	$hash{"EXCEPT"};
	$hash{"EXCEPTION"};
	$hash{"EXCLUSIVE"};
	$hash{"EXEC"};
	$hash{"EXECUTE"};
	$hash{"EXISTING"};
	$hash{"EXISTS"};
	$hash{"EXPLAIN"};
	$hash{"EXTEND"};
	$hash{"EXTERNAL"};
	$hash{"EXTRACT"};
	$hash{"FALSE"};
	$hash{"FETCH"};
	$hash{"FINAL"};
	$hash{"FIRST"};
	$hash{"FLOAT"};
	$hash{"FOR"};
	$hash{"FORCE"};
	$hash{"FOREIGN"};
	$hash{"FORTRAN"};
	$hash{"FORWARD"};
	$hash{"FOUND"};
	$hash{"FREE"};
	$hash{"FROM"};
	$hash{"FULL"};
	$hash{"FUNCTION"};
	$hash{"G"};
	$hash{"GENERAL"};
	$hash{"GENERATED"};
	$hash{"GET"};
	$hash{"GLOBAL"};
	$hash{"GO"};
	$hash{"GOTO"};
	$hash{"GRANT"};
	$hash{"GRANTED"};
	$hash{"GROUP"};
	$hash{"GROUPING"};
	$hash{"HANDLER"};
	$hash{"HAVING"};
	$hash{"HIERARCHY"};
	$hash{"HOLD"};
	$hash{"HOST"};
	$hash{"HOUR"};
	$hash{"IDENTITY"};
	$hash{"IGNORE"};
	$hash{"ILIKE"};
	$hash{"IMMEDIATE"};
	$hash{"IMPLEMENTATION"};
	$hash{"IN"};
	$hash{"INCREMENT"};
	$hash{"INDEX"};
	$hash{"INDICATOR"};
	$hash{"INFIX"};
	$hash{"INHERITS"};
	$hash{"INITIALIZE"};
	$hash{"INITIALLY"};
	$hash{"INNER"};
	$hash{"INOUT"};
	$hash{"INPUT"};
	$hash{"INSENSITIVE"};
	$hash{"INSERT"};
	$hash{"INSTANCE"};
	$hash{"INSTANTIABLE"};
	$hash{"INSTEAD"};
	$hash{"INT"};
	$hash{"INTEGER"};
	$hash{"INTERSECT"};
	$hash{"INTERVAL"};
	$hash{"INTO"};
	$hash{"INVOKER"};
	$hash{"IS"};
	$hash{"ISNULL"};
	$hash{"ISOLATION"};
	$hash{"ITERATE"};
	$hash{"JOIN"};
	$hash{"K"};
	$hash{"KEY"};
	$hash{"KEY_MEMBER"};
	$hash{"KEY_TYPE"};
	$hash{"LANCOMPILER"};
	$hash{"LANGUAGE"};
	$hash{"LARGE"};
	$hash{"LAST"};
	$hash{"LATERAL"};
	$hash{"LEADING"};
	$hash{"LEFT"};
	$hash{"LENGTH"};
	$hash{"LESS"};
	$hash{"LEVEL"};
	$hash{"LIKE"};
	$hash{"LIMIT"};
	$hash{"LISTEN"};
	$hash{"LOAD"};
	$hash{"LOCAL"};
	$hash{"LOCALTIME"};
	$hash{"LOCALTIMESTAMP"};
	$hash{"LOCATION"};
	$hash{"LOCATOR"};
	$hash{"LOCK"};
	$hash{"LOWER"};
	$hash{"M"};
	$hash{"MAP"};
	$hash{"MATCH"};
	$hash{"MAX"};
	$hash{"MAXVALUE"};
	$hash{"MESSAGE_LENGTH"};
	$hash{"MESSAGE_OCTET_LENGTH"};
	$hash{"MESSAGE_TEXT"};
	$hash{"METHOD"};
	$hash{"MIN"};
	$hash{"MINUTE"};
	$hash{"MINVALUE"};
	$hash{"MOD"};
	$hash{"MODE"};
	$hash{"MODIFIES"};
	$hash{"MODIFY"};
	$hash{"MODULE"};
	$hash{"MONTH"};
	$hash{"MORE"};
	$hash{"MOVE"};
	$hash{"MUMPS"};
	$hash{"NAME"};
	$hash{"NAMES"};
	$hash{"NATIONAL"};
	$hash{"NATURAL"};
	$hash{"NCHAR"};
	$hash{"NCLOB"};
	$hash{"NEW"};
	$hash{"NEXT"};
	$hash{"NO"};
	$hash{"NOCREATEDB"};
	$hash{"NOCREATEUSER"};
	$hash{"NONE"};
	$hash{"NOT"};
	$hash{"NOTHING"};
	$hash{"NOTIFY"};
	$hash{"NOTNULL"};
	$hash{"NULL"};
	$hash{"NULLABLE"};
	$hash{"NULLIF"};
	$hash{"NUMBER"};
	$hash{"NUMERIC"};
	$hash{"OBJECT"};
	$hash{"OCTET_LENGTH"};
	$hash{"OF"};
	$hash{"OFF"};
	$hash{"OFFSET"};
	$hash{"OIDS"};
	$hash{"OLD"};
	$hash{"ON"};
	$hash{"ONLY"};
	$hash{"OPEN"};
	$hash{"OPERATION"};
	$hash{"OPERATOR"};
	$hash{"OPTION"};
	$hash{"OPTIONS"};
	$hash{"OR"};
	$hash{"ORDER"};
	$hash{"ORDINALITY"};
	$hash{"OUT"};
	$hash{"OUTER"};
	$hash{"OUTPUT"};
	$hash{"OVERLAPS"};
	$hash{"OVERLAY"};
	$hash{"OVERRIDING"};
	$hash{"OWNER"};
	$hash{"PAD"};
	$hash{"PARAMETER"};
	$hash{"PARAMETERS"};
	$hash{"PARAMETER_MODE"};
	$hash{"PARAMETER_NAME"};
	$hash{"PARAMETER_ORDINAL_POSITION"};
	$hash{"PARAMETER_SPECIFIC_CATALOG"};
	$hash{"PARAMETER_SPECIFIC_NAME"};
	$hash{"PARAMETER_SPECIFIC_SCHEMA"};
	$hash{"PARTIAL"};
	$hash{"PASCAL"};
	$hash{"PASSWORD"};
	$hash{"PATH"};
	$hash{"PENDANT"};
	$hash{"PLI"};
	$hash{"POSITION"};
	$hash{"POSTFIX"};
	$hash{"PRECISION"};
	$hash{"PREFIX"};
	$hash{"PREORDER"};
	$hash{"PREPARE"};
	$hash{"PRESERVE"};
	$hash{"PRIMARY"};
	$hash{"PRIOR"};
	$hash{"PRIVILEGES"};
	$hash{"PROCEDURAL"};
	$hash{"PROCEDURE"};
	$hash{"PUBLIC"};
	$hash{"READ"};
	$hash{"READS"};
	$hash{"REAL"};
	$hash{"RECURSIVE"};
	$hash{"REF"};
	$hash{"REFERENCES"};
	$hash{"REFERENCING"};
	$hash{"REINDEX"};
	$hash{"RELATIVE"};
	$hash{"RENAME"};
	$hash{"REPEATABLE"};
	$hash{"RESET"};
	$hash{"RESTRICT"};
	$hash{"RESULT"};
	$hash{"RETURN"};
	$hash{"RETURNED_LENGTH"};
	$hash{"RETURNED_OCTET_LENGTH"};
	$hash{"RETURNED_SQLSTATE"};
	$hash{"RETURNS"};
	$hash{"REVOKE"};
	$hash{"RIGHT"};
	$hash{"ROLE"};
	$hash{"ROLLBACK"};
	$hash{"ROLLUP"};
	$hash{"ROUTINE"};
	$hash{"ROUTINE_CATALOG"};
	$hash{"ROUTINE_NAME"};
	$hash{"ROUTINE_SCHEMA"};
	$hash{"ROW"};
	$hash{"ROWS"};
	$hash{"ROW_COUNT"};
	$hash{"RULE"};
	$hash{"SAVEPOINT"};
	$hash{"SCALE"};
	$hash{"SCHEMA"};
	$hash{"SCHEMA_NAME"};
	$hash{"SCOPE"};
	$hash{"SCROLL"};
	$hash{"SEARCH"};
	$hash{"SECOND"};
	$hash{"SECTION"};
	$hash{"SECURITY"};
	$hash{"SELECT"};
	$hash{"SELF"};
	$hash{"SENSITIVE"};
	$hash{"SEQUENCE"};
	$hash{"SERIAL"};
	$hash{"SERIALIZABLE"};
	$hash{"SERVER_NAME"};
	$hash{"SESSION"};
	$hash{"SESSION_USER"};
	$hash{"SET"};
	$hash{"SETOF"};
	$hash{"SETS"};
	$hash{"SHARE"};
	$hash{"SHOW"};
	$hash{"SIMILAR"};
	$hash{"SIMPLE"};
	$hash{"SIZE"};
	$hash{"SMALLINT"};
	$hash{"SOME"};
	$hash{"SOURCE"};
	$hash{"SPACE"};
	$hash{"SPECIFIC"};
	$hash{"SPECIFICTYPE"};
	$hash{"SPECIFIC_NAME"};
	$hash{"SQL"};
	$hash{"SQLCODE"};
	$hash{"SQLERROR"};
	$hash{"SQLEXCEPTION"};
	$hash{"SQLSTATE"};
	$hash{"SQLWARNING"};
	$hash{"START"};
	$hash{"STATE"};
	$hash{"STATEMENT"};
	$hash{"STATIC"};
	$hash{"STDIN"};
	$hash{"STDOUT"};
	$hash{"STRUCTURE"};
	$hash{"STYLE"};
	$hash{"SUBCLASS_ORIGIN"};
	$hash{"SUBLIST"};
	$hash{"SUBSTRING"};
	$hash{"SUM"};
	$hash{"SYMMETRIC"};
	$hash{"SYSID"};
	$hash{"SYSTEM"};
	$hash{"SYSTEM_USER"};
	$hash{"TABLE"};
	$hash{"TABLE_NAME"};
	$hash{"TEMP"};
	$hash{"TEMPLATE"};
	$hash{"TEMPORARY"};
	$hash{"TERMINATE"};
	$hash{"THAN"};
	$hash{"THEN"};
	$hash{"TIME"};
	$hash{"TIMESTAMP"};
	$hash{"TIMEZONE_HOUR"};
	$hash{"TIMEZONE_MINUTE"};
	$hash{"TO"};
	$hash{"TOAST"};
	$hash{"TRAILING"};
	$hash{"TRANSACTION"};
	$hash{"TRANSACTIONS_COMMITTED"};
	$hash{"TRANSACTIONS_ROLLED_BACK"};
	$hash{"TRANSACTION_ACTIVE"};
	$hash{"TRANSFORM"};
	$hash{"TRANSFORMS"};
	$hash{"TRANSLATE"};
	$hash{"TRANSLATION"};
	$hash{"TREAT"};
	$hash{"TRIGGER"};
	$hash{"TRIGGER_CATALOG"};
	$hash{"TRIGGER_NAME"};
	$hash{"TRIGGER_SCHEMA"};
	$hash{"TRIM"};
	$hash{"TRUE"};
	$hash{"TRUNCATE"};
	$hash{"TRUSTED"};
	$hash{"TYPE"};
	$hash{"UNCOMMITTED"};
	$hash{"UNDER"};
	$hash{"UNION"};
	$hash{"UNIQUE"};
	$hash{"UNKNOWN"};
	$hash{"UNLISTEN"};
	$hash{"UNNAMED"};
	$hash{"UNNEST"};
	$hash{"UNTIL"};
	$hash{"UPDATE"};
	$hash{"UPPER"};
	$hash{"USAGE"};
	$hash{"USER"};
	$hash{"USER_DEFINED_TYPE_CATALOG"};
	$hash{"USER_DEFINED_TYPE_NAME"};
	$hash{"USER_DEFINED_TYPE_SCHEMA"};
	$hash{"USING"};
	$hash{"VACUUM"};
	$hash{"VALID"};
	$hash{"VALUE"};
	$hash{"VALUES"};
	$hash{"VARCHAR"};
	$hash{"VARIABLE"};
	$hash{"VARYING"};
	$hash{"VERBOSE"};
	$hash{"VERSION"};
	$hash{"VIEW"};
	$hash{"WHEN"};
	$hash{"WHENEVER"};
	$hash{"WHERE"};
	$hash{"WITH"};
	$hash{"WITHOUT"};
	$hash{"WORK"};
	$hash{"WRITE"};
	$hash{"YEAR"};
	$hash{"ZONE"};
}

sub check($) {
	my($word)=@_;
	if($word=~/\s/) {
		return(0);
	}
	#turn it to upcase and check in the hash
	return(1);
}

sub make_sure($) {
	my($word)=@_;
	if(!check($word)) {
		Meta::Utils::System::die("word [".$word."] is an SQL reserved word");
	}
}

sub TEST($) {
	my($context)=@_;
	return(1);
}

1;

__END__

=head1 NAME

Meta::Db::Reserved - checks for db related reserved words.

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

	MANIFEST: Reserved.pm
	PROJECT: meta
	VERSION: 0.04

=head1 SYNOPSIS

	package foo;
	use Meta::Db::Reserved qw();
	my($result)=Meta::Db::Reserved::check("SELECTED");
	or
	Meta::Db::Reserved::make_sure("SELECTORS");

=head1 DESCRIPTION

This class is here to help you make sure that things like
database names, table names and field names are such that
databases will not have problems with them. For instance
if you call your table SELECT you can bet your life the
database will kick you out of the room. But other - more
subtle things exist. For instance - imagine that db vendor
A has a builtin function "calculate" and db vendor B
hasn't got it. You start your application using vendor B's
database and write lots of code where one of your tables
is called "calculate". Later you are required to migrate
to vendor A and the database refuses to analyze your SQL
statements because of the reserved name. Wouldn't it be
nice if you got an error about it from your development
environment right from the start ?

This is what this module is here to do. I will collect
the reserved words of many database vendors in here and
force you to select names which will be ok across all
db vendors.

The list of reserved words currently contains:
1. PostgreSQL reserved words out of the PostgreSQL
documentation.
2. MySQL reserved words out of the MySQL documentation

You are most welcome to contribute patches with lists
of words from other DB vendors (Oracle, SYBASE, DB2).

This is a tag placed in this module for source control
reasons (don't ask): SPECIAL STDERR FILE

=head1 FUNCTIONS

	BEGIN()
	check($)
	make_sure($)
	TEST($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<BEGIN()>

This is an initialization method which sets up the hash
table of all the reserved words.

This is a constructor for the Meta::Db::Reserved object.

=item B<check($)>

This method will return an error code (0) if the word
given to it is a reserved word.

=item B<make_sure($)>

This method will make sure (raise an exception if not)
that a certain word is not reserved.

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

	0.00 MV import tests
	0.01 MV more thumbnail issues
	0.02 MV website construction
	0.03 MV web site automation
	0.04 MV SEE ALSO section fix

=head1 SEE ALSO

strict(3)

=head1 TODO

-add sets of words and ability to select which sets to work with. do the sets according to the PostgreSQL documentation (postgress, SQL 92, SQL 99).

-make the general functionality (of reserved words and sets of words) in a papa class.

-make this class use a proper Set class and not a perl hash.

-make this class read everything from an XML files.
