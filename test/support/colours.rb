#!/usr/bin/env ruby

30.upto(38) do |fg|
  40.upto(48) do |bg|
    print "\e[38;2;#{fg}m\e[48;2;#{bg}mVedeu\e[0m"
  end
  print "\n"
end
