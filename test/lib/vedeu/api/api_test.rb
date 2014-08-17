require 'test_helper'

module Vedeu
  describe API do
    describe '.height' do
      it 'returns the terminal height' do
        IO.console.stub(:winsize, [24, 40]) do
          Vedeu.height.must_equal(24)
        end
      end
    end

    describe '.width' do
      it 'returns the terminal width' do
        IO.console.stub(:winsize, [24, 40]) do
          Vedeu.width.must_equal(40)
        end
      end
    end
  end
end
