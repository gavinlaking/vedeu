require 'test_helper'

module Vedeu

  module DSL

    describe Composition do

      let(:described) { Vedeu::DSL::Composition }
      let(:instance)  { described.new(model) }
      let(:model)     { Vedeu::Composition.new }

      describe '#initialize' do
        subject { instance }

        it { subject.must_be_instance_of(Vedeu::DSL::Composition) }
        it { subject.instance_variable_get('@model').must_equal(model) }
      end

      describe '#view' do
        let(:interface_name) { 'dysprosium' }

        subject {
          instance.view(interface_name) do
            name 'calcium'
          end
        }

        it { subject.must_be_instance_of(Vedeu::Model::Collection) }

        it { subject.first.must_be_instance_of(Vedeu::Interface) }

        it 'overrides the method argument name with the DSL given name' do
          subject.first.name.must_equal('calcium')
        end

        context 'when the block is not given' do
          subject { instance.view }

          it { proc { subject }.must_raise(InvalidSyntax) }
        end
      end

    end # Composition

  end # DSL

end # Vedeu
