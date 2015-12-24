require 'test_helper'

module Vedeu

  module Coercers

    describe Alignment do

      let(:described) { Vedeu::Coercers::Alignment }
      let(:instance)  { described.new(_value) }
      let(:_value)    { :left }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }

        context 'when the value is not given' do
          let(:_value) {}

          it { instance.instance_variable_get('@value').must_equal(:none) }
        end

        context 'when the value is given' do
          it { instance.instance_variable_get('@value').must_equal(_value) }
        end
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
          let(:_value) {}

          it { subject.must_be_instance_of(described) }
        end
      end

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

      describe '#eql?' do
        let(:other) { instance }

        subject { instance.eql?(other) }

        it { subject.must_equal(true) }

        context 'when different to other' do
          let(:other) { described.new(:center) }

          it { subject.must_equal(false) }
        end
      end

      describe '#==' do
        it { instance.must_respond_to(:==) }
      end

      describe '#left_aligned?' do
        subject { instance.left_aligned? }

        context 'when the value is :left' do
          it { subject.must_equal(true) }
        end

        context 'when the value is not :left' do
          let(:_value) { :right }

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
          let(:_value) { :none }

          it { subject.must_equal(true) }
        end

        context 'when the value is not :none' do
          let(:_value) { :centre }

          it { subject.must_equal(false) }
        end
      end

      describe '#value' do
        subject { instance.value }

        it { subject.must_equal(:left) }
      end

    end # Alignment

  end # Coercers

end # Vedeu
