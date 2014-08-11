require 'test_helper'

module Vedeu
  describe Colour do
    describe '#background' do
      it 'returns an escape sequence' do
        Colour.new({
          background: '#000000'
        }).background.must_equal("\e[48;5;16m")
      end

      it 'returns an empty string when the value is empty' do
        Colour.new.background.must_equal('')
      end
    end

    describe '#foreground' do
      it 'returns an escape sequence' do
        Colour.new({
          foreground: '#ff0000'
        }).foreground.must_equal("\e[38;5;196m")
      end

      it 'returns an empty string when the value is empty' do
        Colour.new.foreground.must_equal('')
      end
    end

    describe '#to_s' do
      it 'returns an escape sequence' do
        Colour.new({
          foreground: '#ff0000',
          background: '#000000'
        }).to_s.must_equal("\e[38;5;196m\e[48;5;16m")
      end

      it 'returns an escape sequence when the foreground is missing' do
        Colour.new({
          background: '#000000'
        }).to_s.must_equal("\e[48;5;16m")
      end

      it 'returns an escape sequence when the background is missing' do
        Colour.new({
          foreground: '#ff0000',
        }).to_s.must_equal("\e[38;5;196m")
      end

      it 'returns an empty string when both are missing' do
        Colour.new.to_s.must_equal('')
      end
    end
  end
end
