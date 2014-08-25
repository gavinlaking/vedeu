require 'test_helper'

module Vedeu
  describe Clear do
    before { Buffers.reset }

    describe '#initialize' do
      it 'returns an instance of itself' do
        interface = mock('Interface')
        Clear.new(interface).must_be_instance_of(Clear)
      end
    end

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
          "\e[38;2;0;255;0m\e[48;2;255;255;0m" \
          "\e[1;1H     \e[1;1H" \
          "\e[2;1H     \e[2;1H"
        )
      end
    end
  end
end
