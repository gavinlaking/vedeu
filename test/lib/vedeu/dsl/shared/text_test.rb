require 'test_helper'

module Vedeu

  module DSL

    class TextTestClass
      include Vedeu::DSL::Text

    end

    describe Text do

      let(:instance) { Vedeu::DSL::TextTestClass.new }
      let(:value)    {}
      let(:options)  { {} }

      describe '#text' do
        subject { instance.text(value, options) }

        context 'when the model is a Vedeu::Interface' do
        end

        context 'when the model is a Vedeu::Line' do
        end

        context 'when the model is a Vedeu::Stream' do
        end
      end

    end # Text

  end # DSL

end # Vedeu
