#!/usr/bin/perl

#     ZZZZZZZZZZZZZZZZZZZZ    8888888888888       00000000000
#   ZZZZZZZZZZZZZZZZZZZZ    88888888888888888    0000000000000
#                ZZZZZ      888           888  0000         0000
#              ZZZZZ        88888888888888888  0000         0000
#            ZZZZZ            8888888888888    0000         0000       AAAAAA         SSSSSSSSSSS   MMMM       MMMM
#          ZZZZZ            88888888888888888  0000         0000      AAAAAAAA      SSSS            MMMMMM   MMMMMM
#        ZZZZZ              8888         8888  0000         0000     AAAA  AAAA     SSSSSSSSSSS     MMMMMMMMMMMMMMM
#      ZZZZZ                8888         8888  0000         0000    AAAAAAAAAAAA      SSSSSSSSSSS   MMMM MMMMM MMMM
#    ZZZZZZZZZZZZZZZZZZZZZ  88888888888888888    0000000000000     AAAA      AAAA           SSSSS   MMMM       MMMM
#  ZZZZZZZZZZZZZZZZZZZZZ      8888888888888       00000000000     AAAA        AAAA  SSSSSSSSSSS     MMMM       MMMM
#
# Copyright (C) Paulo Custodio, 2011-2014
#
# Preprocess scan_def.h and generate scan_tokens.h with #define macros for each token ID
# Needed to communicate scanner tokens to the parser
#
# $Header: /home/dom/z88dk-git/cvs/z88dk/src/z80asm/dev/Attic/build_tokens.pl,v 1.3 2015-01-11 23:49:25 pauloscustodio Exp $

use strict;
use warnings;

my $FILE = "scan_tokens";

open(my $out, ">", "$FILE.c") or die "Output to $FILE.c failed: $!\n";
print $out <<"END";
#include "legacy.h"

#define TOKEN_RE(name, string, regexp, set_value)	name		string
#define TOKEN(name, string, set_value)				name		string
#define TOKEN2(name, string, set_value)
#define TOKEN_OPCODE(name)							TK_##name	#name

#include "scan_def.h"

END
close($out) or die;

open($out, ">", "$FILE.h") or die "Output to $FILE.h failed: $!\n";
print $out <<"END";
/* generated by $0 */
#pragma once

/* Scan token IDs */
END

open(my $in, "cc -E $FILE.c |") or die "Input from cc -E failed: $!\n";
my @names; my @strings;
my $max_name = 1; my $max_string = 1;

while (<$in>) {
	next unless /^\s*(\w+)\s+(.*)/;
	push @names, $1;
	$max_name = length($1) if length($1) > $max_name;
	
	push @strings, $2;
	$max_string = length($2) if length($2) > $max_string;
}

for (0 .. $#names) {
	print $out sprintf("#define _%-*s %5d    /* %-*s */\n", 
					   $max_name, $names[$_],
					   $_,
					   $max_string, $strings[$_]);
}
print $out <<"END";

#ifndef NO_TOKEN_ENUM

/* Scan token enum */
typedef enum tokid_t
{
END
for (0 .. $#names) {
	print $out sprintf("    %-*s = _%-*s,    /* = %5d, %-*s */\n", 
					   $max_name, $names[$_],
					   $max_name, $names[$_],
					   $_,
					   $max_string, $strings[$_]);
}
print $out <<"END";
} tokid_t;

#endif

END

close($in) or die "cc -E failed: $!\n";

close($out) or die;

unlink("$FILE.c");
