require 'benchmark'

class Foo
  def bar(a, b)
    a + b
  end

  def baz
    a + b
  end

  def a
    rand(1000_000)
  end

  def b
    rand(1000_000)
  end
end

foo = Foo.new

Benchmark.bm 30 do |x|
  x.report 'original method' do
    1000000.times do |_|
      foo.bar(rand(1_000_000), rand(1_000_000))
    end
  end
  x.report 'shiny new method' do
    1000000.times do |_|
      foo.baz
    end
  end
end
