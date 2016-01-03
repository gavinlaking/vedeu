#!/bin/bash

set -e

function expected {
  printf "\e[32mExpected:\e[39m "
}
function actual {
  printf "\e[31mActual:\e[39m   "
}

./line.rb
./lines.rb
./lines_alignment.rb
./full_screen.rb

echo -ne "\e[34mline out\e[39m\n"
echo -ne "$(expected) $(du -b ./expected/vedeu_line.out | cut -f1)\n"
echo -ne "$(actual) $(du -b /tmp/vedeu_line.out | cut -f1)\n"
echo -ne "\e[33mhtml\e[39m\n"
echo -ne "$(expected) $(du -b ./expected/vedeu_line.html | cut -f1)\n"
echo -ne "$(actual) $(du -b /tmp/vedeu_line.html | cut -f1)\n"
echo -ne "\e[33mjson\e[39m\n"
echo -ne "$(expected) $(du -b ./expected/vedeu_line.json | cut -f1)\n"
echo -ne "$(actual) $(du -b /tmp/vedeu_line.json | cut -f1)\n"
echo -ne "\e[33mtxt\e[39m\n"
echo -ne "$(expected) $(du -b ./expected/vedeu_line.txt | cut -f1)\n"
echo -ne "$(actual) $(du -b /tmp/vedeu_line.txt | cut -f1)\n"

echo -ne "\n"

echo -ne "\e[34mlines out\e[39m\n"
echo -ne "$(expected) $(du -b ./expected/vedeu_lines.out | cut -f1)\n"
echo -ne "$(actual) $(du -b /tmp/vedeu_lines.out | cut -f1)\n"
echo -ne "\e[33mhtml\e[39m\n"
echo -ne "$(expected) $(du -b ./expected/vedeu_lines.html | cut -f1)\n"
echo -ne "$(actual) $(du -b /tmp/vedeu_lines.html | cut -f1)\n"
echo -ne "\e[33mjson\e[39m\n"
echo -ne "$(expected) $(du -b ./expected/vedeu_lines.json | cut -f1)\n"
echo -ne "$(actual) $(du -b /tmp/vedeu_lines.json | cut -f1)\n"
echo -ne "\e[33mtxt\e[39m\n"
echo -ne "$(expected) $(du -b ./expected/vedeu_lines.txt | cut -f1)\n"
echo -ne "$(actual) $(du -b /tmp/vedeu_lines.txt | cut -f1)\n"

echo -ne "\n"

echo -ne "\e[34mlines alignment out\e[39m\n"
echo -ne "$(expected) $(du -b ./expected/vedeu_lines_alignment.out | cut -f1)\n"
echo -ne "$(actual) $(du -b /tmp/vedeu_lines_alignment.out | cut -f1)\n"
echo -ne "\e[33mhtml\e[39m\n"
echo -ne "$(expected) $(du -b ./expected/vedeu_lines_alignment.html | cut -f1)\n"
echo -ne "$(actual) $(du -b /tmp/vedeu_lines_alignment.html | cut -f1)\n"
echo -ne "\e[33mjson\e[39m\n"
echo -ne "$(expected) $(du -b ./expected/vedeu_lines_alignment.json | cut -f1)\n"
echo -ne "$(actual) $(du -b /tmp/vedeu_lines_alignment.json | cut -f1)\n"
echo -ne "\e[33mtxt\e[39m\n"
echo -ne "$(expected) $(du -b ./expected/vedeu_lines_alignment.txt | cut -f1)\n"
echo -ne "$(actual) $(du -b /tmp/vedeu_lines_alignment.txt | cut -f1)\n"

echo -ne "\n"

echo -ne "\e[34mfull screen out\e[39m\n"
echo -ne "$(expected) $(du -b ./expected/vedeu_full_screen.out | cut -f1)\n"
echo -ne "$(actual) $(du -b /tmp/vedeu_full_screen.out | cut -f1)\n"
echo -ne "\e[33mhtml\e[39m\n"
echo -ne "$(expected) $(du -b ./expected/vedeu_full_screen.html | cut -f1)\n"
echo -ne "$(actual) $(du -b /tmp/vedeu_full_screen.html | cut -f1)\n"
echo -ne "\e[33mjson\e[39m\n"
echo -ne "$(expected) $(du -b ./expected/vedeu_full_screen.json | cut -f1)\n"
echo -ne "$(actual) $(du -b /tmp/vedeu_full_screen.json | cut -f1)\n"
echo -ne "\e[33mtxt\e[39m\n"
echo -ne "$(expected) $(du -b ./expected/vedeu_full_screen.txt | cut -f1)\n"
echo -ne "$(actual) $(du -b /tmp/vedeu_full_screen.txt | cut -f1)\n"
