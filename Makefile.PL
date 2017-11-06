use 5.022001;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'Base64',
    VERSION_FROM      => 'lib/Base64.pm',
    PREREQ_PM         => {},
    ABSTRACT_FROM     => 'lib/Base64.pm',
    AUTHOR            => 'Luciano Dante Cecere <ldante1986@gmail.com>',
    LICENSE           => 'perl',
    dist	      => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    EXE_FILES	      => [ qw(bin/base64.pl) ],

);
