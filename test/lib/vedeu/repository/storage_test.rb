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

    describe '#find' do
      it 'returns a NilClass' do
        Storage.new.find(nil, 'dummy').must_be_instance_of(NilClass)
      end
    end

    describe '#all' do
      it 'returns an Array' do
        Storage.new.all(nil).must_be_instance_of(Array)
      end
    end

    describe '#query' do
      it 'returns a FalseClass when the item cannot be found' do
        Storage.new.query(nil, nil, nil)
          .must_be_instance_of(FalseClass)
      end
    end
  end
end
