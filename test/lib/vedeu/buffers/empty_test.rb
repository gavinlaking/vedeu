require 'test_helper'

module Vedeu

  module Buffers

    describe Empty do

      let(:described)  { Vedeu::Buffers::Empty }
      let(:instance)   { described.new(attributes) }
      let(:attributes) {
        {
          height: height,
          name:   _name,
          width:  width,
        }
      }
      let(:height) { 3 }
      let(:_name)  {}
      let(:width)  { 9 }

      before do
        Vedeu.stubs(:height).returns(4)
        Vedeu.stubs(:width).returns(12)
      end

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }

        context 'when the height is given' do
          it { instance.instance_variable_get('@height').must_equal(3) }
        end

        context 'when the height not is given' do
          let(:height) {}

          it { instance.instance_variable_get('@height').must_equal(4) }
        end

        it { instance.instance_variable_get('@name').must_equal(_name) }

        context 'when the width is given' do
          it { instance.instance_variable_get('@width').must_equal(9) }
        end

        context 'when the width not is given' do
          let(:width) {}

          it { instance.instance_variable_get('@width').must_equal(12) }
        end
      end

      describe 'accessors' do
        it { instance.must_respond_to(:name) }
      end

      describe '#buffer' do
        let(:position) { Vedeu::Geometries::Position.new(1, 1) }

        subject { instance.buffer }

        it { subject.must_be_instance_of(Array) }
        it { subject.first.must_be_instance_of(Array) }
        it { subject.first.first.must_be_instance_of(Vedeu::Cells::Empty) }

        it { subject.size.must_equal(3) }
        it { subject.first.size.must_equal(9) }
        it { subject.first.first.position.must_equal(position) }
      end

      describe '#height' do
        subject { instance.height }

        it { subject.must_equal(height + 1) }
      end

      describe '#width' do
        subject { instance.width }

        it { subject.must_equal(width + 1) }
      end

    end # Empty

  end # Buffers

end # Vedeu
