require_relative '../../../test_helper'
require_relative '../../../support/dummy_command'
require_relative '../../../../lib/vedeu/repository/storage'

module Vedeu
  describe Storage do
    describe '#create' do
      it 'returns the stored record' do
        Storage.new.create(DummyCommand.new)
          .must_be_instance_of(DummyCommand)
      end
    end

    describe '#delete' do
      it 'returns a NilClass' do
        Storage.new.delete(DummyCommand.new)
          .must_be_instance_of(NilClass)
      end
    end

    describe '#reset' do
      it 'returns an Array' do
        Storage.new.reset(nil).must_be_instance_of(Array)
      end
    end

    describe '#all' do
      it 'returns an Array' do
        Storage.new.all(nil).must_be_instance_of(Array)
      end
    end

    describe '#query' do
      it 'returns the item if found, otherwise false' do
        Record   = Struct.new(:name)
        storage  = Storage.new
        hydrogen = storage.create(Record.new('hydrogen'))

        storage.query(Record, :name, nil).must_equal(false)
        storage.query(Record, :name, 'lithium').must_equal(false)
        storage.query(Record, :name, 'hydrogen').must_equal(hydrogen)
      end
    end
  end
end
