#!/bin/bash
set -e
vasmm68k_mot -kick1hunks -Fhunkexe -o bpl -nosym bpl.s
vasmm68k_mot -kick1hunks -Fhunkexe -o bpl_copper -nosym bpl_copper.s
vasmm68k_mot -kick1hunks -Fhunkexe -o ex -nosym source.asm

