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
du -b /tmp/line.out | cut -f1
du -b ./expected/line.out | cut -f1

test_output ./lines.rb
test_output diff -q /tmp/lines.out ./expected/lines.out
du -b /tmp/lines.out | cut -f1
du -b ./expected/lines.out | cut -f1

test_output ./lines_alignment.rb
test_output diff -q /tmp/lines_alignment.out ./expected/lines_alignment.out
du -b /tmp/lines_alignment.out | cut -f1
du -b ./expected/lines_alignment.out | cut -f1
