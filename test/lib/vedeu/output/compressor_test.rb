# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Output

    describe Compressor do

      let(:described) { Vedeu::Output::Compressor }
      let(:instance)  { described.new(output) }
      let(:output)    {}
      let(:_name)     {}

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@output').must_equal(output) }
      end

      describe '.render' do
        let(:colour_1) {
          {
            foreground: '#ff0000'
          }
        }
        let(:colour_2) {
          {
            foreground: '#0000ff'
          }
        }

        subject { described.render(output) }

        context 'when there is no output' do
          it { subject.must_be_instance_of(Array) }
        end

        context 'when compression is enabled' do
          before { Vedeu.configure { compression(true) } }

          context 'when the output is all Vedeu::Cells::Char elements' do

            let(:output) {
              Vedeu::Models::Page.coerce([
                Vedeu::Cells::Char.new(value:    'Y',
                                       name:     _name,
                                       colour:   colour_1,
                                       position: [1, 1]),
                Vedeu::Cells::Char.new(value:    'e',
                                       name:     _name,
                                       colour:   colour_1,
                                       position: [1, 2]),
                Vedeu::Cells::Char.new(value:    's',
                                       name:     _name,
                                       colour:   colour_1,
                                       position: [1, 3])
              ])
            }
            let(:expected) {
              "\e[1;1H\e[38;2;255;0;0mY\e[0m" \
              "\e[1;2H\e[38;2;255;0;0me\e[0m" \
              "\e[1;3H\e[38;2;255;0;0ms\e[0m"
            }

            it { subject.must_be_instance_of(String) }

            it 'converts the non-Vedeu::Cells::Char elements into String ' \
               'elements' do
              subject.must_equal(expected)
            end
          end

          context 'when the output is all Vedeu::Cells::Char elements' do
            let(:output) {
              Vedeu::Models::Page.coerce([
                Vedeu::Cells::Char.new(value:    'a',
                                       name:     _name,
                                       colour:   colour_1,
                                       position: [1, 1]),
                Vedeu::Cells::Char.new(value:    'b',
                                       name:     _name,
                                       colour:   colour_1,
                                       position: [1, 2]),
                Vedeu::Cells::Char.new(value:    'c',
                                       name:     _name,
                                       colour:   colour_2,
                                       position: [1, 3]),
                Vedeu::Cells::Char.new(value:    'd',
                                       name:     _name,
                                       colour:   colour_2,
                                       position: [1, 4]),
              ])
            }
            let(:expected) {
              "\e[1;1H\e[38;2;255;0;0ma\e[0m" \
              "\e[1;2H\e[38;2;255;0;0mb\e[0m" \
              "\e[1;3H\e[38;2;0;0;255mc\e[0m" \
              "\e[1;4H\e[38;2;0;0;255md\e[0m"
            }

            it { subject.must_be_instance_of(String) }

            it 'compresses multiple colours and styles where possible' do
              subject.must_equal(expected)
            end
          end

          context 'when the output is not all Vedeu::Cells::Char elements' do
            let(:output) {
              Vedeu::Models::Page.coerce(
                Vedeu::Models::Row.coerce([
                  Vedeu::Cells::Char.new(name: _name,
                                         value: 'A',
                                         position: [1, 1]),
                  Vedeu::Cells::Escape.new(value: "\e[?25l"),
                  Vedeu::Cells::Char.new(name: _name,
                                         value: 'B',
                                         position: [1, 3]),
                ])
              )
            }
            let(:expected) { "\e[1;1HA\e[?25l\e[1;3HB\e[0m" }

            it { subject.must_be_instance_of(String) }

            it 'converts the non-Vedeu::Cells::Char elements into String ' \
               'elements' do
              subject.must_equal(expected)
            end
          end
        end

        context 'when compression is not enabled' do
          before { Vedeu.configure { compression(false) } }

          context 'when the output is all Vedeu::Cells::Char elements' do
            let(:output) {
              Vedeu::Models::Page.coerce([
                Vedeu::Cells::Char.new(value:  'Y',
                                       name:   _name,
                                       colour: colour_1),
                Vedeu::Cells::Char.new(value:  'e',
                                       name:   _name,
                                       colour: colour_1),
                Vedeu::Cells::Char.new(value:  's',
                                       name:   _name,
                                       colour: colour_1),
              ])
            }
            let(:expected) {
              "\e[38;2;255;0;0mY\e[0m" \
              "\e[38;2;255;0;0me\e[0m" \
              "\e[38;2;255;0;0ms\e[0m"
            }

            it { subject.must_be_instance_of(String) }

            it 'converts the non-Vedeu::Cells::Char elements into String ' \
               'elements' do
              subject.must_equal(expected)
            end
          end

          context 'when the output is all Vedeu::Cells::Char elements' do
            let(:output) {
              Vedeu::Models::Page.coerce([
                Vedeu::Cells::Char.new(value:  'a',
                                       name:   _name,
                                       colour: colour_1),
                Vedeu::Cells::Char.new(value:  'b',
                                       name:   _name,
                                       colour: colour_1),
                Vedeu::Cells::Char.new(value:  'c',
                                       name:   _name,
                                       colour: colour_2),
                Vedeu::Cells::Char.new(value:  'd',
                                       name:   _name,
                                       colour: colour_2),
              ])
            }
            let(:expected) {
              "\e[38;2;255;0;0ma\e[0m" \
              "\e[38;2;255;0;0mb\e[0m" \
              "\e[38;2;0;0;255mc\e[0m" \
              "\e[38;2;0;0;255md\e[0m"
            }

            it { subject.must_be_instance_of(String) }

            it 'compresses multiple colours and styles where possible' do
              subject.must_equal(expected)
            end
          end

          context 'when the output is not all Vedeu::Cells::Char elements' do
            let(:output) {
              Vedeu::Models::Page.coerce(
                Vedeu::Models::Row.coerce([
                  Vedeu::Cells::Char.new(name: _name, value: 'A'),
                  Vedeu::Cells::Escape.new(value: "\e[?25l"),
                  Vedeu::Cells::Char.new(name: _name, value: 'B'),
                ])
              )
            }

            it { subject.must_be_instance_of(String) }

            it 'converts the non-Vedeu::Cells::Char elements into String ' \
               'elements' do
              subject.must_equal("A\e[?25lB\e[0m")
            end
          end
        end
      end

      describe '#render' do
        it { instance.must_respond_to(:render) }
      end

    end # Compressor

  end # Output

end # Vedeu
