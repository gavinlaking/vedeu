require_relative '../../../test_helper'

module Vedeu
  describe InterfaceRepository do
    let(:described_class) { InterfaceRepository }

    before { Interface.create({ name: 'dummy' }) }

    after  { InterfaceRepository.reset }

    describe '.activate' do
      let(:subject)   { described_class.activate(interface) }
      let(:interface) { 'dummy' }

      it 'returns an Array' do
        subject.must_be_instance_of(Array)
      end
    end

    describe '.deactivate' do
      let(:subject) { described_class.deactivate }

      it 'returns an Array' do
        subject.must_be_instance_of(Array)
      end
    end

    describe '.activated' do
      let(:subject) { described_class.activated }

      it 'returns an Interface' do
        subject.must_be_instance_of(Interface)
      end
    end

    describe '.find_by_name' do
      let(:subject) { described_class.find_by_name(value) }
      let(:value)   { 'dummy' }

      it 'returns an Interface' do
        subject.must_be_instance_of(Interface)
      end
    end

    describe '.update' do
      let(:subject) { described_class.update }

      before { Compositor.stubs(:arrange) }

      it 'returns an Array' do
        subject.must_be_instance_of(Array)
      end
    end

    describe '.klass' do
      let(:subject) { described_class.klass }

      it 'returns an Interface' do
        subject.must_equal(Interface)
      end
    end
  end
end
