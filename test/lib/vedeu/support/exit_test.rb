require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/support/exit'

module Vedeu
  describe Exit do
    describe '.dispatch' do
      it 'returns the symbol :stop' do
        Exit.dispatch.must_equal(:stop)
      end
    end
  end
end
