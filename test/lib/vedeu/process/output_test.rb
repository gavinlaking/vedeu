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

    it { subject.must_be_instance_of(Output) }

    describe '.render' do
      let(:subject) { described_class.render }

      it { subject.must_be_instance_of(NilClass) }

      context 'when the result is empty' do
        it { subject.must_be_instance_of(NilClass) }
      end

      context 'when the result is not empty' do
        let(:result) { { 'dummy' => [['test...']] } }

        it { subject.must_be_instance_of(Array) }
      end
    end
  end
end
