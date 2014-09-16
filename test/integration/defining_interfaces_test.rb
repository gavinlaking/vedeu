require 'test_helper'

class MyFirstApplication
  include Vedeu

  interface 'hydrogen' do
    x       2
    y       2
    width   40
    height  4
    centred false
    delay   0.25
    group   'elements'
  end

  def initialize; end
end

describe 'Define an interface' do
  it 'defines an interface' do
    skip
    MyFirstApplication.new

    Vedeu.defined.interfaces.must_equal(['hydrogen'])
  end
end
