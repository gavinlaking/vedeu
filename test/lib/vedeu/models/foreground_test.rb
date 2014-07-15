require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/models/foreground'
require_relative '../../../../lib/vedeu/models/colour'

module Vedeu
  describe Foreground do
    describe '#foreground' do
      it 'returns an escape sequence' do
        Colour.new({ foreground: '#ff0000' }).foreground
          .must_equal("\e[38;5;196m")
      end

      it 'returns an empty string when the foreground is missing' do
        Colour.new.foreground.must_equal('')
      end
    end
  end
end
