require_relative '../../../test_helper'

module Vedeu
  describe JSONParser do
    let(:described_class)    { JSONParser }
    let(:subject)            { described_class.new(json) }
    let(:json)               { "[]" }

    it 'returns a JSONParser instance' do
      subject.must_be_instance_of(JSONParser)
    end

    it 'sets an instance variable' do
      subject.instance_variable_get("@json").must_equal(json)
    end

    context 'when the instance variable is nil' do
      let(:json) {}

      it 'set the instance variable to empty string' do
        subject.instance_variable_get("@json").must_equal('')
      end
    end

    describe '#parse' do
      let(:subject) { described_class.parse(json) }

      context 'when the JSON contains a single interface' do
        let(:json) { File.read('test/support/single_interface.json') }

        it 'returns a Composition instance' do
          subject.must_be_instance_of(Buffer::Composition)
        end
      end

      context 'when the JSON contains multiple interfaces' do
        let(:json) { File.read('test/support/multi_interface.json') }

        it 'returns a Composition instance' do
          subject.must_be_instance_of(Buffer::Composition)
        end
      end
    end
  end
end
