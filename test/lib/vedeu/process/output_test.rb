require_relative '../../../test_helper'

module Vedeu
  describe Output do
    let(:described_class) { Output }
    let(:subject)         { described_class.new }
    let(:result)          {}

    before do
      Interface.create({ name: 'dummy' })
      Compositor.stubs(:arrange).returns([])
      Queue.stubs(:dequeue).returns(result)
    end

    it 'returns an Output instance' do
      subject.must_be_instance_of(Output)
    end

    describe '.render' do
      let(:subject) { described_class.render }

      it 'returns a NilClass' do
        subject.must_be_instance_of(NilClass)
      end

      context 'when the result is empty' do
        it 'returns a NilClass' do
          subject.must_be_instance_of(NilClass)
        end
      end

      context 'when the result is not empty' do
        let(:result) { { 'dummy' => [['test...']] } }

        it 'returns an Array' do
          subject.must_be_instance_of(Array)
        end
      end
    end
  end
end
