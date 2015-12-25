# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Geometries

    class ValidatorTestClass
      include Vedeu::Geometries::Validator
    end

    describe Validator do

      let(:included) { Vedeu::Geometries::ValidatorTestClass.new }

      describe '#validate_height!' do
        let(:_value) {}

        subject { included.validate_height!(_value) }

        context 'when the value is given' do
          let(:_value) { 11 }

          it { subject.must_equal(true) }
        end

        context 'when the value is not given' do
          it { proc { subject }.must_raise(Vedeu::Error::InvalidSyntax) }
        end
      end

      describe '#validate_horizontal_alignment!' do
        let(:_value) {}

        subject { included.validate_horizontal_alignment!(_value) }

        context 'when the value is given' do
          let(:_value) { :left }

          it { subject.must_equal(true) }
        end

        context 'when the value is not given' do
          it { proc { subject }.must_raise(Vedeu::Error::InvalidSyntax) }
        end
      end

      describe '#validate_vertical_alignment!' do
        let(:_value) {}

        subject { included.validate_vertical_alignment!(_value) }

        context 'when the value is given' do
          let(:_value) { :top }

          it { subject.must_equal(true) }
        end

        context 'when the value is not given' do
          it { proc { subject }.must_raise(Vedeu::Error::InvalidSyntax) }
        end
      end

      describe '#validate_width!' do
        let(:_value) {}

        subject { included.validate_width!(_value) }

        context 'when the value is given' do
          let(:_value) { 11 }

          it { subject.must_equal(true) }
        end

        context 'when the value is not given' do
          it { proc { subject }.must_raise(Vedeu::Error::InvalidSyntax) }
        end
      end

    end # Validator

  end # Geometries

end # Vedeu
