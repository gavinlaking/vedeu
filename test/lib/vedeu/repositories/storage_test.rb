require_relative '../../../test_helper'
require_relative '../../../support/dummy_command'
require_relative '../../../../lib/vedeu/repositories/storage'

module Vedeu
  class DummyRecord
    attr_reader :name

    def initialize(attributes = {})
      @name = attributes.fetch(:name, '')
    end
  end

  module Repositories
    describe Storage do
      describe '#create' do
        it 'returns the stored record' do
          storage = Storage.new
          storage.create(DummyRecord, {})
            .must_be_instance_of(DummyRecord)
        end
      end

      describe '#reset' do
        it 'deletes all records for this entity' do
          storage = Storage.new
          storage.create(DummyRecord, { name: 'dumb' })
          storage.create(DummyRecord, { name: 'dumber' })
          storage.all(DummyRecord).size.must_equal(2)

          storage.reset(DummyRecord).must_equal({})
        end
      end

      describe '#all' do
        it 'returns all entity records if an entity is provided' do

        end

        it 'returns all records if no entity provided' do

        end


        it 'returns an empty collection when no records were found' do
          storage = Storage.new
          storage.all(DummyRecord).must_equal([])
        end
      end

      describe '#query' do
        it 'returns the record if found' do
          storage  = Storage.new
          hydrogen = storage.create(DummyRecord, { name: 'hydrogen' })

          storage.query(DummyRecord, :name, 'hydrogen')
            .must_be_instance_of(DummyRecord)
          storage.query(DummyRecord, :name, 'hydrogen')
            .name.must_equal('hydrogen')
        end

        it 'returns false if the record is not found' do
          storage  = Storage.new
          hydrogen = storage.create(DummyRecord, { name: 'hydrogen' })

          storage.query(DummyRecord, :name, nil).must_equal(false)
          storage.query(DummyRecord, :name, 'lithium').must_equal(false)
        end
      end
    end
  end
end
