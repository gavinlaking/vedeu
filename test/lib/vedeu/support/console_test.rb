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

      context 'alias method #tyn' do
        subject { instance.tyn }

        it { subject.must_be_instance_of(Fixnum) }
      end

      context 'alias method #yn' do
        subject { instance.yn }

        it { subject.must_be_instance_of(Fixnum) }
      end
    end

    describe '#origin' do
      subject { instance.origin }

      it { subject.must_be_instance_of(Fixnum) }
      it { subject.must_equal(1) }

      context 'alias method #x' do
        subject { instance.x }

        it { subject.must_be_instance_of(Fixnum) }
      end

      context 'alias method #y' do
        subject { instance.y }

        it { subject.must_be_instance_of(Fixnum) }
      end

      context 'alias method #tx' do
        subject { instance.tx }

        it { subject.must_be_instance_of(Fixnum) }
      end

      context 'alias method #ty' do
        subject { instance.ty }

        it { subject.must_be_instance_of(Fixnum) }
      end
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

      context 'alias method #winsize' do
        subject { instance.winsize }

        it { subject.must_be_instance_of(Array) }
      end
    end

    describe '#width' do
      subject { instance.width }

      it { subject.must_be_instance_of(Fixnum) }

      context 'alias method #txn' do
        subject { instance.txn }

        it { subject.must_be_instance_of(Fixnum) }
      end

      context 'alias method #xn' do
        subject { instance.xn }

        it { subject.must_be_instance_of(Fixnum) }
      end
    end

  end # Console

end # Vedeu
