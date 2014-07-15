require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/support/exit'

module Vedeu
  describe Exit do
    describe '.dispatch' do
      def subject
        Exit.dispatch
      end

      it 'returns a Symbol' do
        subject.must_be_instance_of(Symbol)
      end

      it 'returns the symbol :stop' do
        subject.must_equal(:stop)
      end
    end
  end
end
