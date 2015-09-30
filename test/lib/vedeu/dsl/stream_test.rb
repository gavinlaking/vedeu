require 'test_helper'

module Vedeu

  module DSL

    describe Stream do

      let(:described) { Vedeu::DSL::Stream }
      let(:instance)  { described.new(model) }
      let(:model)     { Vedeu::Views::Stream.new(parent: parent) }
      let(:parent)    { Vedeu::Views::Line.new }

      describe '#stream' do
        subject { instance.stream { } }

        it { subject.must_be_instance_of(Vedeu::Views::Streams) }

        context 'when the block is not given' do
          subject { instance.stream }

          it { proc { subject }.must_raise(Vedeu::Error::RequiresBlock) }
        end
      end

    end # Stream

  end # DSL

end # Vedeu
