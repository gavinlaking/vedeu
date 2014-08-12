require 'test_helper'

module Vedeu
  describe Clear do
    before { API::Store.reset }

    describe '.call' do
      it 'returns the escape sequence to clear the whole interface' do
        interface = Interface.new({
          name:   'Clear.call',
          geometry: {
            width:  5,
            height: 2
          }
        })
        Clear.call(interface).must_equal(
          "\e[1;1H     \e[1;1H" \
          "\e[2;1H     \e[2;1H"
        )
      end

      it 'returns the escape sequence to clear the whole interface with specified colours' do
        interface = Interface.new({
          name:   'Clear.call',
          geometry: {
            width:  5,
            height: 2,
          },
          colour: {
            foreground: '#00ff00',
            background: '#ffff00'
          }
        })
        Clear.call(interface).must_equal(
          "\e[38;5;46m\e[48;5;226m" \
          "\e[1;1H     \e[1;1H" \
          "\e[2;1H     \e[2;1H"
        )
      end
    end
  end
end
