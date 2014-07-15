require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/models/stream_collection'
require_relative '../../../../lib/vedeu/models/line'

module Vedeu
  describe StreamCollection do
    let(:described_class) { StreamCollection }

    describe '#coerce' do
      let(:subject) { Vedeu::Line.new({ streams: streams }).streams }
      let(:streams) {}

      context 'when there is no stream' do
        it 'returns a Array' do
          subject.must_be_instance_of(Array)
        end

        it 'returns an empty array' do
          subject.must_equal([])
        end
      end

      context 'when there is a single stream' do
        let(:streams) { 'some text' }

        it 'returns an Array' do
          subject.must_be_instance_of(Array)
        end

        it 'contains a single Stream object' do
          subject.size.must_equal(1)
        end
      end

      context 'when there are multiple streams' do
        let(:streams) {
          [
            { text: 'some text' },
            { text: 'some more text' }
          ]
        }

        it 'returns an Array' do
          subject.must_be_instance_of(Array)
        end

        it 'returns a collection of Stream objects' do
          subject.first.must_be_instance_of(Stream)
        end

        it 'contains multiple Stream objects' do
          subject.size.must_equal(2)
        end
      end
    end
  end
end
