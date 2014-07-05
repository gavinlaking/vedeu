require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/input/input'

module Vedeu
  describe Input do
    let(:described_module) { Input }
    let(:input)            { 'input' }

    before do
      Terminal.stubs(:input).returns(input)
      Queue.stubs(:enqueue).returns([input])
    end

    describe '.capture' do
      let(:subject) { described_module.capture }

      it 'returns an Array' do
        subject.must_be_instance_of(Array)
      end

      it 'returns the enqueued input' do
        subject.must_equal([input])
      end
    end
  end
end
