require 'test_helper'

module Vedeu

  module DSL

    describe Truncate do

      let(:described) { Vedeu::DSL::Truncate }
      let(:instance)  { described.new(_value, options) }
      let(:_value)    { 'abcdefghijklmnopqrstuvwxyz' }
      let(:options)   {
        {
          name:     _name,
          truncate: truncate,
          width:    width,
        }
      }
      let(:_name)    { :vedeu_dsl_truncate }
      let(:truncate) { true }
      let(:width)    { 15 }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }

        context 'when the value is given' do
          it { instance.instance_variable_get('@value').must_equal(_value) }
        end

        context 'when the value is not given' do
          let(:_value) {}

          it { instance.instance_variable_get('@value').must_equal('') }
        end

        context 'when the options are given' do
          it { instance.instance_variable_get('@options').must_equal(options) }
        end

        context 'when the options are not given' do
          let(:options)  { {} }
          let(:expected) {
            {
              name:     nil,
              truncate: false,
              width:    nil,
            }
          }

          it { instance.instance_variable_get('@options').must_equal(expected) }
        end
      end

      describe '#text' do
        subject { instance.text }

        context 'when the option to truncate is set to true' do
          context 'when the width option is given' do
            let(:expected) { 'abcdefghijklmno' }

            it { subject.must_equal(expected) }
          end

          context 'when the width option is not given' do
            let(:width) {}

            context 'when the name option is given' do
              let(:geometry) {
                Vedeu::Geometries::Geometry.new(name: _name, width: 20)
              }
              let(:expected) { 'abcdefghijklmnopqrst' }

              before { Vedeu.geometries.stubs(:by_name).returns(geometry) }

              it { subject.must_equal(expected) }
            end

            context 'when the name option is not given' do
              let(:_name) {}

              it { subject.must_equal(_value) }
            end
          end
        end

        context 'when the option to truncate is set to false' do
          let(:truncate) { false }

          it { subject.must_equal(_value) }
        end
      end

    end # Truncate

  end # DSL

end # Vedeu
