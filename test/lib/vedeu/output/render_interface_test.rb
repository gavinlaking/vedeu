require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/repository/interface_repository'
require_relative '../../../../lib/vedeu/output/clear_interface'
require_relative '../../../../lib/vedeu/output/render_interface'
require_relative '../../../../lib/vedeu/models/interface'

module Vedeu
  describe RenderInterface do
    before { InterfaceRepository.reset }

    describe '.call' do
      it 'returns the content for the interface' do
        interface = Interface.new({
          name:   '.call',
          width:  32,
          height: 2,
          lines:  'RenderInterface.call',
          lines:  [
            { streams: { text: '1d194f184a0b937c71bfcbdf13511992' } },
            { streams: { text: '8787092f681b149d645df64e73d3cb37' } }
          ]
        })
        RenderInterface.call(interface).must_equal(
          "\e[1;1H                                \e[1;1H" \
          "\e[2;1H                                \e[2;1H" \
          "\e[1;1H1d194f184a0b937c71bfcbdf13511992" \
          "\e[2;1H8787092f681b149d645df64e73d3cb37"
        )
      end
    end
  end
end
