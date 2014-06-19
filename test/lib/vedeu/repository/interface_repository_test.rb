require_relative '../../../test_helper'

module Vedeu
  describe InterfaceRepository do
    let(:described_class) { InterfaceRepository }

    before { Interface.create({ name: 'dummy' }) }
    after  { InterfaceRepository.reset }

    describe '.find' do
      let(:subject) { described_class.find(value) }
      let(:value)   { 'dummy' }

      context 'when the interface exists' do
        it 'returns an Interface' do
          subject.must_be_instance_of(Interface)
        end
      end

      context 'when the interface does not exist' do
        before { InterfaceRepository.reset }

        it 'raises an exception' do
          proc { subject }.must_raise(UndefinedInterface)
        end
      end
    end

    describe '.refresh' do
      let(:subject) { described_class.refresh }

      before { Compositor.stubs(:arrange) }

      it 'returns an Array' do
        subject.must_be_instance_of(Array)
      end
    end

    describe '.entity' do
      let(:subject) { described_class.entity }

      it 'returns an Interface' do
        subject.must_equal(Interface)
      end
    end
  end
end
