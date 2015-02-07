require 'test_helper'

module Vedeu

  module DSL

    describe Line do

      let(:described) { Vedeu::DSL::Line }
      let(:instance)  { described.new(model) }
      let(:model)     { Vedeu::Line.new(streams, parent, colour, style) }
      let(:client)    {}
      let(:streams)   { [] }
      let(:parent)    { Vedeu::Interface.new }
      let(:colour)    { Vedeu::Colour.new }
      let(:style)     { Vedeu::Style.new }

      describe '#initialize' do
        subject { instance }

        it { subject.must_be_instance_of(Vedeu::DSL::Line) }
        it { subject.instance_variable_get('@model').must_equal(model) }
        it { subject.instance_variable_get('@client').must_equal(client) }
      end

      describe '#line' do
        let(:value) { '' }

        subject {
          instance.line do
            # ...
          end
        }

        it { subject.must_be_instance_of(Vedeu::Model::Collection) }

        it { subject.first.must_be_instance_of(Vedeu::Line) }
      end

      describe '#streams' do
        context 'when the block is given' do
          subject {
            instance.streams do
              # ...
            end
          }

          it { subject.must_be_instance_of(Vedeu::Model::Collection) }

          it { subject.first.must_be_instance_of(Vedeu::Stream) }
        end

        context 'when the block is not given' do
          it { proc { instance.streams }.must_raise(InvalidSyntax) }
        end
      end

    end # Line

  end # DSL

end # Vedeu
