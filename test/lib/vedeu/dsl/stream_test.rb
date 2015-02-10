require 'test_helper'

module Vedeu

  module DSL

    describe Stream do

      let(:described) { Vedeu::DSL::Stream }
      let(:instance)  { described.new(model) }
      let(:model)     { mock('Vedeu::Stream') }
      let(:client)    {}

      describe '#initialize' do
        subject { instance }

        it { subject.must_be_instance_of(Vedeu::DSL::Stream) }
        it { subject.instance_variable_get('@model').must_equal(model) }
        it { subject.instance_variable_get('@client').must_equal(client) }
      end

    end # Stream

  end # DSL

end # Vedeu
