#!/bin/bash
set -e
echo "example"
vasmm68k_mot -kick1hunks -Fhunkexe -o ex -nosym example.s
echo ""
echo "bpl"
vasmm68k_mot -kick1hunks -Fhunkexe -o bpl -nosym bpl.s
echo ""
echo "bpl copper"
vasmm68k_mot -kick1hunks -Fhunkexe -o bplc -nosym bpl_copper.s
echo ""
echo "blit"
vasmm68k_mot -kick1hunks -Fhunkexe -o blit -nosym blit.s

