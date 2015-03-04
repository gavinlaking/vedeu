require 'test_helper'

module Vedeu

  class TestRepository < Repository
  end

  class TestModel
    include Vedeu::Model

    attr_accessor :name

    def initialize(name = nil)
      @name = name
      @repository = Vedeu::TestRepository.new(self.class)
    end
  end

  describe Repository do

    let(:described)      { Vedeu::Repository }
    let(:instance)       { described.new(model, storage) }
    let(:model)          { Vedeu::TestModel }
    let(:model_instance) { model.new(model_name) }
    let(:model_name)     { 'terbium' }
    let(:storage)        { {} }

    describe 'alias methods' do
      it { instance.must_respond_to(:by_name) }
      it { instance.must_respond_to(:destroy) }
      it { instance.must_respond_to(:delete) }
      it { instance.must_respond_to(:deregister) }
      it { instance.must_respond_to(:register) }
    end

    describe '#initialize' do
      it { instance.must_be_instance_of(Vedeu::Repository) }
      it { instance.instance_variable_get('@model').must_equal(model) }
      it { instance.instance_variable_get('@storage').must_equal(storage) }
    end

    describe '#all' do
      subject { instance.all }

      it 'returns the whole repository' do
        subject.must_equal(storage)
      end
    end

    describe '#each' do
      subject { instance.each }

      it { subject.must_be_instance_of(Enumerator) }
    end

    describe '#empty?' do
      subject { instance.empty? }

      context 'when the storage is empty' do
        it { subject.must_equal(true) }
      end

      context 'when the storage is not empty' do
        let(:storage) { [:item] }

        it { subject.must_equal(false) }
      end
    end

    describe '#find' do
      subject { instance.find(model_name) }

      context 'when the model cannot be found' do
        let(:model_name) { 'not_found' }

        it { proc { subject }.must_raise(ModelNotFound) }
      end

      context 'when the model is found' do
        let(:model_instance) { model.new('terbium') }

        before { instance.store(model_instance) }

        it 'returns the stored model' do
          subject.must_equal(model_instance)
        end
      end
    end

    describe '#find_or_create' do
      let(:model_instance) { TestModel.new('niobium') }

      subject { instance.find_or_create(model_name) }

      it { instance.find_or_create('zinc').must_be_instance_of(Vedeu::TestModel) }

      context 'when the model exists' do
        let(:model_name) { 'niobium' }

        before { instance.store(model_instance) }

        it { subject.must_equal(model_instance) }
      end

      context 'when the model does not exist' do
        let(:model_name) { 'zinc'}

        it 'creates and stores a new instance of the model' do
          subject.must_be_instance_of(Vedeu::TestModel)
        end
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
      it 'returns false with no name' do
        RepositoriesTestClass.new.registered?('').must_equal(false)
      end

      it 'returns false with no name' do
        RepositoriesTestClass.new.registered?(nil).must_equal(false)
      end

      it 'returns false when the storage is empty' do
        RepositoriesTestClass.new.registered?('terbium').must_equal(false)
      end

      it 'returns false when the model is not registered' do
        repo = RepositoriesTestClass.new
        repo.add({ name: 'samarium' })

        repo.registered?('terbium').must_equal(false)
      end
    end

    describe '#remove' do
      subject { instance.remove('francium') }

      context 'when the storage is empty' do
        before { instance.reset }

        it { subject.must_be_instance_of(FalseClass) }
      end

      context 'when the model is not registered' do
        before do
          instance.reset
          instance.store(Vedeu::TestModel.new('zinc'))
        end

        it { subject.must_be_instance_of(FalseClass) }
      end

      context 'when the model is registered' do
        before do
          instance.reset
          instance.store(Vedeu::TestModel.new('gadolinium'))
          instance.store(Vedeu::TestModel.new('francium'))
        end

        it 'returns the storage with the model removed' do
          subject.size.must_equal(1)
        end
      end
    end

    describe '#reset' do
      it 'returns a Hash' do
        instance.reset.must_be_instance_of(Hash)
      end

      it 'resets the repository' do
        instance.reset.must_equal({})
      end
    end

    describe '#store' do
      subject { instance.store(model_instance) }

      context 'when a name attribute is empty or nil' do
        before { model_instance.name = '' }

        it { proc { subject }.must_raise(MissingRequired) }
      end

      context 'when a name attributes is provided' do
        let(:model_name) { 'hydrogen' }

        it { subject.must_be_instance_of(Vedeu::TestModel) }
      end
    end

    describe '#use' do
      subject { instance.use(model_name) }

      context 'when the model exists' do
        before { instance.store(model_instance) }

        it { subject.must_equal(model_instance) }
      end

      context 'when the model does not exist' do
        let(:model_name) { 'not_found' }

        it { subject.must_be_instance_of(NilClass) }
      end
    end

  end # Repository

end # Vedeu
