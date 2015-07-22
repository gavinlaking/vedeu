#!/bin/bash

# Displays the number of lines of Vedeu application code and the corresponding
# number of lines of Vedeu test code per commit.

set -e

function main {
  for rev in `revisions`; do
    echo "`number_of_lines ^lib` `number_of_lines ^test` `commit_description`"
  done
}

function revisions {
  git rev-list --reverse HEAD
}

function commit_description {
  git log --oneline -1 $rev
}

function number_of_lines () {
  git ls-tree -r $rev |
  awk '{print $4, $3}' |
  grep "$1" |
  grep "\.rb" |
  awk '{print $2}' |
  xargs git show |
  wc -l
}

main
