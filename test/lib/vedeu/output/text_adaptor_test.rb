require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/output/text_adaptor'

module Vedeu
  describe TextAdaptor do
    describe '.adapt' do
      it 'returns an empty collection when processing an empty string' do
        TextAdaptor.adapt('').must_be_empty
      end

      it 'returns a single line' do
        text = "This is a single line of text.\n"
        TextAdaptor.adapt(text).size.must_equal(1)
      end

      it 'returns multiple lines' do
        text = "Lorem ipm olor sit aet,\nConsctetur adipiscing.\n" \
               "Curitur aiquet, trpis id dui.\n\nCondum elemum.\n"
        TextAdaptor.adapt(text).size.must_equal(5)
      end
    end
  end
end
