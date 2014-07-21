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
          width:  5,
          height: 2,
          lines:  'RenderInterface.call'
        })
        RenderInterface.call(interface).must_equal(
          "\e[1;1H     \e[1;1H" \
          "\e[2;1H     \e[2;1H" \
          "\e[1;1HRenderInterface.call"
        )
      end
    end
  end
end
