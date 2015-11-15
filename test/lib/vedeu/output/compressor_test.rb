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
        it { instance.instance_variable_get('@colour').must_equal('') }
        it { instance.instance_variable_get('@style').must_equal('') }
      end

      describe '.render' do
        subject { described.render(output) }

        it { subject.must_be_instance_of(String) }

        context 'when compression is enabled' do
          before { Vedeu.configure { compression(true) } }

          context 'when the output is all Vedeu::Views::Char elements' do
            let(:output) {
              Vedeu::Models::Page.coerce([
                Vedeu::Views::Char.new(value:    'Y',
                                       name:     _name,
                                       colour:   { foreground: '#ff0000' },
                                       position: [1, 1]),
                Vedeu::Views::Char.new(value:    'e',
                                       name:     _name,
                                       colour:   { foreground: '#ff0000' },
                                       position: [1, 2]),
                Vedeu::Views::Char.new(value:    's',
                                       name:     _name,
                                       colour:   { foreground: '#ff0000' },
                                       position: [1, 3])
              ])
            }
            it 'converts the non-Vedeu::Views::Char elements into String ' \
               'elements' do
              # subject.must_equal("\e[1;1H\e[38;2;255;0;0mYes")
              subject.must_equal("\e[1;1H\e[38;2;255;0;0mY\e[1;2He\e[1;3Hs")
            end
          end

          context 'when the output is all Vedeu::Views::Char elements' do
            let(:output) {
              Vedeu::Models::Page.coerce([
                Vedeu::Views::Char.new(value:    'a',
                                       name:     _name,
                                       colour:   { foreground: '#ff0000' },
                                       position: [1, 1]),
                Vedeu::Views::Char.new(value:    'b',
                                       name:     _name,
                                       colour:   { foreground: '#ff0000' },
                                       position: [1, 2]),
                Vedeu::Views::Char.new(value:    'c',
                                       name:     _name,
                                       colour:   { foreground: '#0000ff' },
                                       position: [1, 3]),
                Vedeu::Views::Char.new(value:    'd',
                                       name:     _name,
                                       colour:   { foreground: '#0000ff' },
                                       position: [1, 4]),
              ])
            }
            it 'compresses multiple colours and styles where possible' do
              # subject.must_equal("\e[1;1H\e[38;2;255;0;0mab\e[38;2;0;0;255mcd")
              subject.must_equal("\e[1;1H\e[38;2;255;0;0ma\e[1;2Hb\e[1;3H\e[38;2;0;0;255mc\e[1;4Hd")
            end
          end

          context 'when the output is not all Vedeu::Views::Char ' \
                  'elements' do
            let(:output) {
              Vedeu::Models::Page.coerce([
                Vedeu::Views::Char.new(name: _name, value: 'N', position: [1, 1]),
                Vedeu::Models::Escape.new(value: "\e[?25l"),
                Vedeu::Views::Char.new(name: _name, value: 't', position: [1, 3]),
              ])
            }
            it 'converts the non-Vedeu::Views::Char elements into String ' \
               'elements' do
              # subject.must_equal("\e[1;1HN\e[?25lt")
              subject.must_equal("\e[1;1HN\e[1;1H\e[?25l\e[1;3Ht")
            end
          end
        end

        context 'when compression is not enabled' do
          before { Vedeu.configure { compression(false) } }

          context 'when the output is all Vedeu::Views::Char elements' do
            let(:output) {
              Vedeu::Models::Page.coerce([
                Vedeu::Views::Char.new(value:  'Y',
                                       name:   _name,
                                       colour: { foreground: '#ff0000' }),
                Vedeu::Views::Char.new(value:  'e',
                                       name:   _name,
                                       colour: { foreground: '#ff0000' }),
                Vedeu::Views::Char.new(value:  's',
                                       name:   _name,
                                       colour: { foreground: '#ff0000' }),
              ])
            }
            it 'converts the non-Vedeu::Views::Char elements into String ' \
               'elements' do
              subject.must_equal(
                "\e[38;2;255;0;0mY\e[38;2;255;0;0me\e[38;2;255;0;0ms"
              )
            end
          end

          context 'when the output is all Vedeu::Views::Char elements' do
            let(:output) {
              Vedeu::Models::Page.coerce([
                Vedeu::Views::Char.new(value:  'a',
                                       name:   _name,
                                       colour: { foreground: '#ff0000' }),
                Vedeu::Views::Char.new(value:  'b',
                                       name:   _name,
                                       colour: { foreground: '#ff0000' }),
                Vedeu::Views::Char.new(value:  'c',
                                       name:   _name,
                                       colour: { foreground: '#0000ff' }),
                Vedeu::Views::Char.new(value:  'd',
                                       name:   _name,
                                       colour: { foreground: '#0000ff' }),
              ])
            }
            it 'compresses multiple colours and styles where possible' do
              subject.must_equal(
                "\e[38;2;255;0;0ma" \
                "\e[38;2;255;0;0mb" \
                "\e[38;2;0;0;255mc" \
                "\e[38;2;0;0;255md"
              )
            end
          end

          context 'when the output is not all Vedeu::Views::Char elements' do
            let(:output) {
              Vedeu::Models::Page.coerce([
                Vedeu::Views::Char.new(name: _name, value: 'N'),
                Vedeu::Models::Escape.new(value: "\e[?25l"),
                Vedeu::Views::Char.new(name: _name, value: 't'),
              ])
            }
            it 'converts the non-Vedeu::Views::Char elements into String ' \
               'elements' do
              subject.must_equal("N\e[1;1H\e[?25lt")
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
