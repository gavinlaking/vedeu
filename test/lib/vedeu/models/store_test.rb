require 'test_helper'

module Vedeu
    describe Store do
      before { Store.reset }

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
          Store.query('chlorine').must_equal(
            {
              name: 'chlorine',
              group: '',
              lines: [],
              colour: {},
              style: '',
              geometry: {},
              cursor: true,
              delay: 0.0
            }
          )
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
