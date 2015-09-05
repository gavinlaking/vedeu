require 'test_helper'

module Vedeu

  module DSL

    describe Line do

      let(:described)  { Vedeu::DSL::Line }
      let(:instance)   { described.new(model) }
      let(:model)      { Vedeu::Views::Line.new(attributes) }
      let(:client)     {}
      let(:colour)     { Vedeu::Colour.new }
      let(:parent)     { Vedeu::Views::View.new }
      let(:style)      { Vedeu::Style.new }
      let(:_value)     { [] }
      let(:attributes) {
        {
          client: client,
          value:  _value,
          parent: parent,
          colour: colour,
          style:  style,
        }
      }


      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@model').must_equal(model) }
        it { instance.instance_variable_get('@client').must_equal(client) }
      end

      describe '#line' do
        let(:_value) { '' }

        subject {
          instance.line do
            # ...
          end
        }

        it { subject.must_be_instance_of(Vedeu::Views::Lines) }
        it { subject[0].must_be_instance_of(Vedeu::Views::Line) }

        context 'when the block is given' do
        end

        context 'when the block is not given' do
          context 'when the value is given' do
            subject { instance.line(_value) }
          end

          context 'when the value is not given' do
            let(:_value) {}

            subject { instance.line(_value) }

            it { proc { subject }.must_raise(Vedeu::Error::InvalidSyntax) }
          end
        end
      end

      describe '#streams' do
        context 'when the block is given' do
          subject {
            instance.streams do
              # ...
            end
          }

          it { subject.must_be_instance_of(Vedeu::Views::Streams) }
          it { subject[0].must_be_instance_of(Vedeu::Views::Stream) }
        end

        context 'when the block is not given' do
          it { proc { instance.streams }.must_raise(Vedeu::Error::InvalidSyntax) }
        end

        it { instance.must_respond_to(:stream) }
      end

    end # Line

  end # DSL

end # Vedeu
