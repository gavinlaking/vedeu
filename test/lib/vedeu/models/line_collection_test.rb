require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/models/line_collection'
require_relative '../../../../lib/vedeu/models/interface'

module Vedeu
  describe LineCollection do
    let(:described_class) { LineCollection }

    describe '#coerce' do
      let(:subject) { Vedeu::Interface.new({ lines: lines }).lines }
      let(:lines) {}

      context 'when there are no lines' do
        it 'returns a Array' do
          subject.must_be_instance_of(Array)
        end

        it 'returns an empty array' do
          subject.must_equal([])
        end
      end

      context 'when the line is just a String' do
        let(:lines) { 'some text' }

        it 'returns a Line' do
          subject.must_be_instance_of(Line)
        end
      end

      context 'when there is a single line' do
        let(:lines) { { streams: { text: 'some text' } } }

        it 'returns a Line' do
          subject.must_be_instance_of(Line)
        end
      end

      context 'when there are multiple lines' do
        let(:lines) {
          [
            { text: 'some text' },
            { text: 'some more text' }
          ]
        }

        it 'returns an Array' do
          subject.must_be_instance_of(Array)
        end

        it 'returns a collection of lines objects' do
          subject.first.must_be_instance_of(Line)
        end
      end
    end
  end
end
