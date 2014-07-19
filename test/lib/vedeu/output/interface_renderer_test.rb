require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/repository/interface_repository'
require_relative '../../../../lib/vedeu/output/interface_renderer'
require_relative '../../../../lib/vedeu/models/interface'

module Vedeu
  describe InterfaceRenderer do
    before { InterfaceRepository.reset }

    describe '.clear' do
      it 'returns the escape sequence to clear the whole interface' do
        interface = Interface.new({
          name:   '.clear',
          width:  5,
          height: 2
        })
        InterfaceRenderer.clear(interface).must_equal(
          "\e[1;1H     \e[1;1H" \
          "\e[2;1H     \e[2;1H"
        )
      end

      it 'returns the escape sequence to clear the whole interface with specified colours' do
        interface = Interface.new({
          name:   '.clear',
          width:  5,
          height: 2,
          colour: {
            foreground: '#00ff00',
            background: '#ffff00'
          }
        })
        InterfaceRenderer.clear(interface).must_equal(
          "\e[38;5;46m\e[48;5;226m" \
          "\e[1;1H     \e[1;1H" \
          "\e[2;1H     \e[2;1H"
        )
      end
    end

    describe '.render' do
      it 'returns the content for the interface' do
        interface = Interface.new({
          name:   '.render',
          width:  5,
          height: 2,
          lines:  'InterfaceRenderer.render'
        })
        InterfaceRenderer.render(interface).must_equal("\e[1;1HInterfaceRenderer.render")
      end
    end
  end
end
