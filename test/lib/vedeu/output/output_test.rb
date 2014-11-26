require 'test_helper'

module Vedeu

  describe Output do

    before do
      Buffers.reset
      Cursors.reset
      Interfaces.reset

      Terminal.console.stubs(:print)

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
        interface = mock('Interface')
        Output.new(interface).must_be_instance_of(Output)
      end
    end

    describe '.clear' do
      it 'returns the escape sequence to clear the whole interface' do
        interface = Interface.new({
          name:   'Output.clear',
          geometry: {
            width:  5,
            height: 2
          }
        })
        Output.clear(interface).must_equal([
          "\e[1;1H     \e[1;1H" \
          "\e[2;1H     \e[2;1H"
        ])
      end

      it 'returns the escape sequence to clear the whole interface with specified colours' do
        interface = Interface.new({
          name:   'Output.clear',
          geometry: {
            width:  5,
            height: 2,
          },
          colour: {
            foreground: '#00ff00',
            background: '#ffff00'
          }
        })
        Output.clear(interface).must_equal([
          "\e[38;2;0;255;0m\e[48;2;255;255;0m" \
          "\e[1;1H     \e[1;1H" \
          "\e[2;1H     \e[2;1H"
        ])
      end
    end

    describe '.render' do
      let(:interface) { Vedeu.use('fluorine') }

      before { interface.stubs(:in_focus?).returns(true) }

      it 'returns the content for the interface' do
        Output.render(interface).must_equal(
          "\e[1;1H                                \e[1;1H" \
          "\e[2;1H                                \e[2;1H" \
          "\e[3;1H                                \e[3;1H" \
          "\e[1;1Hthis is the first" \
          "\e[2;1Hthis is the second and it is lon" \
          "\e[3;1Hthis is the third, it is even lo"
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

        Output.render(interface).must_equal(
          "\e[1;1H                                \e[1;1H" \
          "\e[2;1H                                \e[2;1H" \
          "\e[3;1H                                \e[3;1H"
        )
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
        Output.render(interface).must_equal(
          "\e[1;1H                                \e[1;1H" \
          "\e[2;1H                                \e[2;1H" \
          "\e[3;1H                                \e[3;1H" \
          "\e[1;1Hthis is the first" \
          "\e[2;1H" \
          "\e[3;1Hthis is the third, it is even lo"
        )
      end
    end

  end # Output

end # Vedeu
