require 'test_helper'

module Vedeu

  module DSL

    describe Truncate do

      let(:described) { Vedeu::DSL::Truncate }
      let(:instance)  { described.new(_value, options) }
      let(:_value)    {}
      let(:options)   { {} }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@value').must_equal(_value) }
        it { instance.instance_variable_get('@options').must_equal(options) }
      end

    end # Truncate

  end # DSL

end # Vedeu
