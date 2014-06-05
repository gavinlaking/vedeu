require_relative '../../../test_helper'

module Vedeu
  describe Interface do
    let(:described_class)    { Interface }
    let(:described_instance) { described_class.new(attributes) }
    let(:attributes)         { { name: :test_interface } }

    it { described_instance.must_be_instance_of(Interface) }

    describe '#name' do
      let(:subject) { described_instance.name }

      context 'when the name is undefined' do
        let(:attributes) { {} }

        it { subject.must_be_instance_of(NilClass) }
      end

      context 'when the name is defined' do
        it { subject.must_be_instance_of(Symbol) }

        it { subject.must_equal(:test_interface) }
      end
    end

    describe '#geometry' do
      let(:subject) { described_instance.geometry }

      it { subject.must_be_instance_of(Geometry) }
    end

    describe '#options' do
      let(:subject) { described_instance.options }

      it { subject.must_be_instance_of(Hash) }
    end

    describe '#initial_state' do
      let(:subject) { described_instance.initial_state }

      # it { proc { subject }.must_raise(NotImplementedError) }
    end

    describe '#input' do
      let(:subject) { described_instance.input }

      before do
        Terminal.stubs(:input).returns('stop')
        CommandRepository.stubs(:execute)
      end

      it { subject.must_be_instance_of(NilClass) }
    end

    describe '#output' do
      let(:subject) { described_instance.output }
      let(:command) { mock }

      before { Compositor.stubs(:arrange).returns([]) }

      it 'sends the output of the command to the compositor' do
        subject.must_be_instance_of(Array)
      end
    end
  end
end
