require_relative '../../../test_helper'

module Vedeu
  describe Output do
    let(:described_class) { Output }
    let(:input)           { "" }
    let(:args)            { [] }

    before do
      Compositor.stubs(:arrange)
      Queue.stubs(:dequeue).returns(result)
    end

    describe '.render' do
      let(:subject) { described_class.render }
      let(:result)  { }

      it { subject.must_be_instance_of(NilClass) }

      context 'when the result is empty' do
        let(:result) {}
      end
    end
  end
end
