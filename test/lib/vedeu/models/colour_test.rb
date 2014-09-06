require 'test_helper'

module Vedeu
  describe Colour do
    describe '#initialize' do
      it 'returns an instance of itself' do
        attributes = {}

        Colour.new(attributes).must_be_instance_of(Colour)
      end
    end

    describe '#background' do
      it 'returns an escape sequence' do
        Colour.new({
          background: '#000000'
        }).background.must_equal("\e[48;2;0;0;0m")
      end

      it 'returns an empty string when the value is empty' do
        Colour.new.background.must_equal('')
      end
    end

    describe '#foreground' do
      it 'returns an escape sequence' do
        Colour.new({
          foreground: '#ff0000'
        }).foreground.must_equal("\e[38;2;255;0;0m")
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
        }).to_s.must_equal("\e[38;2;255;0;0m\e[48;2;0;0;0m")
      end

      it 'returns an escape sequence when the foreground is missing' do
        Colour.new({
          background: '#000000'
        }).to_s.must_equal("\e[48;2;0;0;0m")
      end

      it 'returns an escape sequence when the background is missing' do
        Colour.new({
          foreground: '#ff0000',
        }).to_s.must_equal("\e[38;2;255;0;0m")
      end

      it 'returns an empty string when both are missing' do
        Colour.new.to_s.must_equal('')
      end
    end
  end
end
