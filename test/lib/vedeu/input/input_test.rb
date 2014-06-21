require_relative '../../../test_helper'

module Vedeu
  describe Input do
    let(:described_class) { Input }
    let(:input)           { 'input' }
    let(:subject)         { described_class.new }

    before do
      Terminal.stubs(:input).returns(input)
      Queue.stubs(:enqueue).returns([input])
    end

    it 'return an Input instance' do
      subject.must_be_instance_of(Input)
    end

    describe '.capture' do
      let(:subject) { described_class.capture }

      it 'returns an Array' do
        subject.must_be_instance_of(Array)
      end

      it 'returns the enqueue input' do
        subject.must_equal([input])
      end
    end
  end
end
