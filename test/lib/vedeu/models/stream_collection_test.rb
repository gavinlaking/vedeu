require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/models/attributes/stream_collection'
require_relative '../../../../lib/vedeu/models/line'

module Vedeu
  describe StreamCollection do
    describe '#coerce' do
      it 'returns an empty array when there is no stream' do
        Line.new.streams.must_equal([])
      end

      it 'contains a single Stream when there is a single stream' do
        Line.new({ streams: 'some text' }).streams.size
          .must_equal(1)
      end

      it 'contains multiple Stream when there are multiple streams' do
        Line.new({ streams: [
          { text: 'some text' },
          { text: 'some more text' }
        ] }).streams.size.must_equal(2)
      end
    end
  end
end
