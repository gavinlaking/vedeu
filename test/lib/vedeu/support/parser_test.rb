require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/support/parser'

module Vedeu
  describe Parser do
    let(:described_class) { Parser }
    let(:subject)         { described_class.new(output) }
    let(:output)          { '' }

    describe '#initialize' do
      let(:subject) { described_class.new(output) }

      it 'returns a Parser instance' do
        subject.must_be_instance_of(Parser)
      end

      it 'sets an instance variable' do
        subject.instance_variable_get("@output").must_equal(output)
      end

      context 'when the instance variable is nil' do
        let(:output) {}

        it 'set the instance variable to empty string' do
          subject.instance_variable_get("@output").must_equal('')
        end
      end
    end

    describe '#parse' do
      let(:subject) { described_class.parse(output) }

      it 'returns a Composition' do
        subject.must_be_instance_of(Composition)
      end

      context 'when the output is an interface name and a stream' do
        let(:output) {
          File.read('test/support/output_1.json')
        }

        it 'returns a composition' do
          subject.must_equal('')
        end
      end


      # context 'when the output contains a single interface' do
      #   let(:output) { File.read('test/support/single_interface.json') }

      #   it 'returns a Composition instance' do
      #     subject.must_be_instance_of(Composition)
      #   end
      # end

      # context 'when the output contains multiple interfaces' do
      #   let(:output) { File.read('test/support/multi_interface.json') }

      #   it 'returns a Composition instance' do
      #     subject.must_be_instance_of(Composition)
      #   end
      # end
    end
  end
end
