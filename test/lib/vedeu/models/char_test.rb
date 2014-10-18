require 'test_helper'

module Vedeu
  describe Char do
    let(:instance)   { Char.new(attributes) }
    let(:attributes) {
      {
        colour: { foreground: '#ffff00', background: '#0000ff' },
        parent: {
          colour: {
            foreground: '#00ff00',
            background: '#ff00ff'
          },
          style: []
        },
        style:  [],
        value:  value,
      }
    }
    let(:value) { 'a' }

    describe '#initialize' do
      it 'returns a new instance of Char' do
        instance.must_be_instance_of(Char)
      end
    end

    describe '#to_s' do
      it 'returns a String' do
        instance.to_s.must_be_instance_of(String)
      end

      it 'returns the escape sequences and content' do
        # - char colours and style as set in Stream#chars.
        # - the value.
        # - the colours and style of the line which the Char belongs to.
        instance.to_s.must_equal(
          "\e[38;2;255;255;0m\e[48;2;0;0;255m" \
          "a" \
          "\e[38;2;0;255;0m\e[48;2;255;0;255m"
        )
      end
    end

  end
end
