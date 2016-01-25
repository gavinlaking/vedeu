# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Coercers

    describe Row do

      let(:described) { Vedeu::Coercers::Row }
      let(:instance)  { described.new(_value) }
      let(:_value)    {}
      let(:klass)     { Vedeu::Models::Row }

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
          let(:_value) { [:hydrogen, :helium, :lithium] }

          it { subject.must_equal(klass.new(_value)) }
        end

        context 'when the value is an Array containing nil objects' do
          let(:_value) { [:hydrogen, nil, :lithium] }

          it { subject.must_equal(klass.new([:hydrogen, :lithium])) }
        end

        context 'when the value is nil' do
          let(:_value) {}

          it { subject.must_equal(klass.new) }
        end

        context 'when the value is anything else' do
          let(:_value) { :beryllium }

          it { subject.must_equal(klass.new([_value])) }
        end
      end

    end # Row

  end # Coercers

end # Vedeu
