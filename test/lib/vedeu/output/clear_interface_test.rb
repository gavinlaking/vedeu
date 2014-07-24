require 'test_helper'
require 'vedeu/output/clear_interface'
require 'vedeu/models/interface'
require 'vedeu/support/persistence'

module Vedeu
  describe ClearInterface do
    before { Persistence.reset }

    describe '.call' do
      it 'returns the escape sequence to clear the whole interface' do
        interface = Interface.new({
          name:   'ClearInterface.call',
          width:  5,
          height: 2
        })
        ClearInterface.call(interface).must_equal(
          "\e[1;1H     \e[1;1H" \
          "\e[2;1H     \e[2;1H"
        )
      end

      it 'returns the escape sequence to clear the whole interface with specified colours' do
        interface = Interface.new({
          name:   'ClearInterface.call',
          width:  5,
          height: 2,
          colour: {
            foreground: '#00ff00',
            background: '#ffff00'
          }
        })
        ClearInterface.call(interface).must_equal(
          "\e[38;5;46m\e[48;5;226m" \
          "\e[1;1H     \e[1;1H" \
          "\e[2;1H     \e[2;1H"
        )
      end
    end
  end
end
