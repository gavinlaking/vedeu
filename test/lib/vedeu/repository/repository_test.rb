require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/repository/repository'

module Vedeu
  class Dummy
    attr_reader :name

    def initialize(attributes = {})
      @name = attributes.fetch(:name, '')
    end
  end

  module DummyRepository
    extend Repository
    extend self

    def entity
      Dummy
    end
  end

  describe Repository do
    before { DummyRepository.reset }

    describe '#create' do
      it 'returns a Dummy' do
        DummyRepository.create({ name: 'dummy' })
          .must_be_instance_of(Dummy)
      end

      it 'raises an exception if called directly' do
        proc { Repository.create({ name: 'test' }) }
          .must_raise(StandardError)
      end
    end

    describe '#all' do
      it 'returns all the stored items' do
        DummyRepository.all.must_equal([])
      end

      it 'raises an exception if called directly' do
        proc { Repository.all }.must_raise(StandardError)
      end
    end

    describe '#query' do
      it 'finds an entity by attribute' do
        dumb = DummyRepository.create({ name: 'dummy' })
        result = DummyRepository.query(:name, 'dummy')
        result.must_equal(dumb)
      end

      it 'raises an exception when the entity cannot be found' do
        proc { DummyRepository.query(:name, 'dumber') }
          .must_raise(EntityNotFound)
      end

      it 'raises an exception if called directly' do
        proc { Repository.query(:name, 'test') }
          .must_raise(StandardError)
      end
    end

    describe '#reset' do
      it 'removes all stored entities' do
        DummyRepository.reset.must_equal({})
      end

      it 'raises an exception if called directly' do
        proc { Repository.reset }.must_raise(StandardError)
      end
    end

    describe '#entity' do
      it 'raises an exception if called directly' do
        proc { Repository.entity }.must_raise(StandardError)
      end
    end
  end
end
