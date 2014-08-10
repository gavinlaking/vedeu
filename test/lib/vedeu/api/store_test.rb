require 'test_helper'
require 'vedeu/api/store'

module Vedeu
  module API
    describe Store do
      before { Store.reset }

      # describe '.merge' do
      #   it 'returns an Interface' do
      #     Store.merge('dummy', { name: 'dumber' })
      #       .must_be_instance_of(Vedeu::Interface)
      #   end

      #   it 'updates and returns the existing interface when the interface exists' do
      #     Store.merge('dummy', { name: 'dumber' }).name
      #       .must_equal('dumber')
      #   end

      #   it 'returns a new interface when the interface does not exist' do
      #     Store.merge('dummy', { name: 'dumber' }).name
      #       .must_equal('dumber')
      #   end
      # end

      describe '#create' do
        it 'creates and returns the stored record' do
          attributes = { name: 'sulphur' }

          Store.create(attributes).must_equal({ name: 'sulphur' })
        end
      end

      describe '#query' do
        before do
          Store.reset
          Vedeu.interface('chlorine')
        end

        it 'returns the record when found' do
          Store.query('chlorine').must_equal({ name: 'chlorine', geometry: {} })
        end

        it 'raises an exception when name is empty' do
          proc { Store.query('') }.must_raise(EntityNotFound)
        end

        it 'raises an exception when name is nil' do
          proc { Store.query(nil) }.must_raise(EntityNotFound)
        end

        it 'raises an exception when the record cannot be found' do
          proc { Store.query('dummy') }.must_raise(EntityNotFound)
        end
      end

      describe '#reset' do
        it 'deletes all records stored' do
          Vedeu.interface('potassium')

          Store.reset.must_equal({})
        end
      end
    end
  end
end
