require 'test_helper'

module Vedeu

  describe Console do

    let(:described) { Vedeu::Console }
    let(:instance) { described.new(height, width) }
    let(:height) { 24 }
    let(:width) { 32 }

    describe '#initialize' do
      subject { instance }

      it { subject.must_be_instance_of(described) }
      it { subject.instance_variable_get('@height').must_equal(height) }
      it { subject.instance_variable_get('@width').must_equal(width) }

      context 'when the height is not given' do
        let(:height) {}

        it { subject.instance_variable_get('@height').must_equal(25) }
      end

      context 'when the width is not given' do
        let(:width) {}

        it { subject.instance_variable_get('@width').must_equal(80) }
      end
    end

    describe '#centre' do
      subject { instance.centre }

      it { subject.must_be_instance_of(Array) }
      it { subject.must_equal([12, 16]) }
    end

    describe '#centre_y' do
      subject { instance.centre_y }

      it { subject.must_be_instance_of(Fixnum) }
      it { subject.must_equal(12) }
    end

    describe '#centre_x' do
      subject { instance.centre_x }

      it { subject.must_be_instance_of(Fixnum) }
      it { subject.must_equal(16) }
    end

    describe '#origin' do
      subject { instance.origin }

      it { subject.must_be_instance_of(Fixnum) }
      it { subject.must_equal(1) }
    end

    describe '#size' do
      subject { instance.size }

      it { subject.must_be_instance_of(Array) }
      it { subject.must_equal([24, 32]) }
    end

  end # Console

end # Vedeu
