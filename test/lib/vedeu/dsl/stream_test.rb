require 'test_helper'

module Vedeu

  module DSL

    describe Stream do

      let(:described) { Vedeu::DSL::Stream }
      let(:instance)  { described.new(model) }
      let(:model)     { Vedeu::Stream.new(parent: parent) }
      let(:client)    {}
      let(:parent)    { Vedeu::Line.new }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@model').must_equal(model) }
        it { instance.instance_variable_get('@client').must_equal(client) }
      end

      describe '#stream' do
        subject { instance.stream { } }

        it { subject.must_be_instance_of(Vedeu::Streams) }

        context 'when the block is not given' do
          subject { instance.stream }

          it { proc { subject }.must_raise(InvalidSyntax) }
        end
      end

    end # Stream

  end # DSL

end # Vedeu
