require 'test_helper'

module Vedeu

  describe Console do

    let(:described) { Vedeu::Console }
    let(:instance) { described.new(height, width) }
    let(:height) { 24 }
    let(:width) { 32 }

    describe 'alias methods' do
      it { instance.must_respond_to(:tyn) }
      it { instance.must_respond_to(:yn) }
      it { instance.must_respond_to(:x) }
      it { instance.must_respond_to(:y) }
      it { instance.must_respond_to(:tx) }
      it { instance.must_respond_to(:ty) }
      it { instance.must_respond_to(:txn) }
      it { instance.must_respond_to(:xn) }
      it { instance.must_respond_to(:read) }
      it { instance.must_respond_to(:write) }
      it { instance.must_respond_to(:winsize) }
    end

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@height').must_equal(height) }
      it { instance.instance_variable_get('@width').must_equal(width) }

      context 'when the height is not given' do
        let(:height) {}

        it { instance.instance_variable_get('@height').must_equal(25) }
      end

      context 'when the width is not given' do
        let(:width) {}

        it { instance.instance_variable_get('@width').must_equal(80) }
      end
    end

    describe '#input' do
      let(:data) {}

      subject { instance.input(data) }

      it { subject.must_be_instance_of(String) }
    end

    describe '#output' do
      let(:data) {}

      subject { instance.output(data) }

      it { subject.must_be_instance_of(Array) }
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

    describe '#cooked' do
      subject { instance.cooked }

      context 'when the block is not given' do
        it { proc { subject }.must_raise(LocalJumpError) }
      end
    end

    describe '#height' do
      subject { instance.height }

      it { subject.must_be_instance_of(Fixnum) }

      it { instance.must_respond_to(:tyn) }
      it { instance.must_respond_to(:yn) }
    end

    describe '#origin' do
      subject { instance.origin }

      it { subject.must_be_instance_of(Fixnum) }
      it { subject.must_equal(1) }

      it { instance.must_respond_to(:x) }
      it { instance.must_respond_to(:y) }
      it { instance.must_respond_to(:tx) }
      it { instance.must_respond_to(:ty) }
    end

    describe '#raw' do
      subject { instance.raw }

      context 'when the block is not given' do
        it { proc { subject }.must_raise(LocalJumpError) }
      end
    end

    describe '#size' do
      subject { instance.size }

      it { subject.must_be_instance_of(Array) }
      it { subject.must_equal([24, 32]) }

      it { instance.must_respond_to(:winsize) }
    end

    describe '#width' do
      subject { instance.width }

      it { subject.must_be_instance_of(Fixnum) }

      it { instance.must_respond_to(:txn) }
      it { instance.must_respond_to(:xn) }
    end

  end # Console

end # Vedeu
