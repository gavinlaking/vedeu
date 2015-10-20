require 'test_helper'

module Vedeu

  module Geometry

    describe Alignment do

      let(:described) { Vedeu::Geometry::Alignment }
      let(:instance)  { described.new(_value) }
      let(:_value)    {}

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@value').must_equal(_value) }
      end

      describe '.align' do
        subject { described.align(_value) }

        it { proc { subject }.must_raise(Vedeu::Error::NotImplemented) }
      end

      describe '#align' do
        subject { instance.align }

        it { proc { subject }.must_raise(Vedeu::Error::NotImplemented) }
      end

    end # Alignment

    describe HorizontalAlignment do

      let(:described) { Vedeu::Geometry::HorizontalAlignment }
      let(:instance)  { described.new(_value) }
      let(:_value)    {}

      describe '.align' do
        subject { described.align(_value) }

        context 'when the value is nil' do
          it { subject.must_equal(:none) }
        end

        context 'when the value is not a Symbol' do
          let(:_value) { 'invalid' }

          it { subject.must_equal(:none) }
        end

        context 'when the value is :center' do
          let(:_value) { :center }

          it { subject.must_equal(:centre) }
        end

        context 'when the value is :centre' do
          let(:_value) { :centre }

          it { subject.must_equal(:centre) }
        end

        context 'when the value is :left' do
          let(:_value) { :left }

          it { subject.must_equal(:left) }
        end

        context 'when the value is :right' do
          let(:_value) { :right }

          it { subject.must_equal(:right) }
        end

        context 'when the value is :align_invalid' do
          let(:_value) { :align_invalid }

          it { proc { subject }.must_raise(Vedeu::Error::InvalidSyntax) }
        end
      end

    end # HorizontalAlignment

    describe VerticalAlignment do

      let(:described) { Vedeu::Geometry::VerticalAlignment }
      let(:instance)  { described.new(_value) }
      let(:_value)    {}

      describe '.align' do
        subject { described.align(_value) }

        context 'when the value is nil' do
          it { subject.must_equal(:none) }
        end

        context 'when the value is not a Symbol' do
          let(:_value) { 'invalid' }

          it { subject.must_equal(:none) }
        end

        context 'when the value is :bottom' do
          let(:_value) { :bottom }

          it { subject.must_equal(:bottom) }
        end

        context 'when the value is :middle' do
          let(:_value) { :middle }

          it { subject.must_equal(:middle) }
        end

        context 'when the value is :top' do
          let(:_value) { :top }

          it { subject.must_equal(:top) }
        end

        context 'when the value is :align_invalid' do
          let(:_value) { :align_invalid }

          it { proc { subject }.must_raise(Vedeu::Error::InvalidSyntax) }
        end
      end

    end # VerticalAlignment

  end # Geometry

end # Vedeu
