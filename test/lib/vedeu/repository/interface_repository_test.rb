require_relative '../../../test_helper'

module Vedeu
  describe InterfaceRepository do
    let(:described_class) { InterfaceRepository }
    let(:interface)       { :dummy }

    before do
      Interface.create({ name: :dummy })

      Terminal.stubs(:input)
      CommandRepository.stubs(:execute)
      Compositor.stubs(:arrange)
    end

    describe '.activated' do
      let(:subject) { described_class.activated }

      it { subject.must_be_instance_of(Interface) }
    end

    describe '.activate' do
      let(:subject) { described_class.activate(interface) }

      it { subject.must_be_instance_of(Array) }
    end

    describe '.initial_state' do
      let(:subject) { described_class.initial_state }

      it { subject.must_be_instance_of(Array) }
    end

    describe '.input' do
      let(:subject) { described_class.input }

      it { subject.must_be_instance_of(Array) }
    end

    describe '.output' do
      let(:subject) { described_class.output }

      it { subject.must_be_instance_of(Array) }
    end

    describe '.klass' do
      let(:subject) { described_class.klass }

      it { subject.must_equal(Interface) }
    end
  end
end
