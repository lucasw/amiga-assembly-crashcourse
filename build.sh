#!/bin/bash
set -e
rm -f example
./make_raw.py
vasmm68k_mot -kick1hunks -Fhunkexe -o example -nosym source.asm

