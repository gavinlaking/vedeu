require 'test_helper'
require 'vedeu/output/render_interface'
require 'vedeu/models/interface'
require 'vedeu/support/persistence'

module Vedeu
  describe RenderInterface do
    before { Persistence.reset }

    describe '.call' do
      it 'returns the content for the interface' do
        interface = Interface.new({
          name:   '.call',
          width:  32,
          height: 3,
          lines:  'RenderInterface.call',
          lines:  [
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
        RenderInterface.call(interface).must_equal(
          "\e[1;1H                                \e[1;1H" \
          "\e[2;1H                                \e[2;1H" \
          "\e[3;1H                                \e[3;1H" \
          "\e[1;1Hthis is the first" \
          "\e[2;1Hthis is the second and it is lon" \
          "\e[3;1Hthis is the third, it is even lo"
        )
      end
    end
  end
end
