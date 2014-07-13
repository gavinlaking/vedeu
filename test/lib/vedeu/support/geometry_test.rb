require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/support/geometry'
require_relative '../../../../lib/vedeu/models/interface'

module Vedeu
  describe Geometry do
    let(:described_class)    { Geometry }
    let(:described_instance) { described_class.new(interface, index) }
    let(:interface)          { Interface.new(attributes) }
    let(:attributes)         {
      {
        name:   'dummy',
        lines:  [],
        colour: {
          foreground: '#ff0000',
          background: '#000000'
        },
        width:  7,
        height: 3
      }
    }
    let(:index) { 0 }

    before do
      Terminal.stubs(:width).returns(40)
      Terminal.stubs(:height).returns(25)
    end

    describe '#origin' do
      it 'returns a String' do
        described_instance.origin.must_be_instance_of(String)
      end

      it 'returns the origin for the interface' do
        described_instance.origin.must_equal("\e[1;1H")
      end

      context 'when the index is provided' do
        let(:index) { 3 }

        it 'returns the line position relative to the origin' do
          described_instance.origin.must_equal("\e[4;1H")
        end
      end

      context 'when the interface is at a custom position' do
        let(:attributes) { { y: 6, x: 3 }}

        it 'returns the origin for the interface' do
          described_instance.origin.must_equal("\e[6;3H")
        end

        context 'when the index is provided' do
          let(:index) { 3 }

          it 'returns the line position relative to the origin' do
            described_instance.origin.must_equal("\e[9;3H")
          end
        end
      end
    end

    describe '#max_y' do
      let(:subject) { described_instance.max_y }

      it 'returns a Fixnum' do
        subject.must_be_instance_of(Fixnum)
      end

      context 'when the value is greater than the available terminal size' do
        it 'clips the value to the terminal size' do
          subject.must_equal(4)
        end
      end

      context 'when the value is less than the available size' do
        let(:attributes) { { y: 20, height: 4 } }

        it 'returns the value' do
          subject.must_equal(24)
        end
      end
    end

    describe '#max_x' do
      let(:subject) { described_instance.max_x }

      it 'returns a Fixnum' do
        subject.must_be_instance_of(Fixnum)
      end

      context 'when the value is greater than the available terminal size' do
        it 'clips the value to the terminal size' do
          subject.must_equal(8)
        end
      end

      context 'when the value is less than the available size' do
        let(:attributes) { { x: 17, width: 21 } }

        it 'returns the value' do
          subject.must_equal(38)
        end
      end
    end

    describe '#virtual_x' do
      let(:subject) { described_instance.virtual_x }

      it 'returns a Fixnum' do
        subject.must_be_instance_of(Fixnum)
      end

      it 'returns the value' do
        subject.must_equal(1)
      end
    end

    describe '#virtual_y' do
      let(:subject) { described_instance.virtual_y }

      it 'returns a Fixnum' do
        subject.must_be_instance_of(Fixnum)
      end

      it 'returns the value' do
        subject.must_equal(1)
      end
    end
  end
end
