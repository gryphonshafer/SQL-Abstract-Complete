#!/usr/bin/env perl
use Test::Most;

BEGIN { use_ok('SQL::Abstract::Complete') }
diag( "Testing SQL::Abstract::Complete $SQL::Abstract::Complete::VERSION, Perl $], $^X" );
done_testing();
