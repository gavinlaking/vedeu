require_relative '../../../test_helper'

module Vedeu
  describe InterfaceRepository do
    let(:described_class) { InterfaceRepository }
    let(:interface)       { :dummy }
    let(:value)           { "dummy" }

    before do
      Interface.create({ name: "dummy" })

      Terminal.stubs(:input)
      Input.stubs(:evaluate)
      Compositor.stubs(:arrange)
    end

    describe '.activate' do
      let(:subject) { described_class.activate(interface) }

      it { subject.must_be_instance_of(Array) }
    end

    describe '.deactivate' do
      let(:subject) { described_class.deactivate }

      it { subject.must_be_instance_of(Array) }
    end

    describe '.activated' do
      let(:subject) { described_class.activated }

      it { subject.must_be_instance_of(Interface) }
    end

    describe '.find_by_name' do
      let(:subject) { described_class.find_by_name(value) }

      it { subject.must_be_instance_of(Interface) }
    end

    describe '.initial_state' do
      let(:subject) { described_class.initial_state }

      it { subject.must_be_instance_of(Array) }
    end

    describe '.klass' do
      let(:subject) { described_class.klass }

      it { subject.must_equal(Interface) }
    end
  end
end
