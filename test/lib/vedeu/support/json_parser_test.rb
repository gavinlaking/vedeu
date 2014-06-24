require_relative '../../../test_helper'

module Vedeu
  describe JSONParser do
    let(:described_class)    { JSONParser }
    let(:described_instance) { described_class.new(json) }
    let(:subject)            { described_instance }
    let(:json)               { File.read('test/support/single_interface.json') }

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
      let(:subject) { described_instance.parse }

      it 'returns a Composition instance' do
        subject.must_be_instance_of(Buffer::Composition)
      end
    end
  end
end
