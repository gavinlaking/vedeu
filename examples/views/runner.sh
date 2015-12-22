#!/bin/bash

set -e

function test_output() {
  "$@"
  local status=$?
  if [ $status -ne 0 ]; then
    echo "Error with $1" >&2
  fi
  return $status
}

test_output ./line.rb
test_output diff -q /tmp/line.out ./expected/line.out

test_output ./lines.rb
test_output diff -q /tmp/lines.out ./expected/lines.out

test_output ./lines_alignment.rb
test_output diff -q /tmp/lines_alignment.out ./expected/lines_alignment.out
