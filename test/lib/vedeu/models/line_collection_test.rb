require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/models/attributes/line_collection'
require_relative '../../../../lib/vedeu/models/interface'

module Vedeu
  describe LineCollection do
    describe '#coerce' do
      it 'returns an empty collection when there are no lines' do
        Interface.new({ lines: {} }).lines.must_equal([])
      end

      it 'contains a single Line object when the line is just a String' do
        Interface.new({ lines: 'some text' }).lines.size
          .must_equal(1)
      end

      it 'contains a single Line object when there is a single line' do
        Interface.new({ lines: { streams: { text: 'some text' } } })
          .lines.size.must_equal(1)
      end

      it 'contains multiple Line objects when there are multiple lines' do
        Interface.new({ lines: [
          { text: 'some text' },
          { text: 'some more text' }
        ] }).lines.size.must_equal(2)
      end
    end
  end
end
