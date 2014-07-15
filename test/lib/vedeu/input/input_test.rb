require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/input/input'

module Vedeu
  describe Input do
    describe '.capture' do
      it 'enqueues the captured input from the terminal' do
        Terminal.stub :input, 'input' do
          Input.capture.must_equal(Vedeu::Queue)
        end
      end
    end
  end
end
