#!/bin/bash
set -e
# ./make_raw.py
vasmm68k_mot -kick1hunks -Fhunkexe -o bpl -nosym bpl.s

