require 'test_helper'

module Vedeu

  module DSL

    describe Text do

      let(:described) { Vedeu::DSL::Text }
      let(:instance)  { described.new(_value, options) }
      let(:_value)    { 'abcde' }
      let(:options)   {
        {
          align:    align,
          client:   client,
          colour:   colour,
          name:     _name,
          pad:      pad,
          parent:   parent,
          style:    style,
          truncate: truncate,
          width:    width,
          wordwrap: wordwrap,
        }
      }
      let(:align)    { :none }
      let(:client)   {}
      let(:colour)   {}
      let(:_name)    { :vedeu_dsl_text }
      let(:pad)      { ' ' }
      let(:parent)   {}
      let(:style)    {}
      let(:truncate) { false }
      let(:width)    { 2 }
      let(:wordwrap) { false }

      let(:geometry) { Vedeu::Geometries::Geometry.new(name: _name, width: 4) }

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
          let(:options) {}

          it { instance.instance_variable_get('@options').must_equal({}) }
        end
      end

      describe '#chars' do
        subject { instance.chars }

        context 'when the value is not given' do
          let(:_value) {}

          it { subject.must_equal([]) }
        end

        context 'when the value is not a String' do
          let(:_value) { :invalid }

          it { subject.must_equal([]) }
        end

        context 'when the value is given and a String' do
          context 'when the truncate option is set' do
            let(:truncate) { true }

            context 'when a width option is set' do
              let(:expected) {
                [
                  Vedeu::Views::Char.new(name: _name, value: 'a'),
                  Vedeu::Views::Char.new(name: _name, value: 'b'),
                ]
              }

              it { subject.must_equal(expected) }
            end

            context 'when a width option is not set' do
              let(:width) {}

              context 'when a name option is set' do
                let(:expected) {
                  [
                    Vedeu::Views::Char.new(name: _name, value: 'a'),
                    Vedeu::Views::Char.new(name: _name, value: 'b'),
                    Vedeu::Views::Char.new(name: _name, value: 'c'),
                    Vedeu::Views::Char.new(name: _name, value: 'd'),
                  ]
                }

                it { subject.must_equal(expected) }
              end

              context 'when a name option is not set' do
                let(:_name) {}
                let(:expected) {
                  [
                    Vedeu::Views::Char.new(name: _name, value: 'a'),
                    Vedeu::Views::Char.new(name: _name, value: 'b'),
                    Vedeu::Views::Char.new(name: _name, value: 'c'),
                    Vedeu::Views::Char.new(name: _name, value: 'd'),
                    Vedeu::Views::Char.new(name: _name, value: 'e'),
                  ]
                }

                it { subject.must_equal(expected) }
              end
            end
          end

          context 'when the truncate option is not set' do
            let(:expected) { [] }

            it { subject.must_equal(expected) }
          end

          context 'when the align option is set' do
            let(:align) { :centre }

            context 'when a width option is set' do
              let(:expected) {
                [
                  Vedeu::Views::Char.new(name: _name, value: 'a'),
                  Vedeu::Views::Char.new(name: _name, value: 'b'),
                  Vedeu::Views::Char.new(name: _name, value: 'c'),
                  Vedeu::Views::Char.new(name: _name, value: 'd'),
                  Vedeu::Views::Char.new(name: _name, value: 'e'),
                ]
              }

              it { subject.must_equal(expected) }
            end

            context 'when a width option is not set' do
              let(:width) {}

              context 'when a name option is set' do
                let(:expected) {
                  [
                    Vedeu::Views::Char.new(name: _name, value: 'a'),
                    Vedeu::Views::Char.new(name: _name, value: 'b'),
                    Vedeu::Views::Char.new(name: _name, value: 'c'),
                    Vedeu::Views::Char.new(name: _name, value: 'd'),
                    Vedeu::Views::Char.new(name: _name, value: 'e'),
                  ]
                }

                it { subject.must_equal(expected) }
              end

              context 'when a name option is not set' do
                let(:_name) {}
                let(:expected) {
                  [
                    Vedeu::Views::Char.new(name: _name, value: 'a'),
                    Vedeu::Views::Char.new(name: _name, value: 'b'),
                    Vedeu::Views::Char.new(name: _name, value: 'c'),
                    Vedeu::Views::Char.new(name: _name, value: 'd'),
                    Vedeu::Views::Char.new(name: _name, value: 'e'),
                  ]
                }

                it { subject.must_equal(expected) }
              end
            end
          end

          context 'when the align option is not set' do
            let(:expected) { [] }

            it { subject.must_equal(expected) }
          end
        end
      end

    end # Text

  end # DSL

end # Vedeu
