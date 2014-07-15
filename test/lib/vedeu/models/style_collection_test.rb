require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/models/style_collection'
require_relative '../../../../lib/vedeu/models/stream'

module Vedeu
  describe StyleCollection do
    describe '#coerce' do
      it 'returns an empty string' do
        Stream.new({ style: {} }).style.must_equal('')
      end
    end
  end
end
