# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Coercers

    describe Coercer do

      let(:described) { Vedeu::Coercers::Coercer }
      let(:instance)  { described.new(_value) }
      let(:_value)    {}

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@value').must_equal(_value) }
      end

      describe '.coerce' do
        it { described.must_respond_to(:coerce) }
      end

      describe '#coerce' do
        subject { instance.coerce }

        it { proc { subject }.must_raise(Vedeu::Error::NotImplemented) }
      end

    end # Coercer

  end # Coercers

end # Vedeu
