use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'SQL::Abstract::Complete',
    AUTHOR              => q{Gryphon Shafer <gryphon@cpan.org>},
    VERSION_FROM        => 'lib/SQL/Abstract/Complete.pm',
    ABSTRACT_FROM       => 'lib/SQL/Abstract/Complete.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More'    => 0,
        'SQL::Abstract' => 1.5,
        'Storable'      => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'SQL-Abstract-Complete-*' },
);
