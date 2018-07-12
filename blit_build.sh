#!/bin/bash
set -e
# ./make_raw.py
vasmm68k_mot -kick1hunks -Fhunkexe -o blit_bad -I$HOME/other/retro/amiga/github/amiga-sdk/sdkinclude -I$HOME/own/retro/amiga/amiga_examples -nosym blit_bad.s

