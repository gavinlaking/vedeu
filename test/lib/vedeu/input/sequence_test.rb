require_relative '../../../test_helper'

module Vedeu
  module Input
    describe Sequence do
      let(:klass)  { Sequence }
      let(:stream) { [] }

      describe '#parse' do
        subject { klass.parse(stream) }

        it { subject.must_be_instance_of(Array) }

        context 'when the stream is empty' do
          it 'returns an empty collection' do
            subject.must_equal([])
          end
        end

        context 'when the stream contains data' do
          it { skip }
        end
      end
    end
  end
end
