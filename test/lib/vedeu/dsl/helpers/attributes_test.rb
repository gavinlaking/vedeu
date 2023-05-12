# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module DSL

    describe Attributes do

      let(:described) { Vedeu::DSL::Attributes }
      let(:instance)  { described.new(context, model, _value, options) }
      let(:context)   {}
      let(:model)     { Vedeu::Views::View.new(name: _name) }
      let(:_value)    { 'Some text...' }
      let(:options)   {
        {
          align:    align,
          colour:   colour,
          pad:      pad,
          style:    style,
          truncate: truncate,
          width:    width,
          wordwrap: wordwrap,
        }
      }
      # let(:block)     {}
      let(:align)    {}
      let(:colour)   {}
      let(:_name)    { :vedeu_dsl_attributes_model }
      let(:pad)      {}
      let(:style)    {}
      let(:truncate) {}
      let(:width)    {}
      let(:wordwrap) {}

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@context').must_equal(context) }
        it { instance.instance_variable_get('@model').must_equal(model) }

        context 'when the value is nil' do
          let(:_value) {}

          it { instance.instance_variable_get('@value').must_equal('') }
        end

        context 'when the value is not nil' do
          it { instance.instance_variable_get('@value').must_equal(_value) }
        end

        context 'when the options are nil' do
          let(:options) {}

          it { instance.instance_variable_get('@options').must_equal({}) }
        end

        context 'when the options are not nil' do
          it { instance.instance_variable_get('@options').must_equal(options) }
        end
      end

      describe '.build' do
        subject { described.build(context, model, _value, options) }

        it { subject.must_be_instance_of(Hash) }

        context 'when there is no align option' do
          it { subject[:align].value.must_equal(:none) }
        end

        context 'when there is an align option' do
          let(:align) { :center }

          it { subject[:align].value.must_equal(:centre) }

          context 'when the align option is invalid' do
            let(:align) { :invalid }

            it { subject[:align].value.must_equal(:none) }
          end
        end

        context 'when there are no colour options' do
          it { subject[:colour].must_be_instance_of(Vedeu::Colours::Colour) }
        end

        context 'when there are colour options' do
          let(:colour) {
            {
              background: '#000088',
              foreground: '#ffff00',
            }
          }

          it { subject[:colour].must_be_instance_of(Vedeu::Colours::Colour) }
          it do
            subject[:colour].background.must_be_instance_of(Vedeu::Colours::Background)
          end
          it { subject[:colour].background.value.must_equal('#000088') }
          it do
            subject[:colour].foreground.must_be_instance_of(Vedeu::Colours::Foreground)
          end
          it { subject[:colour].foreground.value.must_equal('#ffff00') }
        end

        context 'when the model has a name' do
          it { subject[:name].must_equal(_name) }
        end

        context 'when the model does not have a name' do
          let(:_name) {}

          it { assert_nil(subject[:name]) }
        end

        context 'when the model has a name' do
          it { subject[:name].must_equal(_name) }
        end

        context 'when the model does not have a name' do
          let(:_name) {}

          it { assert_nil(subject[:name]) }
        end

        context 'when the pad option is nil' do
          let(:pad) {}

          it { subject[:pad].must_equal(' ') }
        end

        context 'when the pad option is not a string' do
          let(:pad) { 44 }

          it { subject[:pad].must_equal('4') }
        end

        context 'when the pad is a multi-character string' do
          let(:pad) { 'multi' }

          it { subject[:pad].must_equal('m') }
        end

        context 'when there are no style options' do
          it { subject[:style].must_be_instance_of(Vedeu::Presentation::Style) }
          it { assert_nil(subject[:style].value) }
        end

        context 'when there are style options' do
          let(:style) { [:bold, :underline] }

          it do
            Vedeu::Presentation::Style.expects(:coerce).with(options[:style])
            subject
          end
          it { subject[:style].must_be_instance_of(Vedeu::Presentation::Style) }
          it { subject[:style].value.must_equal(style) }
        end

        context 'when the truncate option is true' do
          let(:truncate) { true }

          it { subject[:truncate].must_equal(true) }
        end

        context 'when the truncate option is not given or false' do
          it { subject[:truncate].must_equal(false) }
        end

        context 'when the width option is given' do
          let(:width) { 15 }

          it { subject[:width].must_equal(width) }
        end

        context 'when the width option is not given' do
          context 'when the name option is given' do
            let(:geometry) {
              Vedeu::Geometries::Geometry.new(name: _name, width: 20)
            }

            before { Vedeu.geometries.stubs(:by_name).returns(geometry) }

            it { subject[:width].must_equal(20) }
          end

          context 'when the name option is not given' do
            let(:_name) {}

            it { assert_nil(subject[:width]) }
          end
        end

        context 'when the wordwrap option is true' do
          let(:wordwrap) { true }

          it { subject[:wordwrap].must_equal(true) }
        end

        context 'when the wordwrap option is not given or false' do
          it { subject[:wordwrap].must_equal(false) }
        end
      end

      describe '#attributes' do
        it { instance.must_respond_to(:attributes) }
      end

    end # Attributes

  end # DSL

end # Vedeu
