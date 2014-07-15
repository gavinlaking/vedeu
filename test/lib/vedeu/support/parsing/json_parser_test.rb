require_relative '../../../../test_helper'
require_relative '../../../../../lib/vedeu/support/parsing/json_parser'

module Vedeu
  describe JSONParser do
    let(:output) { "{}" }

    describe '.parse' do
      def subject
        JSONParser.parse(output)
      end

      it 'returns a Hash' do
        subject.must_be_instance_of(Hash)
      end

      context 'when the JSON is valid' do
        let(:output) { File.read('test/support/json/int1_lin1_str1.json')}

        it 'returns a Hash' do
          subject.must_be_instance_of(Hash)
        end
      end

      context 'when the JSON is invalid' do
        let(:output) { "{}" }

        before { Oj.stubs(:load).raises(Oj::ParseError) }

        it 'returns a Hash' do
          subject.must_be_instance_of(Hash)
        end
      end
    end
  end
end
