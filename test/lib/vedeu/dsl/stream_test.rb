require 'test_helper'

module Vedeu

  module DSL

    describe Stream do

      let(:described) { Vedeu::DSL::Stream.new(model) }
      let(:model)     { Vedeu::Stream.new(value, parent, colour, style) }
      let(:value)     {}
      let(:parent)    { mock('Line') }
      let(:colour)    { mock('Colour') }
      let(:style)     { mock('Style') }

      describe '#initialize' do
        it { return_type_for(described, Vedeu::DSL::Stream) }
        it { described.instance_variable_get('@model').must_equal(model) }
      end

      describe '#align' do
        let(:value)   { 'silicon' }
        let(:options) { {} }

        subject { described.align(value, options) }

        it { return_type_for(subject, String) }

        it 'aligns the value according to the options provided' do
          return_value_for(subject, 'siliconsilicon')
        end
      end

      describe '#text' do
        let(:value) { 'gallium' }

        subject { described.text(value) }

        it { return_type_for(subject, String) }
        it { return_value_for(subject, 'galliumgallium') }
      end

    end # Stream

  end # DSL

end # Vedeu
