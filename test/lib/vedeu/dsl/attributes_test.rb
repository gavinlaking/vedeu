require 'test_helper'

module Vedeu

  module DSL

    describe Attributes do

      let(:described) { Vedeu::DSL::Attributes }
      let(:instance)  { described.new(context, model, value, options) }
      let(:context)   {}
      let(:model)     {}
      let(:_value)    {}
      let(:options)   {

      }
      # let(:block)     {}

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@context').must_equal(context) }
        it { instance.instance_variable_get('@model').must_equal(model) }
        it { instance.instance_variable_get('@value').must_equal(_value) }
        it { instance.instance_variable_get('@options').must_equal(options) }
      end

      describe '.build' do
        subject { described.build(context, model, _value, options) }

        it { subject.must_be_instance_of(Hash) }
      end

      describe '#attributes' do
        it { instance.must_respond_to(:attributes) }
      end

    end # Attributes

  end # DSL

end # Vedeu
