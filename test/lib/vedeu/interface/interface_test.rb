require_relative '../../../test_helper'

module Vedeu
  describe Interface do
    let(:described_class)    { Interface }
    let(:described_instance) { described_class.new(options) }
    let(:options)            { {} }

    it { described_instance.must_be_instance_of(Interface) }

    describe '#initial_state' do
      let(:subject) { described_instance.initial_state }

      it { proc { subject }.must_raise(NotImplementedError) }
    end

    describe '#input' do
      let(:subject) { described_instance.input }

      before do
        Terminal.stubs(:input).returns('some input')
        Commands.stubs(:execute).returns('some output')
      end

      it { subject.must_be_instance_of(String) }
    end

    describe '#output' do
      let(:subject) { described_instance.output }
      let(:command) { mock }

      before { Compositor.stubs(:arrange).returns([]) }

      it 'sends the output of the command to the compositor' do
        subject.must_be_instance_of(Array)
      end
    end

    describe '#geometry' do
      let(:subject) { described_instance.geometry }

      it { subject.must_be_instance_of(Geometry) }
    end
  end
end
