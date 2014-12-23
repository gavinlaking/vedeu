require 'test_helper'

module Vedeu

  describe Position do

    let(:described) { Position.new(12, 19) }

    describe '#initialize' do
      it { return_type_for(described, Position) }
      it { assigns(described, '@y', 12) }
      it { assigns(described, '@x', 19) }
    end

    describe '#to_s' do
      it 'returns an escape sequence when no coordinates are provided' do
        Position.new.to_s.must_equal("\e[1;1H")
      end

      it 'returns an escape sequence when coordinates are provided' do
        Position.new(12, 19).to_s.must_equal("\e[12;19H")
      end

      it 'returns an escape sequence if a coordinate is missing' do
        Position.new(12).to_s.must_equal("\e[12;1H")
      end

      it 'returns an escape sequence if a coordinate is negative' do
        Position.new(12, -5).to_s.must_equal("\e[12;1H")
      end

      it 'resets to starting position when a block is given' do
        Position.new(4, 9).to_s { 'test' }.must_equal("\e[4;9Htest\e[4;9H")
      end
    end

  end # Position

end # Vedeu
