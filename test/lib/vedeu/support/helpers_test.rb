require 'test_helper'
require 'vedeu/support/helpers'

module Vedeu
  class TestHelpers
    include Helpers
  end

  describe Helpers do
    describe '.line' do
      it 'returns the block with line returns removed' do
        skip
      end
    end

    describe '.foreground' do
      it 'returns an escape sequence for the specified CSS foreground' do
        TestHelpers.new.foreground('#a5f500').must_equal("\e[38;5;148m")

        TestHelpers.new.fg('#851500').must_equal("\e[38;5;88m")
      end

      it 'returns an escape sequence plus interpolation when a block is given' do
        TestHelpers.new.foreground('#a5f500') { 'Some text' }
          .must_equal("\e[38;5;148mSome text\e[38;2;39m")
      end
    end

    describe '.background' do
      it 'returns an escape sequence for the specified CSS background' do
        TestHelpers.new.background('#2f2f2f').must_equal("\e[48;5;16m")

        TestHelpers.new.bg('#ffffff').must_equal("\e[48;5;231m")
      end

      it 'returns an escape sequence plus interpolation when a block is given' do
        TestHelpers.new.background('#2f2f2f') { 'Some text' }
          .must_equal("\e[48;5;16mSome text\e[48;2;49m")
      end
    end

    describe '.colour' do
      it 'returns an escape sequence for the specified CSS colours' do
        TestHelpers.new.colour({ background: '#2f2f2f', foreground: '#a5ff00' })
          .must_equal("\e[38;5;154m\e[48;5;16m")
      end

      it 'returns an escape sequence plus interpolation when a block is given' do
        TestHelpers.new.colour({ background: '#2f2f2f', foreground: '#a5ff00' }) { 'Some text' }
          .must_equal("\e[38;5;154m\e[48;5;16mSome text\e[38;2;39m\e[48;2;49m")
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

      it 'returns an escape sequence plus interpolation when a block is given' do
        TestHelpers.new.style('bold', 'underline') { 'Some text' }
          .must_equal("\e[1m\e[4mSome text\e[0m")
      end
    end
  end
end
