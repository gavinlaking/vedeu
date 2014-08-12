require 'test_helper'

module Vedeu
  describe Render do
    before { API::Store.reset }

    describe '.call' do
      it 'returns the content for the interface' do
        interface = Interface.new({
          name:     '.call',
          geometry: {
            width:  32,
            height: 3,
          },
          lines:    [
            {
              streams: [{ text: 'this is the first' }]
            }, {
              streams: { text: 'this is the second and it is long' }
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
          name:     '.call',
          geometry: {
            width:  32,
            height: 3,
          },
          lines:    []
        })
        Render.call(interface).must_equal(
          "\e[1;1H                                \e[1;1H" \
          "\e[2;1H                                \e[2;1H" \
          "\e[3;1H                                \e[3;1H"
        )
      end

      it 'skips lines which have streams with no content' do
        interface = Interface.new({
          name:     '.call',
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
          "\e[1;1H                                \e[1;1H" \
          "\e[2;1H                                \e[2;1H" \
          "\e[3;1H                                \e[3;1H" \
          "\e[1;1Hthis is the first" \
          "\e[2;1H" \
          "\e[3;1Hthis is the third, it is even lo"
        )
      end
    end
  end
end
