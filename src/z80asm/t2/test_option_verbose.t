#!/usr/bin/perl

#------------------------------------------------------------------------------
# z80asm tests
# Copyright (C) Paulo Custodio, 2011-2020
# License: The Artistic License 2.0, http://www.perlfoundation.org/artistic_license_2_0
#------------------------------------------------------------------------------
use Modern::Perl;
BEGIN { use lib 't2'; use testlib; }

my $test = test_name();
my $bin;

write_file("$test.asm", <<END);
	nop
END

unlink "$test.bin";
run_ok("z80asm -b $test.asm", '', '');
$bin = path("$test.bin")->slurp_raw();
ok $bin eq  "\x00", "bin ok";

unlink "$test.bin";
run_ok("z80asm -b -v $test.asm", <<"OUT", '');
z80asm command line: z80asm -b -v test_option_verbose.asm
Reading library 'z80asm-z80-.lib'
Predefined constant: __CPU_Z80__ = \$0001
Predefined constant: __CPU_ZILOG__ = \$0001
Assembling '$test.i' to '$test.o'
Reading '$test.i' = '$test.i'
Writing object file '$test.o'
Module '$test' size: 1 bytes

Code size: 1 bytes (\$0000 to \$0000)
Creating binary '$test.bin'
OUT
$bin = path("$test.bin")->slurp_raw();
ok $bin eq  "\x00", "bin ok";

for my $illegal (qw( -vx --vx -v=1 )) {
	run_nok("z80asm -b $illegal $test.asm", '', <<"ERR");
error: illegal option: $illegal
ERR
}

end_test();
