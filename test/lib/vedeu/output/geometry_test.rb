require_relative '../../../test_helper'

module Vedeu
  describe Geometry do
    let(:described_class)    { Geometry }
    let(:described_instance) { described_class.new(values) }
    let(:values)             { {} }

    before do
      Terminal.stubs(:width).returns(80)
      Terminal.stubs(:height).returns(25)
    end

    it { described_instance.must_be_instance_of(Geometry) }

    describe '#z' do
      let(:subject) { described_instance.z }

      context 'using a value' do
        let(:values) { { z: 2 } }

        it { subject.must_equal(2) }
      end

      context 'using the default' do
        it { subject.must_equal(0) }
      end
    end

    describe '#y' do
      let(:subject) { described_instance.y }

      context 'using a value' do
        let(:values) { { y: 17 } }

        it { subject.must_equal(17) }
      end

      context 'using the default' do
        it { subject.must_equal(1) }
      end
    end

    describe '#x' do
      let(:subject) { described_instance.x }

      context 'using a value' do
        let(:values) { { x: 33 } }

        it { subject.must_equal(33) }
      end

      context 'using the default' do
        it { subject.must_equal(1) }
      end
    end

    describe '#width' do
      let(:subject) { described_instance.width }

      context 'using a value' do
        let(:values) { { width: 50 } }

        it { subject.must_equal(50) }
      end

      context 'using the default' do
        it { subject.must_equal(80) }
      end
    end

    describe '#height' do
      let(:subject) { described_instance.height }

      context 'using a value' do
        let(:values) { { height: 20 } }

        it { subject.must_equal(20) }
      end

      context 'using the default' do
        it { subject.must_equal(25) }
      end
    end

    describe '#dy' do
      let(:subject) { described_instance.dy }

      context 'when the value is greater than the available terminal size' do
        it 'clips the value to the terminal size' do
          subject.must_equal(25)
        end
      end

      context 'when the value is less than the available size' do
        let(:values) { { y: 20, height: 4 } }

        it { subject.must_equal(24) }
      end
    end

    describe '#dx' do
      let(:subject) { described_instance.dx }

      context 'when the value is greater than the available terminal size' do
        it 'clips the value to the terminal size' do
          subject.must_equal(80)
        end
      end

      context 'when the value is less than the available size' do
        let(:values) { { x: 17, width: 21 } }

        it { subject.must_equal(38) }
      end
    end
  end
end
