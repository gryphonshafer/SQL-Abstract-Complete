# SQL::Abstract::Complete - Generate complete SQL from Perl data structures

This module was inspired by the excellent SQL::Abstract, from which in
inherits. However, in trying to use the module, I found that what I really
wanted to do was generate complete SELECT statements including joins and group
by clauses. So, I set out to create a more complete abstract SQL generation
module. (To be fair, SQL::Abstract kept it's first $table argument
inflexible for backwards compatibility reasons.)

[![Build Status](https://travis-ci.org/gryphonshafer/SQL-Abstract-Complete.svg)](https://travis-ci.org/gryphonshafer/SQL-Abstract-Complete)
[![Coverage Status](https://coveralls.io/repos/gryphonshafer/SQL-Abstract-Complete/badge.png)](https://coveralls.io/r/gryphonshafer/SQL-Abstract-Complete)

This module only changes the select() method and adds a small new wrinkle to
new(). Everything else from SQL::Abstract is inheritted as-is. Consequently,
you should read the SQL::Abstract documentation before continuing.

## Installation

To install this module, run the following commands:

    perl Makefile.PL
    make
    make test
    make install

## Support and Documentation

After installing, you can find documentation for this module with the
perldoc command.

    perldoc SQL::Abstract::Complete

You can also look for information at:

- [GitHub](https://github.com/gryphonshafer/SQL-Abstract-Complete "GitHub")
- [AnnoCPAN](http://annocpan.org/dist/SQL-Abstract-Complete "AnnoCPAN")
- [CPAN Ratings](http://cpanratings.perl.org/m/SQL-Abstract-Complete "CPAN Ratings")
- [Search CPAN](http://search.cpan.org/dist/SQL-Abstract-Complete "Search CPAN")

## Author and License

Gryphon Shafer, [gryphon@cpan.org](mailto:gryphon@cpan.org "Email Gryphon Shafer")

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.
