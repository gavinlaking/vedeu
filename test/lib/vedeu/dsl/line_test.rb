require 'test_helper'

module Vedeu

  module DSL

    describe Line do

      let(:described) { Vedeu::DSL::Line }
      let(:instance)  { described.new(model) }
      let(:model)     { Vedeu::Line.new(streams, parent, colour, style) }
      let(:streams)   { [] }
      let(:parent)    { Vedeu::Interface.new }
      let(:colour)    { Vedeu::Colour.new }
      let(:style)     { Vedeu::Style.new }

      describe '#initialize' do
        subject { instance }

        it { return_type_for(subject, Vedeu::DSL::Line) }
        it { subject.instance_variable_get('@model').must_equal(model) }
      end

      describe '#line' do
        let(:value) { '' }

        subject { instance.line(value) }

        it { return_type_for(subject, Vedeu::Model::Collection) }

        it { return_type_for(subject.first, Vedeu::Line) }
      end

      describe '#streams' do
        context 'when the block is given' do
          subject {
            instance.streams do
              # ...
            end
          }

          it { return_type_for(subject, Vedeu::Model::Collection) }

          it { return_type_for(subject.first, Vedeu::Stream) }
        end

        context 'when the block is not given' do
          subject { instance.streams }

          it { proc { subject }.must_raise(InvalidSyntax) }
        end
      end

    end # Line

  end # DSL

end # Vedeu
