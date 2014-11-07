require 'test_helper'

module Vedeu

  describe Border do
    let(:interface) { Interface.new({ geometry: { width: 10, height: 5 } }) }

    describe '#initialize' do
      it 'returns a new instance of Border' do
        Border.new(interface).must_be_instance_of(Border)
      end
    end

    describe '#to_s' do
      it 'returns the escape sequences to draw a border' do
        Border.new(interface).to_s.must_equal(
          "\e(0l\e(B" \
          "\e(0qqqqqqqq\e(B" \
          "\e(0k\e(B" \
          "\e(0x\e(B        \e(0x\e(B" \
          "\e(0x\e(B        \e(0x\e(B" \
          "\e(0x\e(B        \e(0x\e(B" \
          "\e(0m\e(B" \
          "\e(0qqqqqqqq\e(B" \
          "\e(0j\e(B"
        )
      end
    end

  end # Border

end # Vedeu
