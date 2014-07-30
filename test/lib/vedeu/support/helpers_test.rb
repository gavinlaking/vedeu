require 'test_helper'
require 'vedeu/support/helpers'

module Vedeu
  class TestHelpers
    include Helpers
  end

  describe Helpers do
    describe '.foreground' do
      it 'returns an escape sequence for the specified CSS foreground' do
        TestHelpers.new.foreground('#a5f500').must_equal("\e[38;5;148m")

        TestHelpers.new.fg('#851500').must_equal("\e[38;5;88m")
      end
    end

    describe '.background' do
      it 'returns an escape sequence for the specified CSS background' do
        TestHelpers.new.background('#2f2f2f').must_equal("\e[48;5;16m")

        TestHelpers.new.bg('#ffffff').must_equal("\e[48;5;231m")
      end
    end

    describe '.style' do
      it 'returns an escape sequence for multiple styles' do
        TestHelpers.new.style('bold', 'underline')
          .must_equal("\e[1m\e[4m")
      end

      it 'returns an escape sequence for a style' do
        TestHelpers.new.style('colour_reset')
          .must_equal("\e[38;2;39m\e[48;2;49m")
      end

      it 'returns an empty string for no styles' do
        TestHelpers.new.style.must_equal('')
      end
    end
  end
end
