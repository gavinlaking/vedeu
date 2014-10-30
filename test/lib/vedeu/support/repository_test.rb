require 'test_helper'

module Vedeu
  EntityNotFound = Class.new(StandardError)

  class RepositoryTestClass
    include Repository

    def add(hash)
      @_storage = in_memory.merge!(hash)
    end

    def in_memory
      @_storage ||= {}
    end
    alias_method :storage, :in_memory

    def not_found(name)
      fail EntityNotFound
    end
  end # RepositoryTestClass

  describe Repository do

    describe '#all' do
      it 'returns a Hash' do
        RepositoryTestClass.new.all.must_be_instance_of(Hash)
      end

      it 'returns the whole repository' do
        RepositoryTestClass.new.all.must_equal({})
      end
    end

    describe '#find' do
      it 'raises an exception when the entity cannot be found' do
        proc { RepositoryTestClass.new.find('terbium') }
          .must_raise(EntityNotFound)
      end
    end

    describe '#registered' do
      it 'returns an Array' do
        RepositoryTestClass.new.registered.must_be_instance_of(Array)
      end

      it 'returns a collection of the names of all the registered entities' do
        RepositoryTestClass.new.registered.must_equal([])
      end
    end

    describe '#registered?' do
      it 'returns a FalseClass' do
        RepositoryTestClass.new.registered?('terbium')
          .must_be_instance_of(FalseClass)
      end

      it 'returns false when the entity is not registered' do
        RepositoryTestClass.new.registered?('terbium').must_equal(false)
      end
    end

    describe '#remove' do
      context 'when the entity is not registered' do
        it 'returns false' do
          test_repo = RepositoryTestClass.new
          test_repo.add({
            'gadolinium' => 'rare-earth metal',
            'samarium'   => 'a hard silvery metal'
          })
          test_repo.remove('francium').must_equal(false)
        end
      end

      context 'when the entity is registered' do
        it 'returns the storage with the entity removed' do
          test_repo = RepositoryTestClass.new
          test_repo.add({
            'gadolinium' => 'rare-earth metal',
            'samarium'   => 'a hard silvery metal'
          })
          test_repo.remove('samarium').must_equal({
            'gadolinium' => 'rare-earth metal',
          })
        end
      end
    end

    describe '#reset' do
      it 'returns a Hash' do
        RepositoryTestClass.new.reset.must_be_instance_of(Hash)
      end

      it 'resets the repository' do
        RepositoryTestClass.new.reset.must_equal({})
      end
    end

  end # Repository

end # Vedeu
