require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/models/style_collection'
require_relative '../../../../lib/vedeu/models/stream'

module Vedeu
  describe StyleCollection do
    let(:described_class) { StyleCollection }

    describe '#coerce' do
      let(:subject) { Vedeu::Stream.new({ style: style }).style }
      let(:style)   {}

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an empty string' do
        subject.must_equal('')
      end
    end
  end
end
