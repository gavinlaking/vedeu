require 'test_helper'

module Vedeu

  module DSL

    describe Text do

      describe '#text' do
        let(:_value)  {}
        let(:options) { {} }
        let(:modified_options) {
          {
            anchor: anchor,
            model:  model,
            name:   model.name,
            client: nil,
          }
        }
        let(:anchor)   { :text }
        let(:model)    { Vedeu::Views::Line.new }
        let(:instance) { Vedeu::DSL::Line.new(model) }

        subject { instance.text(_value, options) }

        it { instance.must_respond_to(:text=) }
        it { instance.must_respond_to(:align=) }
        it { instance.must_respond_to(:center=) }
        it { instance.must_respond_to(:centre=) }
        it { instance.must_respond_to(:left=) }
        it { instance.must_respond_to(:right=) }

        context 'when the model is a Vedeu::Views::View' do
          let(:model)    { Vedeu::Views::View.new }
          let(:instance) { Vedeu::Interfaces::DSL.new(model) }

          it { subject.must_be_instance_of(Vedeu::Views::Lines) }

          it 'adds the text to the model' do
            Vedeu::Output::Text.expects(:add).with(_value, modified_options)
            subject
          end
        end

        context 'when the model is a Vedeu::Views::Line' do
          let(:model)    { Vedeu::Views::Line.new }
          let(:instance) { Vedeu::DSL::Line.new(model) }

          it { subject.must_be_instance_of(Vedeu::Views::Streams) }

          it 'adds the text to the model' do
            Vedeu::Output::Text.expects(:add).with(_value, modified_options)
            subject
          end
        end

        context 'when the model is a Vedeu::Views::Stream' do
          let(:parent)   { Vedeu::Views::Line.new }
          let(:model)    { Vedeu::Views::Stream.new(parent: parent) }
          let(:instance) { Vedeu::DSL::Stream.new(model) }

          it { subject.must_be_instance_of(Vedeu::Views::Streams) }

          it 'adds the text to the model' do
            Vedeu::Output::Text.expects(:add).with(_value, modified_options)
            subject
          end
        end

        context 'alias methods' do
          context '#align' do
            let(:anchor) { :align }

            it 'adds the text to the model' do
              Vedeu::Output::Text.expects(:add).with(_value, modified_options)
              instance.align(_value, options)
            end
          end

          context '#center' do
            let(:anchor) { :center }

            it 'adds the text to the model' do
              Vedeu::Output::Text.expects(:add).with(_value, modified_options)
              instance.center(_value, options)
            end
          end

          context '#centre' do
            let(:anchor) { :centre }

            it 'adds the text to the model' do
              Vedeu::Output::Text.expects(:add).with(_value, modified_options)
              instance.centre(_value, options)
            end
          end

          context '#left' do
            let(:anchor) { :left }

            it 'adds the text to the model' do
              Vedeu::Output::Text.expects(:add).with(_value, modified_options)
              instance.left(_value, options)
            end
          end

          context '#right' do
            let(:anchor) { :right }

            it 'adds the text to the model' do
              Vedeu::Output::Text.expects(:add).with(_value, modified_options)
              instance.right(_value, options)
            end
          end
        end
      end

    end # Text

  end # DSL

end # Vedeu
