#!/usr/bin/env ruby

1.upto(99999) do |seed|
  if system("rake NO_SIMPLECOV=1 SEED=#{seed} > /dev/null")
    puts "SEED #{seed} successful"
  else
    puts "SEED #{seed} failure"
  end
end
