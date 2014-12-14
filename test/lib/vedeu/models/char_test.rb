require 'test_helper'

module Vedeu

  describe Char do

    let(:described) { Char.new(attributes) }
    let(:char)   { Char.new(attributes) }
    let(:parent) {
      {
        colour: {
          foreground: '#00ff00',
          background: '#ff00ff'
        },
        style: []
      }
    }
    let(:attributes) {
      {
        colour: { foreground: '#ffff00', background: '#0000ff' },
        parent: parent,
        style:  [],
        value:  value,
      }
    }
    let(:value)   { 'a' }

    describe '#initialize' do
      it { return_type_for(described, Char) }
      it { assigns(described, '@attributes', attributes) }
      it { assigns(described, '@parent', parent) }
      it { assigns(described, '@value', value) }
    end

    describe '#to_s' do
      it { return_type_for(described.to_s, String) }

      it 'returns the escape sequences and content' do
        # - char colours and style as set in Stream#chars.
        # - the value.
        # - the colours and style of the line which the Char belongs to.
        char.to_s.must_equal(
          "\e[38;2;255;255;0m\e[48;2;0;0;255m" \
          "a" \
          "\e[38;2;0;255;0m\e[48;2;255;0;255m"
        )
      end
    end

  end # Char

end # Vedeu
