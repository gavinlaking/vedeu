require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/repository/interface_repository'

module Vedeu
  describe InterfaceRepository do
    before { InterfaceRepository.reset }

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
      it 'returns the interface if it exists' do
        hydrogen =  InterfaceRepository.create({ name: 'hydrogen' })

        InterfaceRepository.find('hydrogen').must_equal(hydrogen)
      end

      it 'raises an exception if it does not exist' do
        proc { InterfaceRepository.find('helium') }
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
        InterfaceRepository.update('dummy', { name: 'dumber' }).name
          .must_equal('dumber')
      end
    end

    describe '.refresh' do
      it 'returns an Array' do
        InterfaceRepository.refresh.must_be_instance_of(Array)
      end

      it 'returns the collection in order they should be drawn' do
        InterfaceRepository.create({
          name:   '.refresh_1',
          width:  1,
          height: 1,
          z:      3,
          lines:  'alpha'
        }).enqueue
        InterfaceRepository.create({
          name:   '.refresh_2',
          width:  1,
          height: 1,
          z:      1,
          lines:  'beta'
        }).enqueue
        InterfaceRepository.create({
          name:   '.refresh_3',
          width:  1,
          height: 1,
          z:      2,
          lines:  'gamma'
        }).enqueue

        InterfaceRepository.refresh.must_equal([
          "\e[1;1H \e[1;1H\e[1;1Hbeta",
          "\e[1;1H \e[1;1H\e[1;1Hgamma",
          "\e[1;1H \e[1;1H\e[1;1Halpha"
        ])
      end
    end

    describe '.entity' do
      it 'returns Interface' do
        InterfaceRepository.entity.must_equal(Interface)
      end
    end
  end
end
