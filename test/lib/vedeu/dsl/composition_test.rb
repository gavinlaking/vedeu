require 'test_helper'

module Vedeu

  module DSL

    describe Composition do

      let(:described) { Vedeu::DSL::Composition }
      let(:instance)  { described.new(model) }
      let(:model)     { Vedeu::Composition.new }
      let(:client)    {}

      describe '#initialize' do
        it { instance.must_be_instance_of(Vedeu::DSL::Composition) }
        it { instance.instance_variable_get('@model').must_equal(model) }
        it { instance.instance_variable_get('@client').must_equal(client) }
      end

      describe '#view' do
        subject {
          instance.view('dysprosium') do
            # ...
          end
        }

        it { subject.must_be_instance_of(Vedeu::Interfaces) }
        it { subject.first.must_be_instance_of(Vedeu::Interface) }

        context 'when the block is not given' do
          it { proc { instance.view }.must_raise(InvalidSyntax) }
        end
      end

    end # Composition

  end # DSL

end # Vedeu
