#!/bin/bash

# Notes:
# At the moment, the terminal must be set to width 135 x height 34 for
# these tests to pass.

# die on error
set -e

# change to directory that contains this script
cd "$(dirname "$0")"

# Issue regression tests
./342_streams.rb

# Integration tests
./dsl_app_001.rb
./dsl_app_002.rb
./dsl_app_003.rb
./dsl_app_004.rb
./dsl_app_005.rb
./dsl_app_006.rb
./dsl_app_007.rb
./dsl_app_008.rb
./dsl_app_009.rb
./dsl_app_010.rb
./dsl_app_011.rb
./dsl_app_012.rb
./dsl_app_013.rb
./dsl_app_014.rb
./dsl_app_015.rb
./dsl_app_016.rb
