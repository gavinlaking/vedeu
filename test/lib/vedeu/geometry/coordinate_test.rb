require 'test_helper'

module Vedeu

  describe Coordinate do

    let(:described) { Vedeu::Coordinate }
    let(:instance)  { described.new(height, width, x, y) }
    let(:height)    { 6 }
    let(:width)     { 6 }
    let(:x)         { 7 }
    let(:y)         { 5 }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@height').must_equal(height) }
      it { instance.instance_variable_get('@width').must_equal(width) }
      it { instance.instance_variable_get('@x').must_equal(x) }
      it { instance.instance_variable_get('@y').must_equal(y) }
    end

    describe '#yn' do
      subject { instance.yn }

      context 'when the height is <= to 0' do
        let(:height) { 0 }

        it { subject.must_equal(0) }
      end

      context 'when the height is > 0' do
        it { subject.must_equal(11) }
      end
    end

    describe '#xn' do
      subject { instance.xn }

      context 'when the width is <= to 0' do
        let(:width) { 0 }

        it { subject.must_equal(0) }
      end

      context 'when the width is > 0' do
        it { subject.must_equal(13) }
      end
    end

    describe '#y_index' do
      subject { instance.y_index(position) }

      context 'when the position is <= 0' do
        let(:position) { -2 }

        it { subject.must_equal(0) }
      end

      context 'when the position is <= y' do
        let(:position) { 4 }

        it { subject.must_equal(0) }
      end

      context 'when the position is >= yn' do
        let(:position) { 20 }

        it { subject.must_equal(5) }
      end

      context 'when the position is > y and < yn' do
        let(:position) { 8 }

        it { subject.must_equal(3) }
      end
    end

    describe '#x_index' do
      subject { instance.x_index(position) }

      context 'when the position is <= 0' do
        let(:position) { -2 }

        it { subject.must_equal(0) }
      end

      context 'when the position is <= x' do
        let(:position) { 4 }

        it { subject.must_equal(0) }
      end

      context 'when the position is >= xn' do
        let(:position) { 20 }

        it { subject.must_equal(5) }
      end

      context 'when the position is > x and < xn' do
        let(:position) { 8 }

        it { subject.must_equal(1) }
      end
    end

    describe '#y_position' do
      let(:index)  { 0 }
      let(:height) { 6 }
      let(:width)  { 6 }
      let(:x)      { 7 }
      let(:y)      { 5 }

      subject { instance.y_position(index) }

      it { subject.must_be_instance_of(Fixnum) }

      context 'with a negative index' do
        let(:index) { -3 }

        it { subject.must_equal(5) }
      end

      context 'with an index greater than the maximum index for y' do
        let(:index) { 9 }

        it { subject.must_equal(11) }

        context 'but the height is negative' do
          let(:height) { -2 }

          it { subject.must_equal(0) }
        end
      end

      context 'with an index within range' do
        let(:index) { 3 }

        it { subject.must_equal(8) }
      end
    end

    describe '#x_position' do
      let(:index)  { 0 }
      let(:height) { 6 }
      let(:width)  { 6 }
      let(:x)      { 7 }
      let(:y)      { 5 }

      subject { instance.x_position(index) }

      it { subject.must_be_instance_of(Fixnum) }

      context 'with a negative index' do
        let(:index) { -3 }

        it { subject.must_equal(7) }
      end

      context 'with an index greater than the maximum index for x' do
        let(:index) { 9 }

        it { subject.must_equal(13) }

        context 'but the width is negative' do
          let(:width) { -2 }

          it { subject.must_equal(0) }
        end
      end

      context 'with an index within range' do
        let(:index) { 3 }

        it { subject.must_equal(10) }
      end
    end

  end # Coordinate

end # Vedeu
