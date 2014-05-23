require_relative '../../../test_helper'

module Vedeu
  describe Geometry do
    let(:described_class)    { Geometry }
    let(:described_instance) { described_class.new(values) }
    let(:values)             { {} }

    it { described_instance.must_be_instance_of(Geometry) }

    describe '#z' do
      subject { described_instance.z }

      context 'using a value' do
        let(:values) { { z: 2 } }

        it { subject.must_equal(2) }
      end

      context 'using the default' do
        it { subject.must_equal(0) }
      end
    end

    describe '#y' do
      subject { described_instance.y }

      context 'using a value' do
        let(:values) { { y: 17 } }

        it { subject.must_equal(17) }
      end

      context 'using the default' do
        it { subject.must_equal(1) }
      end
    end

    describe '#x' do
      subject { described_instance.x }

      context 'using a value' do
        let(:values) { { x: 33 } }

        it { subject.must_equal(33) }
      end

      context 'using the default' do
        it { subject.must_equal(1) }
      end
    end

    describe '#width' do
      subject { described_instance.width }

      context 'using a value' do
        let(:values) { { width: 50 } }

        it { subject.must_equal(50) }
      end

      context 'using the default' do
        before { Terminal.stubs(:width).returns(80) }

        it { subject.must_equal(80) }
      end
    end

    describe '#height' do
      subject { described_instance.height }

      context 'using a value' do
        let(:values) { { height: 20 } }

        it { subject.must_equal(20) }
      end

      context 'using the default' do
        before { Terminal.stubs(:height).returns(25) }

        it { subject.must_equal(25) }
      end
    end
  end
end
