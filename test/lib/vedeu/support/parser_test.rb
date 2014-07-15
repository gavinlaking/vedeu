require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/support/parser'

module Vedeu
  describe Parser do
    describe '#parse' do
      it 'returns a NilClass when the output is empty' do
        Parser.parse.must_be_instance_of(NilClass)
      end

      it 'returns a Composition when the output is JSON' do
        Parser.parse("{\"some\": \"JSON\"}").must_be_instance_of(Composition)
      end

      it 'returns a Composition when the output is a Hash' do
        Parser.parse({
          parser_parse: 'Parser#parse'
        }).must_be_instance_of(Composition)
      end

      it 'raises an exception when the output is anything else' do
        proc { Parser.parse([:invalid]) }.must_raise(ParseError)
      end
    end
  end
end
