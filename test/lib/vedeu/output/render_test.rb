require 'test_helper'

module Vedeu

  describe Render do

    before do
      Buffers.reset
      Cursors.reset
      Interfaces.reset

      Vedeu.interface('fluorine') do
        width  32
        height 3
        line 'this is the first'
        line 'this is the second and it is long'
        line 'this is the third, it is even longer and still truncated'
        line 'this should not render'
      end
    end

    describe '#initialize' do
      it 'returns an instance of itself' do
        interface = Interface.new
        Render.new(interface).must_be_instance_of(Render)
      end
    end

    describe '.call' do
      let(:interface) { Vedeu.use('fluorine') }

      before { interface.stubs(:in_focus?).returns(true) }

      it 'returns the content for the interface' do
        Render.call(interface).must_equal(
          "\e[1;1Hthis is the first" \
          "\e[2;1Hthis is the second and it is lon" \
          "\e[3;1Hthis is the third, it is even lo" \
        )
      end

      it 'returns a blank interface if there are no streams of text' do
        interface = Interface.new({
          name:     'fluorine',
          geometry: {
            width:  32,
            height: 3,
          },
          lines:    []
        })

        Render.call(interface).must_equal('')
      end

      it 'skips lines which have streams with no content' do
        interface = Interface.new({
          name:     'fluorine',
          geometry: {
            width:  32,
            height: 3,
          },
          lines:    [
            {
              streams: [{ text: 'this is the first' }]
            }, {
              streams: { text: '' }
            }, {
              streams: [
                { text: 'this is the third, ' },
                { text: 'it is even longer '  },
                { text: 'and still truncated' }
              ]
            }, {
              streams: [{ text: 'this should not render' }]
            }
          ]
        })
        Render.call(interface).must_equal(
          "\e[1;1Hthis is the first" \
          "\e[2;1H" \
          "\e[3;1Hthis is the third, it is even lo"
        )
      end

      it 'returns to using the presentation attributes of the line after a ' \
         'stream finishes' do
        Vedeu.interface 'oxygen' do
          width 40
          height 2
        end

        class OxygenView < Vedeu::View
          def render
            Vedeu.view 'oxygen' do
              line do
                colour background: '#000000', foreground: '#ffffff'
                stream do
                  text 'the grass is '
                end
                stream do
                  colour foreground: '#00ff00'
                  text 'green'
                end
                stream do
                  text ' and the sky is '
                end
                stream do
                  colour foreground: '#0000ff'
                  text 'blue'
                end
                stream do
                  text '.'
                end
              end
            end
          end
        end

        IO.console.stub(:print, nil) do
          OxygenView.render

          Compositor.render('oxygen').must_equal(
            [
              "\e[1;1Ht\e[38;2;255;255;255m\e[48;2;0;0;0mh\e[38;2;255;255;255m\e[48;2;0;0;0me\e[38;2;255;255;255m\e[48;2;0;0;0m \e[38;2;255;255;255m\e[48;2;0;0;0mg\e[38;2;255;255;255m\e[48;2;0;0;0mr\e[38;2;255;255;255m\e[48;2;0;0;0ma\e[38;2;255;255;255m\e[48;2;0;0;0ms\e[38;2;255;255;255m\e[48;2;0;0;0ms\e[38;2;255;255;255m\e[48;2;0;0;0m \e[38;2;255;255;255m\e[48;2;0;0;0mi\e[38;2;255;255;255m\e[48;2;0;0;0ms\e[38;2;255;255;255m\e[48;2;0;0;0m \e[38;2;255;255;255m\e[48;2;0;0;0m\e[38;2;0;255;0mg\e[38;2;255;255;255m\e[48;2;0;0;0m\e[38;2;0;255;0mr\e[38;2;255;255;255m\e[48;2;0;0;0m\e[38;2;0;255;0me\e[38;2;255;255;255m\e[48;2;0;0;0m\e[38;2;0;255;0me\e[38;2;255;255;255m\e[48;2;0;0;0m\e[38;2;0;255;0mn\e[38;2;255;255;255m\e[48;2;0;0;0m \e[38;2;255;255;255m\e[48;2;0;0;0ma\e[38;2;255;255;255m\e[48;2;0;0;0mn\e[38;2;255;255;255m\e[48;2;0;0;0md\e[38;2;255;255;255m\e[48;2;0;0;0m \e[38;2;255;255;255m\e[48;2;0;0;0mt\e[38;2;255;255;255m\e[48;2;0;0;0mh\e[38;2;255;255;255m\e[48;2;0;0;0me\e[38;2;255;255;255m\e[48;2;0;0;0m \e[38;2;255;255;255m\e[48;2;0;0;0ms\e[38;2;255;255;255m\e[48;2;0;0;0mk\e[38;2;255;255;255m\e[48;2;0;0;0my\e[38;2;255;255;255m\e[48;2;0;0;0m \e[38;2;255;255;255m\e[48;2;0;0;0mi\e[38;2;255;255;255m\e[48;2;0;0;0ms\e[38;2;255;255;255m\e[48;2;0;0;0m \e[38;2;255;255;255m\e[48;2;0;0;0m\e[38;2;0;0;255mb\e[38;2;255;255;255m\e[48;2;0;0;0m\e[38;2;0;0;255ml\e[38;2;255;255;255m\e[48;2;0;0;0m\e[38;2;0;0;255mu\e[38;2;255;255;255m\e[48;2;0;0;0m\e[38;2;0;0;255me\e[38;2;255;255;255m\e[48;2;0;0;0m.\e[38;2;255;255;255m\e[48;2;0;0;0m",

              "\e[1;1H\e[?25l"
            ]
          )
        end
      end
    end

  end # Render

end # Vedeu
