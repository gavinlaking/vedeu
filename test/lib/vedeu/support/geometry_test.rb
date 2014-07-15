require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/support/geometry'
require_relative '../../../../lib/vedeu/models/interface'

module Vedeu
  describe Geometry do
    let(:interface)  { Interface.new(attributes) }
    let(:attributes) {
      {
        name:   'dummy',
        lines:  [],
        colour: {
          foreground: '#ff0000',
          background: '#000000'
        },
        width:  width,
        height: height,
        x:      x,
        y:      y,
        z:      z
      }
    }
    let(:height) { 5 }
    let(:index)  { 0 }
    let(:width)  { 5 }
    let(:x)      { 1 }
    let(:y)      { 1 }
    let(:z)      { 1 }

    before do
      Terminal.stubs(:width).returns(40)
      Terminal.stubs(:height).returns(15)
    end

    describe '#origin' do
      it 'returns a String' do
        Geometry.new(interface).origin(index)
          .must_be_instance_of(String)
      end

      it 'returns the origin for the interface' do
        Geometry.new(interface).origin(index)
          .must_equal("\e[1;1H")
      end

      context 'when the index is provided' do
        let(:index) { 3 }

        it 'returns the line position relative to the origin' do
          Geometry.new(interface).origin(index)
            .must_equal("\e[4;1H")
        end
      end

      context 'when the interface is at a custom position' do
        let(:x) { 3 }
        let(:y) { 6 }

        it 'returns the origin for the interface' do
          Geometry.new(interface).origin(index)
            .must_equal("\e[6;3H")
        end

        context 'when the index is provided' do
          let(:index) { 3 }

          it 'returns the line position relative to the origin' do
            Geometry.new(interface).origin(index)
              .must_equal("\e[9;3H")
          end
        end
      end

      context 'when the height is more than the terminal height' do
        let(:height) { 6 }
        let(:y)      { 20 }

        it 'clips the maximum height to the terminal height' do
          Geometry.new(interface).origin(index)
            .must_equal("\e[1;1H")
        end
      end

      context 'when the height is less than the terminal height' do
        let(:height) { 2 }
        let(:y)      { 20 }

        it 'returns the value' do
          Geometry.new(interface).origin(index)
            .must_equal("\e[1;1H")
        end
      end

      context 'when the width is more than the terminal width' do
        let(:x)     { 30 }
        let(:width) { 20 }

        it 'clips the maximum width to the terminal width' do
          Geometry.new(interface).origin(index)
            .must_equal("\e[1;30H")
        end
      end

      context 'when the width is less than the terminal width' do
        let(:x)     { 15 }
        let(:width) { 20 }

        it 'returns the value' do
          Geometry.new(interface).origin(index)
            .must_equal("\e[1;15H")
        end
      end
    end
  end
end
