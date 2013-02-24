#!perl -T
use Test::More tests => 1;

BEGIN {
    use_ok( 'SQL::Abstract::Complete' ) || print "Bail out!\n";
}

diag( "Testing SQL::Abstract::Complete $SQL::Abstract::Complete::VERSION, Perl $], $^X" );
