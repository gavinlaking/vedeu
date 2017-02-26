# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Coercers

    describe Position do

      let(:described) { Vedeu::Coercers::Position }
      let(:instance)  { described.new(_value) }
      let(:_value)    {}
      let(:klass)     { Vedeu::Geometries::Position }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@value').must_equal(_value) }
      end

      describe '.coerce' do
        it { described.must_respond_to(:coerce) }
      end

      describe '#coerce' do
        subject { instance.coerce }

        context 'when the value is already the target class' do
          let(:_value) { klass.new }

          it { subject.must_be_instance_of(klass) }
          it { subject.must_equal(_value) }
        end

        context 'when the value is an Array' do
          let(:_value) { [2, 8] }

          it { subject.must_be_instance_of(klass) }
          it { subject.y.must_equal(2) }
          it { subject.x.must_equal(8) }
        end

        context 'when the value is an Integer' do
          let(:_value) { 2 }

          it { subject.must_be_instance_of(klass) }
          it { subject.y.must_equal(2) }
          it { subject.x.must_equal(1) }
        end

        context 'when the value is a Hash' do
          let(:_value) { { y: 3, x: 9 } }

          it { subject.must_be_instance_of(klass) }
          it { subject.y.must_equal(3) }
          it { subject.x.must_equal(9) }
        end

        context 'when the value is a NilClass' do
          let(:_value) {}

          it { subject.must_be_instance_of(NilClass) }
        end

        context 'when the value is something unhandled' do
          let(:_value) { :invalid }

          it { proc { subject }.must_raise(Vedeu::Error::Fatal) }
        end
      end

    end # Position

  end # Coercers

end # Vedeu
