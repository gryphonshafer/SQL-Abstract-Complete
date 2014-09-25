#!/usr/bin/env perl
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    'NAME'             => 'SQL::Abstract::Complete',
    'AUTHOR'           => 'Gryphon Shafer <gryphon@cpan.org>',
    'VERSION_FROM'     => 'lib/SQL/Abstract/Complete.pm',
    'ABSTRACT_FROM'    => 'lib/SQL/Abstract/Complete.pm',
    'PL_FILES'         => {},
    'MIN_PERL_VERSION' => '5.010',
    'PREREQ_PM'        => {
        'SQL::Abstract' => 1.5,
        'Storable'      => 0,
        'Test::Most'    => 0,
    },
    'dist'  => { 'COMPRESS' => 'gzip -9f', 'SUFFIX' => 'gz' },
    'clean' => { 'FILES'    => 'SQL-Abstract-Complete-*' },
    ( $ExtUtils::MakeMaker::VERSION >= 6.3002 ? ( 'LICENSE' => 'perl' ) : () ),
    ( eval { ExtUtils::MakeMaker->VERSION(6.46) } ? ( 'META_MERGE' => {
        'meta-spec' => { version => 2 },
        'resources' => {
            'repository' => {
                'type' => 'git',
                'url'  => 'https://github.com/gryphonshafer/SQL-Abstract-Complete.git',
                'web'  => 'https://github.com/gryphonshafer/SQL-Abstract-Complete',
            },
        } } ) : ()
    ),
);
