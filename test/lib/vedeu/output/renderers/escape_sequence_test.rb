require 'test_helper'

module Vedeu

  module Renderers

    describe EscapeSequence do

      let(:described) { Vedeu::Renderers::EscapeSequence }
      let(:instance)  { described.new(options) }
      let(:options)   { {} }
      let(:output)    {}

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@options').must_equal(options) }
      end

      describe '#render' do
        subject { instance.render(output) }

        it { subject.must_be_instance_of(String) }

        context 'when there is no output' do
          it { subject.must_equal('') }
        end

        context 'when there is output' do
          let(:output) {
            [
              Vedeu::Views::Char.new(value: 't',
                                     colour: {
                                       background: '#ff0000',
                                       foreground: '#ffffff'
                                     }),
              Vedeu::Views::Char.new(value: 'e',
                                     colour: {
                                       background: '#ffff00',
                                       foreground: '#000000'
                                     }),
              Vedeu::Views::Char.new(value: 's',
                                     colour: {
                                       background: '#00ff00',
                                       foreground: '#000000'
                                     }),
              Vedeu::Views::Char.new(value: 't',
                                     colour: {
                                       background: '#00ffff',
                                       foreground: '#000000'
                                     }),
             ]
          }

          it { subject.must_equal(
            "\\e[38;2;255;255;255m\\e[48;2;255;0;0mt\n" \
            "\\e[38;2;0;0;0m\\e[48;2;255;255;0me\n"     \
            "\\e[38;2;0;0;0m\\e[48;2;0;255;0ms\n"       \
            "\\e[38;2;0;0;0m\\e[48;2;0;255;255mt\n")
          }
        end
      end

    end # EscapeSequence

  end # Renderers

end # Vedeu
