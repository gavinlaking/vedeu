#!/usr/bin/env ruby
require_relative '../../lib/vedeu/output/colour_translator'

values = ["00", "5f", "87", "af", "d7", "ff"]
codes  = {}

values.each do |r|
  values.each do |g|
    values.each do |b|
      value = ["#", r, g, b].join
      trans = Vedeu::ColourTranslator.translate(value)
      codes[trans] = value
    end
  end
end

# basic
30.upto(38) do |fg|
  40.upto(48) do |bg|
    print "\e[38;2;#{fg}m\e[48;2;#{bg}mVedeu\e[0m"
  end
  print "\n"
end

# foreground
codes.each_slice(6) do |c|
  c.each do |k, v|
    printf "\e[48;2;49m \e[38;5;%s30m%s %3s ", k, v, k
  end
  print "\e[48;2;49m\e[38;2;39m\n"
end

# background
codes.each_slice(6) do |c|
  c.each do |k, v|
    printf "\e[48;5;%sm \e[38;2;30m%s %3s ", k, v, k
  end
  print "\e[48;2;49m\e[38;2;39m\n"
end
