require_relative '../../../test_helper'

module Vedeu
  describe Interface do
    let(:described_class) { Interface }
    let(:instance)        { described_class.new(options) }
    let(:options)         { {} }

    before do
      Terminal.stubs(:width).returns(80)
      Terminal.stubs(:height).returns(25)
    end

    it { instance.must_be_instance_of(Interface) }

    describe '#initial_state' do
      subject { instance.initial_state }

      it { proc { subject }.must_raise(NotImplementedError) }
    end

    describe '#event_loop' do
      subject { instance.event_loop }

      it { proc { subject }.must_raise(NotImplementedError) }
    end
  end
end
