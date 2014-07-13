require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/support/exit'

module Vedeu
  describe Exit do
    let(:described_class) { Exit }

    describe '.dispatch' do
      let(:subject) { described_class.dispatch }

      it 'returns a Symbol' do
        subject.must_be_instance_of(Symbol)
      end

      it 'returns the symbol :stop' do
        subject.must_equal(:stop)
      end
    end
  end
end
