require 'test_helper'

module Vedeu

  module DSL

    describe Text do

      let(:described) { Vedeu::DSL::Text }
      let(:instance)  { described.new(_value, options) }
      let(:_value)    { 'Some text...' }
      let(:options)   {
        Vedeu::DSL::ViewOptions.coerce({})
      }

      describe '#initialize' do
        subject { instance }

        context 'when the options is a Vedeu::DSL::ViewOptions object' do
          it { subject.instance_variable_get('@options').must_equal(options) }
        end

        context 'when the options is not a Vedeu::DSL::ViewOptions object' do
          let(:options) { {} }

          it { proc { subject }.must_raise(Vedeu::Error::Fatal) }
        end

        it { subject.must_be_instance_of(described) }

        context 'when the value is given' do
          it { subject.instance_variable_get('@value').must_equal(_value) }
        end

        context 'when the value is not given' do
          let(:_value) {}

          it { subject.instance_variable_get('@value').must_equal('') }
        end


        it { subject.instance_variable_get('@options').must_equal(options) }
      end

    end # Text

  end # DSL

end # Vedeu
