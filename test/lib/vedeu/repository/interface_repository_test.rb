require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/repository/interface_repository'

module Vedeu
  describe InterfaceRepository do
    before do
      InterfaceRepository.create({
        name: 'dummy',
        width: 15,
        height: 2
      })
    end
    after { InterfaceRepository.reset }

    describe '.create' do
      def subject
        InterfaceRepository.create(attributes)
      end
      let(:attributes) {
        {
          name: 'dummy',
          width: 15,
          height: 2
        }
      }

      it 'returns an Interface' do
        subject.must_be_instance_of(Interface)
      end
    end

    describe '.find' do
      def subject
        InterfaceRepository.find(value)
      end
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

    describe '.update' do
      def subject
        InterfaceRepository.update(value, attributes)
      end
      let(:value)      { 'dummy' }
      let(:attributes) { { name: 'dumber' } }

      it 'returns an Interface' do
        subject.must_be_instance_of(Interface)
      end

      context 'when the interface exists' do
        it 'updates and returns the existing interface' do
          subject.name.must_equal('dumber')
        end
      end

      context 'when the interface does not exist' do
        before { InterfaceRepository.reset }

        it 'returns the created interface' do
          subject.name.must_equal('dumber')
        end
      end
    end

    describe '.refresh' do
      def subject
        InterfaceRepository.refresh
      end

      before do
        InterfaceRepository.reset
        InterfaceRepository.create({
          name: 'a', width: 15, height: 2, z: 2
        }).enqueue("a")
        InterfaceRepository.create({
          name: 'b', width: 15, height: 2, z: 1
        }).enqueue("b")
        InterfaceRepository.create({
          name: 'c', width: 15, height: 2, z: 3
        }).enqueue("c")
      end
      after  { InterfaceRepository.reset }

      it 'returns an Array' do
        subject.must_be_instance_of(Array)
      end

      it 'returns the collection in order they should be drawn' do
        subject.must_equal(['b', 'a', 'c'])
      end
    end

    describe '.entity' do
      def subject
        InterfaceRepository.entity
      end

      it 'returns a Class instance' do
        subject.must_be_instance_of(Class)
      end

      it 'returns Interface' do
        subject.must_equal(Interface)
      end
    end
  end
end
