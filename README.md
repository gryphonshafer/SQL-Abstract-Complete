# NAME

SQL::Abstract::Complete - Generate complete SQL from Perl data structures

# VERSION

version 1.10

[![test](https://github.com/gryphonshafer/SQL-Abstract-Complete/workflows/test/badge.svg)](https://github.com/gryphonshafer/SQL-Abstract-Complete/actions?query=workflow%3Atest)
[![codecov](https://codecov.io/gh/gryphonshafer/SQL-Abstract-Complete/graph/badge.svg)](https://codecov.io/gh/gryphonshafer/SQL-Abstract-Complete)

# SYNOPSIS

    use SQL::Abstract::Complete;

    my $sac = SQL::Abstract::Complete->new;

    my ( $sql, @bind ) = $sac->select(
        \@tables, # a table or set of tables and optional aliases
        \@fields, # fields and optional aliases to fetch
        \%where,  # where clause
        \%other,  # order by, group by, having, and pagination
    );

# DESCRIPTION

This module was inspired by the excellent [SQL::Abstract](https://metacpan.org/pod/SQL%3A%3AAbstract), from which in
inherits. However, in trying to use the module, I found that what I really
wanted to do was generate complete SELECT statements including joins and group
by clauses. So, I set out to create a more complete abstract SQL generation
module. (To be fair, [SQL::Abstract](https://metacpan.org/pod/SQL%3A%3AAbstract) kept it's first `$table` argument
inflexible for backwards compatibility reasons.)

This module only changes the select() method and adds a small new wrinkle to
new(). Everything else from [SQL::Abstract](https://metacpan.org/pod/SQL%3A%3AAbstract) is inheritted as-is. Consequently,
you should read the [SQL::Abstract](https://metacpan.org/pod/SQL%3A%3AAbstract) documentation before continuing.

# FUNCTIONS

## new( 'option' => 'value' )

The `new()` function takes a list of options and values, and returns
a new **SQL::Abstract::Complete** object which can then be used to generate SQL.
This function operates in exactly the same way as the same from [SQL::Abstract](https://metacpan.org/pod/SQL%3A%3AAbstract)
only it offers one additional option to set:

- part\_join

    This is the value that the SELECT statement components will be concatinated
    together with. By default, this is set to a single space, meaning the returned
    SQL will be all on one line. Setting this to something like `"\n"` would make
    for slightly more human-readable SQL, depending on the human.

## select( \\@tables, \\@fields, \\%where, \\%other )

This returns a SQL SELECT statement and associated list of bind values, as
specified by the arguments:

- \\@tables

    This is a list of tables, optional aliases, and ways to join any multiple
    tables. The first table will be used as the "FROM" part of the statement.
    Subsequent tables will be assumed to be joined by use of an inner join unless
    otherwise specified.

    There are several ways to specify tables, joins, and their respective aliases:

        # SELECT * FROM alpha
        my ( $sql, @bind ) = $sac->select('alpha');
        my ( $sql, @bind ) = $sac->select( ['alpha'] );

        # SELECT * FROM alpha AS a
        ( $sql, @bind ) = $sac->select( \q(FROM alpha AS a) );
        ( $sql, @bind ) = $sac->select( [ \q(FROM alpha AS a) ] );

        # SELECT * FROM alpha AS a JOIN beta AS b USING(id)
        $sac->select(
            [
                [ [ qw( alpha a ) ]       ],
                [ [ qw( beta  b ) ], 'id' ],
            ],
        );
        $sac->select(
            [
                [ [ qw( alpha a ) ] ],
                [ { 'beta' => 'b' }, 'id' ],
            ],
        );

        # SELECT *
        # FROM alpha AS a
        # JOIN beta AS b USING(id)
        # LEFT JOIN something AS s USING(whatever)
        # LEFT JOIN omega AS o USING(last_id)
        # LEFT JOIN stuff AS t ON t.thing_id = b.thing_id
        # LEFT JOIN pi AS p USING(number_id)
        $sac->select(
            [
                [ [ qw( alpha a ) ] ],
                [ { 'beta' => 'b' }, 'id' ],
                \q{ LEFT JOIN something AS s USING(whatever) },
                [ \q{ LEFT JOIN }, { 'omega', 'o' }, 'last_id' ],
                [
                    \q{ LEFT JOIN },
                    { 'stuff' => 't' },
                    \q{ ON t.thing_id = b.thing_id },
                ],
                [
                    [ qw( pi p ) ],
                    {
                        'join'  => 'left',
                        'using' => 'number_id',
                    },
                ],
            ],
        );

- \\@fields

    This is a list of the fields (along with optional aliases) to return.
    There are several ways to specify fields and their respective aliases:

        # SELECT one, two, three FROM table
        $sac->select(
            'table',
            [ qw( one two three ) ],
        );

        # SELECT one, IF( two > 10, 1, 0 ) AS two_bool, three AS col_three
        # FROM table
        $sac->select(
            'table',
            [
                'one',
                \q{ IF( two > 10, 1, 0 ) AS two_bool },
                { 'three' => 'col_three' },
            ],
        );

    If this input is undefined, it will be interpretted as `[*]`; and if this
    input is a scalar string, it will be interpretted as that string in an arrayref.

- \\%where

    This is an optional argument to specify the WHERE clause of the query.
    The argument is most often a hashref. This functionality is entirely
    inheritted from [SQL::Abstract](https://metacpan.org/pod/SQL%3A%3AAbstract), so read that fine module's documentation
    for WHERE details.

- \\%other

    This optional argument is where you can specify items like order by, group by,
    and having clauses. You can also stipulate pagination of results.

        # SELECT one
        # FROM table
        # GROUP BY two
        # HAVING ( MAX(three) > ? )
        # ORDER BY one, four DESC, five
        # LIMIT 10, 5
        $sac->select(
            'table',
            ['one'],
            undef,
            {
                'group_by' => 'two',
                'having'   => [ { 'MAX(three)' => { '>' => 9 } } ],
                'order_by' => [ 'one', { '-desc' => 'four' }, 'five' ],
                'rows'     => 5,
                'page'     => 3,
            },
        );

    The HAVING clause works in the same way as the WHERE clause handling
    from [SQL::Abstract](https://metacpan.org/pod/SQL%3A%3AAbstract). (In fact, we're actually calling the same method
    from the parent class.) ORDER BY clause handling is also purely inheritted
    from [SQL::Abstract](https://metacpan.org/pod/SQL%3A%3AAbstract). The "rows" and "page" pagination functionality is
    inspired from [DBIx::Class](https://metacpan.org/pod/DBIx%3A%3AClass) and operates the same way. Alternatively, you can
    explicitly set a "limit" value.

# SEE ALSO

[SQL::Abstract](https://metacpan.org/pod/SQL%3A%3AAbstract), [DBIx::Class](https://metacpan.org/pod/DBIx%3A%3AClass), [DBIx::Abstract](https://metacpan.org/pod/DBIx%3A%3AAbstract).

You can also look for additional information at:

- [GitHub](https://github.com/gryphonshafer/SQL-Abstract-Complete)
- [MetaCPAN](https://metacpan.org/pod/SQL::Abstract::Complete)
- [GitHub Actions](https://github.com/gryphonshafer/SQL-Abstract-Complete/actions)
- [Codecov](https://codecov.io/gh/gryphonshafer/SQL-Abstract-Complete)
- [CPANTS](http://cpants.cpanauthors.org/dist/SQL-Abstract-Complete)
- [CPAN Testers](http://www.cpantesters.org/distro/S/SQL-Abstract-Complete.html)

# AUTHOR

Gryphon Shafer <gryphon@cpan.org>

# COPYRIGHT AND LICENSE

This software is Copyright (c) 2013-2050 by Gryphon Shafer.

This is free software, licensed under:

    The Artistic License 2.0 (GPL Compatible)
