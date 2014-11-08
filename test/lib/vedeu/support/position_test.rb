require 'test_helper'

module Vedeu

  describe Position do

    describe '#initialize' do
      it 'returns an instance of Position' do
        Position.new.must_be_instance_of(Position)
      end
    end

    describe '#to_s' do
      it 'returns an escape sequence when no coordinates are provided' do
        Position.new.to_s.must_equal("\e[1;1H")
      end

      it 'returns an escape sequence when coordinates are provided' do
        Position.new(12, 19).to_s.must_equal("\e[12;19H")
      end

      it 'resets to starting position when a block is given' do
        Position.new(4, 9).to_s { 'test' }.must_equal("\e[4;9Htest\e[4;9H")
      end
    end

  end # Position

end # Vedeu
