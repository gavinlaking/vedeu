require 'test_helper'

module Vedeu

  module DSL

    describe Stream do

      let(:described) { Vedeu::DSL::Stream }
      let(:instance)  { described.new(model) }
      let(:model)     { mock('Vedeu::Stream') }
      let(:client)    {}

      describe '#initialize' do
        it { instance.must_be_instance_of(Vedeu::DSL::Stream) }
        it { instance.instance_variable_get('@model').must_equal(model) }
        it { instance.instance_variable_get('@client').must_equal(client) }
      end

      describe '#stream' do
        subject { instance.stream { } }

        context 'when the block is not given' do
          subject { instance.stream }

          it { proc { subject }.must_raise(InvalidSyntax) }
        end
      end

    end # Stream

  end # DSL

end # Vedeu
