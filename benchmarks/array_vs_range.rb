#!/usr/bin/env ruby

# To test the suitability of using a range to determine a valid
# coordinate instead of the current array method as used in
# Vedeu::Buffers::Terminal#within_terminal_boundary?
#
# vedeu/benchmarks:spike/benchmarking$ ./array_vs_range.rb
# Calculating -------------------------------------
#                array   202.400k i/100ms
#                range   130.641k i/100ms
# -------------------------------------------------
#                array      8.171M (± 0.1%) i/s -     40.885M
#                range      2.471M (± 0.4%) i/s -     12.411M
#
# Comparison:
#                array:  8170584.0 i/s
#                range:  2470528.5 i/s - 3.31x slower
#

require "bundler/setup"
require "benchmark/ips"

YN   = 60
XN   = 140
GRID = Array.new(YN) { |y| Array.new(XN) { |x| :"grid_#{y}_#{x}" } }
Y    = rand(YN)
X    = rand(XN)

def fast
  GRID[Y] && GRID[Y][X]
end

def slow
  (0..YN).cover?(Y) && (0..XN).cover?(X)
end

Benchmark.ips do |x|
  x.report("array") { fast }
  x.report("range") { slow }
  x.compare!
end
