require 'test_helper'

module Vedeu

  describe Repository do

    describe '#all' do
      it 'returns a Hash' do
        RepositoriesTestClass.new.all.must_be_instance_of(Hash)
      end

      it 'returns the whole repository' do
        RepositoriesTestClass.new.all.must_equal({})
      end
    end

    describe '#find' do
      it 'raises an exception when the model cannot be found' do
        proc {
          RepositoriesTestClass.new.find('terbium')
        }.must_raise(ModelNotFound)
      end

      context 'when the model is found' do
        it 'returns the stored model' do
          model = { key: :value }
          repo   = RepositoriesTestClass.new
          repo.add({ 'terbium' => model })

          repo.find('terbium').must_equal(model)
        end
      end
    end

    describe '#find_or_create' do
      context 'when the model is found by name' do
        it 'returns the storage model' do
          skip
        end
      end

      context 'when the model is not found by name' do
        it 'stores the newly created model' do
          skip
        end

        it 'returns the newly created model' do
          skip
        end
      end
    end

    describe '#not_found' do
      subject { RepositoryTestModule.find('hydrogen') }

      it 'raises an exception when the model cannot be found' do
        proc { subject }.must_raise(ModelNotFound)
      end
    end

    describe '#registered' do
      it 'returns an Array' do
        RepositoriesTestClass.new.registered.must_be_instance_of(Array)
      end

      context 'when the storage is a Hash' do
        it 'returns a collection of the names of all the registered entities' do
          repo = RepositoriesTestClass.new
          repo.add({ 'rutherfordium' => { name: 'rutherfordium' } })

          repo.registered.must_equal(['rutherfordium'])
        end
      end

      context 'when the storage is an Array' do
        it 'returns the registered entities' do
          repo = RepositoriesTestClass.new([])
          repo.add('rutherfordium')

          repo.registered.must_equal(['rutherfordium'])
        end
      end

      context 'when the storage is a Set' do
        it 'returns the registered entities' do
          repo = RepositoriesTestClass.new(Set.new)
          repo.add('rutherfordium')

          repo.registered.must_equal(['rutherfordium'])
        end
      end

      it 'returns an empty collection when the storage is empty' do
        RepositoriesTestClass.new.registered.must_equal([])
      end
    end

    describe '#registered?' do
      it 'returns false when the storage is empty' do
        RepositoriesTestClass.new.registered?('terbium').must_equal(false)
      end

      it 'returns false when the model is not registered' do
        repo = RepositoriesTestClass.new
        repo.add({ name: 'samarium' })

        repo.registered?('terbium').must_equal(false)
      end

      it 'returns true when the model is registered' do
        skip

        repo = RepositoriesTestClass.new
        repo.add({ name: 'samarium' })

        repo.registered?('samarium').must_equal(true)
      end
    end

    describe '#remove' do
      context 'when the storage is empty' do
        it 'returns false' do
          test_repo = RepositoriesTestClass.new
          test_repo.remove('francium').must_equal(false)
        end
      end

      context 'when the model is not registered' do
        it 'returns false' do
          test_repo = RepositoriesTestClass.new
          test_repo.add({
            'gadolinium' => 'rare-earth metal',
            'samarium'   => 'a hard silvery metal'
          })
          test_repo.remove('francium').must_equal(false)
        end
      end

      context 'when the model is registered' do
        it 'returns the storage with the model removed' do
          test_repo = RepositoriesTestClass.new
          test_repo.add({
            'gadolinium' => 'rare-earth metal',
            'samarium'   => 'a hard silvery metal'
          })
          test_repo.remove('samarium').must_equal({
            'gadolinium' => 'rare-earth metal',
          })
        end
      end

      context 'alias method: #destroy' do
        it 'returns the storage with the model removed' do
          test_repo = RepositoriesTestClass.new
          test_repo.add({
            'gadolinium' => 'rare-earth metal',
            'samarium'   => 'a hard silvery metal'
          })
          test_repo.destroy('samarium').must_equal({
            'gadolinium' => 'rare-earth metal',
          })
        end
      end

      context 'alias method; #delete' do
        it 'returns the storage with the model removed' do
          test_repo = RepositoriesTestClass.new
          test_repo.add({
            'gadolinium' => 'rare-earth metal',
            'samarium'   => 'a hard silvery metal'
          })
          test_repo.delete('samarium').must_equal({
            'gadolinium' => 'rare-earth metal',
          })
        end
      end
    end

    describe '#reset' do
      it 'returns a Hash' do
        RepositoriesTestClass.new.reset.must_be_instance_of(Hash)
      end

      it 'resets the repository' do
        RepositoriesTestClass.new.reset.must_equal({})
      end
    end

    describe '#store' do
      let(:attributes) {
        {
          name: 'hydrogen'
        }
      }
      let(:model) { ModelTestClass.new(attributes) }

      subject { RepositoriesTestClass.new.store(model) }

      it 'returns the model' do
        subject.must_be_instance_of(model.class)
      end
    end

  end # Repository

end # Vedeu
