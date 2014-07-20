require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/repository/repository'

module Vedeu
  class Dummy
    def name
      'dummy'
    end
  end

  class DummyRepository
    extend Repository

    def self.entity
      Dummy
    end
  end

  describe Repository do
    describe '#adaptor' do
      it 'returns a Storage' do
        DummyRepository.adaptor.must_be_instance_of(Storage)
      end
    end

    describe '#all' do
      it 'returns all the stored items' do
        DummyRepository.all.must_be_instance_of(Array)
      end
    end

    describe '#query' do
      it 'delegates to the adaptor' do
        dumb = Dummy.new
        DummyRepository.create(dumb)

        result = DummyRepository.query(Dummy, :name, 'dummy')
        result.must_equal(dumb)

        result = DummyRepository.query(Dummy, :name, 'dumber')
        result.must_equal(false)
      end
    end

    describe '#create' do
      it 'returns a Dummy' do
        dummy = DummyRepository.create(Dummy.new)
        DummyRepository.create(dummy).must_be_instance_of(Dummy)
      end
    end

    describe '#reset' do
      it 'returns an Array' do
        DummyRepository.reset.must_be_instance_of(Array)
      end
    end
  end
end
