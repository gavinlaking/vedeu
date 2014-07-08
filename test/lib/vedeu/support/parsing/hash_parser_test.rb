require_relative '../../../../test_helper'
require_relative '../../../../../lib/vedeu/support/parsing/hash_parser'

module Vedeu
  describe HashParser do
    let(:described_module) { HashParser }
    let(:output)           { {} }

    describe '.parse' do
      let(:subject) { described_module.parse(output) }
      let(:lines)   { mock }

      before { TextAdaptor.stubs(:adapt).returns(lines) }

      it 'returns a Hash' do
        subject.must_be_instance_of(Hash)
      end

      context 'when the output is content for a collection of interfaces' do
        let(:output) {
          {
            test: 'Some content...',
            dummy: 'More content...'
          }
        }

        it 'returns a Hash' do
          subject.must_equal({ interfaces: [{ name: 'test', lines: lines }, { name: 'dummy', lines: lines }] })
        end
      end

      context 'when the output is content for a single interface' do
        let(:output) {
          {
            dummy: 'Some content...'
          }
        }

        it 'returns a Hash' do
          subject.must_equal({ interfaces: [{ name: 'dummy', lines: lines }] })
        end
      end
    end
  end
end
