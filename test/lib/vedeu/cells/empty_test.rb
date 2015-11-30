require 'test_helper'

module Vedeu

  module Cells

    describe Empty do

      let(:described)  { Vedeu::Cells::Empty }
      let(:instance)   { described.new(attributes) }
      let(:attributes) {
        {
          colour:   colour,
          name:     _name,
          position: position,
          style:    style,
          value:    _value,
        }
      }
      let(:colour)   { {} }
      let(:_name)    { '' }
      let(:position) {}
      let(:style)    { '' }
      let(:_value)   { '' }

      describe 'accessors' do
        it { instance.must_respond_to(:value) }
      end

      describe '#eql?' do
        let(:other) { instance }

        subject { instance.eql?(other) }

        it { subject.must_equal(true) }

        context 'when different to other' do
          let(:other) { described.new(value: 'b') }

          it { subject.must_equal(false) }
        end
      end

    end # Empty

  end # Cells

end # Vedeu
