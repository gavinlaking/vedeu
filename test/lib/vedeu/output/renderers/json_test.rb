require 'test_helper'

module Vedeu

  module Renderers

    describe JSON do

      let(:described) { Vedeu::Renderers::JSON }
      let(:instance)  { described.new(options) }
      let(:options)   { {} }
      let(:buffer)    { Vedeu::Terminal::Buffer }

      before do
        ::File.stubs(:write)
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
          let(:expected) {
            ::JSON.pretty_generate([
              {
                'colour': '', 'style': '', 'value': '', 'y': 1, 'x': 1
              },{
                'colour': '', 'style': '', 'value': '', 'y': 1, 'x': 2
              },{
                'colour': '', 'style': '', 'value': '', 'y': 1, 'x': 3
              },{
                'colour': '', 'style': '', 'value': '', 'y': 1, 'x': 4
              },{
                'colour': '', 'style': '', 'value': '', 'y': 2, 'x': 1
              },{
                'colour': '', 'style': '', 'value': '', 'y': 2, 'x': 2
              },{
                'colour': '', 'style': '', 'value': '', 'y': 2, 'x': 3
              },{
                'colour': '', 'style': '', 'value': '', 'y': 2, 'x': 4
              }
            ])
          }
          it { subject.must_equal(expected) }
        end

        context 'when there is content on the buffer' do
          let(:colour) {
            Vedeu::Colours::Colour.new(foreground: '#ff0000',
                                       background: '#ffffff')
          }
          let(:output) {
            [
              [
                Vedeu::Views::Char.new(value: 'a',
                                       colour: colour,
                                       parent: parent,
                                       position: Vedeu::Geometry::Position[5, 3])
              ]
            ]
          }
          let(:parent)   {}
          let(:expected) {
            ::JSON.pretty_generate([
              {
                'colour': '', 'style': '', 'value': '', 'y': 1, 'x': 1
              },{
                'colour': '', 'style': '', 'value': '', 'y': 1, 'x': 2
              },{
                'colour': '', 'style': '', 'value': '', 'y': 1, 'x': 3
              },{
                'colour': '', 'style': '', 'value': '', 'y': 1, 'x': 4
              },{
                'colour': '', 'style': '', 'value': '', 'y': 2, 'x': 1
              },{
                'border': '',
                'colour': {
                  'background': "\u001b[48;2;255;0;0m",
                  'foreground': "\u001b[38;2;255;255;255m"
                },
                'parent': {},
                'position': {
                  'y': nil,
                  'x': nil
                },
                'style': '',
                'value': 't'
              },{
                'border': '',
                'colour': {
                  'background': "\u001b[48;2;255;255;0m",
                  'foreground': "\u001b[38;2;0;0;0m"
                },
                'parent': {},
                'position': {
                  'y': nil,
                  'x': nil
                },
                'style': '',
                'value': 'e'
              },{
                'border': '',
                'colour': {
                  'background': "\u001b[48;2;0;255;0m",
                  'foreground': "\u001b[38;2;0;0;0m"
                },
                'parent': {},
                'position': {
                  'y': nil,
                  'x': nil
                },
                'style': '',
                'value': 's'
              },{
                'border': '',
                'colour': {
                  'background': "\u001b[48;2;0;255;255m",
                  'foreground': "\u001b[38;2;0;0;0m"
                },
                'parent': {},
                'position': {
                  'y': nil,
                  'x': nil
                },
                'style': '',
                'value': 't'
              }
            ])
          }

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

          it { subject.must_be_instance_of(String) }
          it { subject.must_equal(expected) }
        end
      end

    end # JSON

  end # Renderers

end # Vedeu
