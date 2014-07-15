require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/support/parser'

module Vedeu
  describe Parser do
    let(:described_class) { Parser }
    let(:subject)         { described_class.new(output) }
    let(:output)          { File.read('test/support/output_1.json') }

    describe '#initialize' do
      let(:subject) { described_class.new(output) }

      it 'returns a Parser instance' do
        subject.must_be_instance_of(Parser)
      end

      it 'sets an instance variable' do
        subject.instance_variable_get('@output').must_equal(output)
      end

      context 'when the instance variable is nil' do
        let(:subject) { described_class.new }

        it 'set an instance variable' do
          subject.instance_variable_get('@output').must_equal({})
        end
      end
    end

    describe '#parse' do
      let(:subject) { described_class.parse(output) }

      context 'when the output is empty' do
        let(:output) {}

        it 'returns a NilClass' do
          subject.must_be_instance_of(NilClass)
        end
      end

      context 'when the output is JSON' do
        let(:output)  { "{\"some\": \"JSON\"}" }

        it 'returns a Composition' do
          subject.must_be_instance_of(Composition)
        end
      end

      context 'when the output is a Hash' do
        let(:output) {
          {
            dummy: 'Some text...'
          }
        }

        it 'returns a Composition' do
          subject.must_be_instance_of(Composition)
        end
      end

      context 'when the output is anything else' do
        let(:output) { [:invalid] }

        it 'raises an exception' do
          proc { subject }.must_raise(ParseError)
        end
      end
    end
  end
end
