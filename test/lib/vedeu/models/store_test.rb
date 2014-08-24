require 'test_helper'

module Vedeu
    describe Store do
      before { Store.reset }

      describe '#create' do
        let(:attributes) {
          {
            name: 'sulphur'
          }
        }

        it 'returns an instance of Hash' do
          Store.create(attributes).must_be_instance_of(Hash)
        end

        it 'stores the interface attributes and returns the storage ' \
           'collection' do
          Store.create(attributes).must_equal(
            {
              'sulphur' => { name: 'sulphur' }
            }
          )
        end
      end

      describe '#query' do
        before { Vedeu.interface('chlorine') }

        it 'returns an instance of Hash' do
          Store.query('chlorine').must_be_instance_of(Hash)
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
        it 'returns an instance of Hash' do
          Store.reset.must_be_instance_of(Hash)
        end

        it 'deletes all records stored' do
          Vedeu.interface('potassium')

          Store.reset.must_equal({})
        end
      end
    end
end
