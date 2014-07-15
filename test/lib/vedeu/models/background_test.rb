require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/models/background'
require_relative '../../../../lib/vedeu/models/colour'

module Vedeu
  describe Background do
    describe '#background' do
      it 'returns an escape sequence' do
        Colour.new({
          background: '#00ff00'
        }).background.must_equal("\e[48;5;46m")
      end

      it 'returns an empty string when the foreground is missing' do
        Colour.new.background.must_equal('')
      end
    end
  end
end
