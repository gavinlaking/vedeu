require 'test_helper'
require 'vedeu/support/interface_store'

module Vedeu
  describe InterfaceStore do
    before { InterfaceStore.reset }

    describe '.update' do
      it 'returns an Interface' do
        InterfaceStore.update('dummy', { name: 'dumber' })
          .must_be_instance_of(Interface)
      end

      it 'updates and returns the existing interface when the interface exists' do
        InterfaceStore.update('dummy', { name: 'dumber' }).name
          .must_equal('dumber')
      end

      it 'returns a new interface when the interface does not exist' do
        InterfaceStore.update('dummy', { name: 'dumber' }).name
          .must_equal('dumber')
      end
    end

    describe '#create' do
      it 'creates and returns the stored record' do
        InterfaceStore.create({ name: 'dummy' })
          .must_be_instance_of(Interface)
      end
    end

    describe '#query' do
      it 'returns the record when found' do
        InterfaceStore.create({ name: 'hydrogen' })

        InterfaceStore.query('hydrogen').name.must_equal('hydrogen')
      end

      it 'raises an exception when the record cannot be found' do
        proc { InterfaceStore.query('dummy') }.must_raise(EntityNotFound)
      end
    end

    describe '#reset' do
      it 'deletes all records stored' do
        InterfaceStore.create({ name: 'dumb' })
        InterfaceStore.reset.must_equal({})
      end
    end
  end
end
