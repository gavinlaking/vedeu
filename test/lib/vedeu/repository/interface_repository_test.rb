require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/repository/interface_repository'

module Vedeu
  describe InterfaceRepository do
    let(:described_class) { InterfaceRepository }

    before do
      InterfaceRepository.create({
        name: 'dummy',
        width: 15,
        height: 2
      })
    end
    after { InterfaceRepository.reset }

    describe '.create' do
      let(:subject)    { described_class.create(attributes) }
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

    describe '.update' do
      let(:subject)    { described_class.update(value, attributes) }
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
      let(:subject) { described_class.refresh }

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
      let(:subject) { described_class.entity }

      it 'returns a Class instance' do
        subject.must_be_instance_of(Class)
      end

      it 'returns Interface' do
        subject.must_equal(Interface)
      end
    end
  end
end
