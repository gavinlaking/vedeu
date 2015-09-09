require 'test_helper'

module Vedeu

  module Renderers

    describe EscapeSequence do

      let(:described) { Vedeu::Renderers::EscapeSequence }
      let(:instance)  { described.new(options) }
      let(:options)   { {} }
      let(:buffer) { Vedeu::Terminal::Buffer }

      before do
        Vedeu.stubs(:height).returns(2)
        Vedeu.stubs(:width).returns(4)
        Vedeu::Terminal::Buffer.reset
      end

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@options').must_equal(options) }
      end

      describe '#render' do
        subject { instance.render(buffer) }

        it { subject.must_be_instance_of(String) }

        context 'when there is an empty buffer' do
          let(:expected) { '' }

          it { subject.must_equal(expected) }
        end

        context 'when there is content on the buffer' do
          before do
            buffer.write(Vedeu::Views::Char.new(value: 't',
                                                colour: {
                                                  background: '#ff0000',
                                                  foreground: '#ffffff'
                                                }), 1, 1)
            buffer.write(Vedeu::Views::Char.new(value: 'e',
                                                colour: {
                                                  background: '#ffff00',
                                                  foreground: '#000000'
                                                }), 1, 2)
            buffer.write(Vedeu::Views::Char.new(value: 's',
                                                colour: {
                                                  background: '#00ff00',
                                                  foreground: '#000000'
                                                }), 1, 3)
            buffer.write(Vedeu::Views::Char.new(value: 't',
                                                colour: {
                                                  background: '#00ffff',
                                                  foreground: '#000000'
                                                }), 1, 4)
          end

          it { subject.must_equal(
              "\\e[38;2;255;255;255m\\e[48;2;255;0;0mt" \
              "\\e[38;2;0;0;0m\\e[48;2;255;255;0me"     \
              "\\e[38;2;0;0;0m\\e[48;2;0;255;0ms"       \
              "\\e[38;2;0;0;0m\\e[48;2;0;255;255mt"
            )
          }
        end
      end

    end # EscapeSequence

  end # Renderers

end # Vedeu
