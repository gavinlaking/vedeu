require 'test_helper'

module Vedeu

  module DSL

    describe Line do

      let(:described) { Vedeu::DSL::Line.new(model) }
      let(:model)     { Vedeu::Line.new(streams, parent, colour, style) }
      let(:streams)   { [] }
      let(:parent)    { mock('Interface') }
      let(:colour)    { mock('Colour') }
      let(:style)     { mock('Style') }

      describe '#initialize' do
        it { return_type_for(described, Vedeu::DSL::Line) }
        it { assigns(described, '@model', model) }
      end

      describe '#line' do
        it { skip }
      end

      describe '#stream' do
        # subject { described.stream }

        # it { return_type_for(subject, Array) }

        it { skip }
      end

      describe '#streams' do
        context 'when the block is given' do
          subject {
            described.streams do
              # ...
            end
          }

          # it { return_type_for(subject, Vedeu::Model::Streams) }

          it { skip }
        end

        context 'when the block is not given' do
          subject { described.streams }

          it { proc { subject }.must_raise(InvalidSyntax) }
        end
      end

    end # Line

  end # DSL

end # Vedeu
