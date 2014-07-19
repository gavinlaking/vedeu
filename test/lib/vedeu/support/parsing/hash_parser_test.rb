require_relative '../../../../test_helper'
require_relative '../../../../../lib/vedeu/support/parsing/hash_parser'

module Vedeu
  describe HashParser do
    describe '.parse' do
      it 'returns a Hash when the output is content for multiple interfaces' do
        HashParser.parse({
          test:  'Some content...',
          dummy: 'More content...'
        }).must_equal({
          interfaces: [
            { name: 'test', lines:  [
              { streams: { text: 'Some content...' } }] },
            { name: 'dummy', lines: [
              { streams: { text: 'More content...' } }] }
          ]
        })
      end

      it 'returns a Hash when the output is content for a single interface' do
        HashParser.parse({
          dummy: 'Some content...'
        }).must_equal({
          interfaces: [
            { name: 'dummy', lines: [
              { streams: { text: 'Some content...' } }] }
          ]
        })
      end
    end
  end
end
