require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/support/persistence'

module Vedeu
  describe Persistence do
    before { Persistence.reset }

    describe '.update' do
      it 'returns an Interface' do
        Persistence.update('dummy', { name: 'dumber' })
          .must_be_instance_of(Interface)
      end

      it 'updates and returns the existing interface when the interface exists' do
        Persistence.update('dummy', { name: 'dumber' }).name
          .must_equal('dumber')
      end

      it 'returns a new interface when the interface does not exist' do
        Persistence.update('dummy', { name: 'dumber' }).name
          .must_equal('dumber')
      end
    end

    describe '#create' do
      it 'creates and returns the stored record' do
        Persistence.create({ name: 'dummy' })
          .must_be_instance_of(Interface)
      end
    end

    describe '#query' do
      it 'returns false if the value is not provided' do
        Persistence.query(nil).must_equal(false)
      end

      it 'returns the record if found' do
        Persistence.create({ name: 'hydrogen' })

        Persistence.query('hydrogen').name.must_equal('hydrogen')
      end

      it 'raises an exception when the record cannot be found' do
        proc { Persistence.query('dummy') }.must_raise(EntityNotFound)
      end
    end

    describe '#reset' do
      it 'deletes all records stored' do
        Persistence.create({ name: 'dumb' })
        Persistence.reset.must_equal({})
      end
    end
  end
end
