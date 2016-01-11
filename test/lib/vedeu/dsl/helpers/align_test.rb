# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module DSL

    describe Align do

      let(:described) { Vedeu::DSL::Align }
      let(:instance)  { described.new(_value, options) }
      let(:_value)    { 'Some text...' }
      let(:options)   {
        {
          align: align,
          name:  _name,
          pad:   pad,
          width: width,
        }
      }
      let(:align) { :right }
      let(:_name) { :vedeu_dsl_align }
      let(:pad)   { ' ' }
      let(:width) { 20 }
      let(:geometry) {
        Vedeu::Geometries::Geometry.new(name: _name, width: 30)
      }

      before { Vedeu.geometries.stubs(:by_name).returns(geometry) }

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
              align: :left,
              name:  nil,
              pad:   ' ',
              width: nil,
            }
          }

          it { instance.instance_variable_get('@options').must_equal(expected) }
        end
      end

      describe '#text' do
        subject { instance.text }

        context 'when the align option is not set' do
          let(:align) {}

          it { subject.must_equal(_value) }
        end

        context 'when the align option is set to :left' do
          let(:align) { :left }

          context 'when a custom pad character is given' do
            let(:pad)      { '#' }
            let(:expected) { 'Some text...########' }

            it { subject.must_equal(expected) }
          end

          context 'when a width is given' do
            let(:expected) { 'Some text...        ' }

            it { subject.must_equal(expected) }
          end

          context 'when a width is not given' do
            let(:width)    {}
            let(:expected) { 'Some text...' }

            it 'uses the width of the named geometry' do
              subject.must_equal(expected)
            end
          end
        end

        context 'when the align option is set to :centre' do
          let(:align) { :centre }

          context 'when a width is given' do
            let(:expected) { '    Some text...    ' }

            it { subject.must_equal(expected) }
          end

          context 'when a width is not given' do
            let(:width)    {}
            let(:expected) { '         Some text...         ' }

            it 'uses the width of the named geometry' do
              subject.must_equal(expected)
            end
          end
        end

        context 'when the align option is set to :right' do
          let(:align) { :right }

          context 'when a width is given' do
            let(:expected) { '        Some text...' }

            it { subject.must_equal(expected) }
          end

          context 'when a width is not given' do
            let(:width)    {}
            let(:expected) { '                  Some text...' }

            it 'uses the width of the named geometry' do
              subject.must_equal(expected)
            end
          end
        end

        context 'when the align option is invalid' do
          let(:align)    { :invalid }
          let(:expected) { 'Some text...' }

          it { subject.must_equal(expected) }
        end
      end

    end # Align

  end # DSL

end # Vedeu
