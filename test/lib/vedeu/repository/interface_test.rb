require_relative '../../../test_helper'

module Vedeu
  describe Interface do
    let(:described_class)    { Interface }
    let(:described_instance) { described_class.new(attributes) }
    let(:attributes)         { { name: :test_interface } }
    let(:result)             {}

    before do
      Terminal.stubs(:input).returns('stop')
      Input.stubs(:evaluate).returns(result)
      Compositor.stubs(:arrange).returns([])
    end

    it { described_instance.must_be_instance_of(Interface) }

    describe '#create' do
      let(:subject) { described_class.create(attributes) }

      it { subject.must_be_instance_of(Interface) }
    end

    describe '#initial_state' do
      let(:subject) { described_instance.initial_state }

      it { subject.must_be_instance_of(NilClass) }
    end

    describe '#origin' do
    end

    describe '#initial_state' do
    end

    describe '#input' do
      let(:subject) { described_instance.input }

      context 'when the command evaluates to :stop' do
        let(:result) { :stop }

        it { proc { subject }.must_raise(Collapse) }
      end

      context 'when the command evaluates to anything else' do
        let(:result) { :something_else }

        it { subject.must_be_instance_of(NilClass) }
      end
    end

    describe '#output' do
      let(:subject) { described_instance.output }
      let(:command) { mock }

      it 'sends the output of the command to the compositor' do
        subject.must_be_instance_of(NilClass)
      end
    end
  end
end
