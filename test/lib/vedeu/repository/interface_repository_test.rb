require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/repository/interface_repository'

module Vedeu
  describe InterfaceRepository do
    describe '.create' do
      it 'returns an Interface' do
        InterfaceRepository.create({
          name:   'dummy',
          width:  5,
          height: 5
        }).must_be_instance_of(Interface)
      end
    end

    describe '.find' do
      it 'returns an Interface when the interface exists' do
        InterfaceRepository.create({
          name:   'dummy',
          width:  5,
          height: 5
        })
        InterfaceRepository.find('dummy')
          .must_be_instance_of(Interface)
      end

      it 'raises an exception when the interface does not exist' do
        InterfaceRepository.reset
        proc { InterfaceRepository.find('dummy') }
          .must_raise(UndefinedInterface)
      end
    end

    describe '.update' do
      it 'returns an Interface' do
        InterfaceRepository.update('dummy', { name: 'dumber' })
          .must_be_instance_of(Interface)
      end

      it 'updates and returns the existing interface when the interface exists' do
        InterfaceRepository.update('dummy', { name: 'dumber' }).name
          .must_equal('dumber')
      end

      it 'returns a new interface when the interface does not exist' do
        InterfaceRepository.reset
        InterfaceRepository.update('dummy', { name: 'dumber' }).name
          .must_equal('dumber')
      end
    end

    describe '.refresh' do
      it 'returns an Array' do
        InterfaceRepository.refresh.must_be_instance_of(Array)
      end

      it 'returns the collection in order they should be drawn' do
        InterfaceRepository.reset
        InterfaceRepository.create({
          name: 'a', width: 5, height: 5, z: 2
        }).enqueue("a")
        InterfaceRepository.create({
          name: 'b', width: 5, height: 5, z: 1
        }).enqueue("b")
        InterfaceRepository.create({
          name: 'c', width: 5, height: 5, z: 3
        }).enqueue("c")
        InterfaceRepository.refresh.must_equal(['b', 'a', 'c'])
      end
    end

    describe '.entity' do
      it 'returns Interface' do
        InterfaceRepository.entity.must_equal(Interface)
      end
    end
  end
end
