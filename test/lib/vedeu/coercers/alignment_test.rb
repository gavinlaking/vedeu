require 'test_helper'

module Vedeu

  module Coercers

    describe Alignment do

      let(:described) { Vedeu::Coercers::Alignment }
      let(:instance)  { described.new(_value) }
      let(:_value)    {}

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@value').must_equal(_value) }
      end

      describe '.coerce' do
        subject { described.coerce(_value) }

        context 'when the value is a Vedeu::Coercers::Alignment' do
          let(:_value) { described.new(:none) }

          it { subject.must_equal(_value) }
        end

        context 'when the value is a Symbol' do
          let(:_value) { :centre }

          it { subject.must_be_instance_of(described) }
        end

        context 'when the value is nil or something else' do
          it { subject.must_be_instance_of(described) }
        end
      end

      # describe '#align' do
      #   subject { instance.align }

      #   it { proc { subject }.must_raise(Vedeu::Error::NotImplemented) }
      # end

      describe '#bottom_aligned?' do
        subject { instance.bottom_aligned? }

        context 'when the value is :bottom' do
          let(:_value) { :bottom }

          it { subject.must_equal(true) }
        end

        context 'when the value is not :bottom' do
          it { subject.must_equal(false) }
        end
      end

      describe '#centre_aligned?' do
        subject { instance.centre_aligned? }

        context 'when the value is :centre' do
          let(:_value) { :centre }

          it { subject.must_equal(true) }
        end

        context 'when the value is not :centre' do
          it { subject.must_equal(false) }
        end
      end

      describe '#left_aligned?' do
        subject { instance.left_aligned? }

        context 'when the value is :left' do
          let(:_value) { :left }

          it { subject.must_equal(true) }
        end

        context 'when the value is not :left' do
          it { subject.must_equal(false) }
        end
      end

      describe '#middle_aligned?' do
        subject { instance.middle_aligned? }

        context 'when the value is :middle' do
          let(:_value) { :middle }

          it { subject.must_equal(true) }
        end

        context 'when the value is not :middle' do
          it { subject.must_equal(false) }
        end
      end

      describe '#right_aligned?' do
        subject { instance.right_aligned? }

        context 'when the value is :right' do
          let(:_value) { :right }

          it { subject.must_equal(true) }
        end

        context 'when the value is not :right' do
          it { subject.must_equal(false) }
        end
      end

      describe '#top_aligned?' do
        subject { instance.top_aligned? }

        context 'when the value is :top' do
          let(:_value) { :top }

          it { subject.must_equal(true) }
        end

        context 'when the value is not :top' do
          it { subject.must_equal(false) }
        end
      end

      describe '#unaligned?' do
        subject { instance.unaligned? }

        context 'when the value is :none' do
          it { subject.must_equal(true) }
        end

        context 'when the value is not :none' do
          let(:_value) { :centre }

          it { subject.must_equal(false) }
        end
      end

    end # Alignment

  end # Coercers

end # Vedeu
