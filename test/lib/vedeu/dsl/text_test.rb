require 'test_helper'

module Vedeu

  module DSL

    describe Text do

      # let(:described) { Vedeu::DSL::Text }

      # describe '#text' do
      #   let(:_value)  {}
      #   let(:options) { {} }
      #   let(:modified_options) {
      #     {
      #       anchor: anchor,
      #       model:  model,
      #       name:   model.name,
      #       client: nil,
      #     }
      #   }
      #   let(:anchor)   { :text }
      #   let(:model)    { Vedeu::Views::Line.new }
      #   let(:instance) { Vedeu::DSL::Line.new(model) }

      #   subject { instance.text(_value, options) }

      #   it { instance.must_respond_to(:text=) }
      #   it { instance.must_respond_to(:align=) }
      #   it { instance.must_respond_to(:center=) }
      #   it { instance.must_respond_to(:centre=) }
      #   it { instance.must_respond_to(:left=) }
      #   it { instance.must_respond_to(:right=) }

      #   context 'when the model is a Vedeu::Views::View' do
      #     let(:model)    { Vedeu::Views::View.new }
      #     let(:instance) { Vedeu::Interfaces::DSL.new(model) }

      #     it { subject.must_be_instance_of(Vedeu::Views::Lines) }

      #     it 'adds the text to the model' do
      #       described.expects(:add).with(_value, modified_options)
      #       subject
      #     end
      #   end

      #   context 'when the model is a Vedeu::Views::Line' do
      #     let(:model)    { Vedeu::Views::Line.new }
      #     let(:instance) { Vedeu::DSL::Line.new(model) }

      #     it { subject.must_be_instance_of(Vedeu::Views::Streams) }

      #     it 'adds the text to the model' do
      #       described.expects(:add).with(_value, modified_options)
      #       subject
      #     end
      #   end

      #   context 'when the model is a Vedeu::Views::Stream' do
      #     let(:parent)   { Vedeu::Views::Line.new }
      #     let(:model)    { Vedeu::Views::Stream.new(parent: parent) }
      #     let(:instance) { Vedeu::DSL::Stream.new(model) }

      #     it { subject.must_be_instance_of(Vedeu::Views::Streams) }

      #     it 'adds the text to the model' do
      #       described.expects(:add).with(_value, modified_options)
      #       subject
      #     end
      #   end

      #   context 'alias methods' do
      #     context '#align' do
      #       let(:anchor) { :align }

      #       subject { instance.align(_value, options) }

      #       it 'adds the text to the model' do
      #         described.expects(:add).with(_value, modified_options)
      #         subject
      #       end
      #     end

      #     context '#center' do
      #       let(:anchor) { :center }

      #       subject { instance.center(_value, options) }

      #       it 'adds the text to the model' do
      #         described.expects(:add).with(_value, modified_options)
      #         subject
      #       end
      #     end

      #     context '#centre' do
      #       let(:anchor) { :centre }

      #       subject { instance.centre(_value, options) }

      #       it 'adds the text to the model' do
      #         described.expects(:add).with(_value, modified_options)
      #         subject
      #       end
      #     end

      #     context '#left' do
      #       let(:anchor) { :left }

      #       subject { instance.left(_value, options) }

      #       it 'adds the text to the model' do
      #         described.expects(:add).with(_value, modified_options)
      #         subject
      #       end
      #     end

      #     context '#right' do
      #       let(:anchor) { :right }

      #       subject { instance.right(_value, options) }

      #       it 'adds the text to the model' do
      #         described.expects(:add).with(_value, modified_options)
      #         subject
      #       end
      #     end
      #   end
      # end

    end # Text

  end # DSL

end # Vedeu
