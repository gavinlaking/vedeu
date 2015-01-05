require 'test_helper'

module Vedeu

  class TestModel
    attr_reader :name

    def initialize(name = nil)
      @name = name
    end
  end

  describe Repository do

    let(:described)  { Vedeu::Repository.new(model, storage) }
    let(:model)      { TestModel.new(model_name) }
    let(:model_name) { 'terbium' }
    let(:storage)    { {} }

    describe '#initialize' do
      it { return_type_for(described, Vedeu::Repository) }
      it { assigns(described, '@model', model) }
      it { assigns(described, '@storage', storage) }
    end

    describe '#all' do
      subject { described.all }

      it 'returns the whole repository' do
        subject.must_equal(storage)
      end
    end

    # describe '#current' do
    #   before { Focus.stubs(:current).returns('francium') }

    #   subject { described.current }

    #   it { return_type_for(subject, Cursor) }

    #   context 'when the cursor exists' do
    #     before { Cursor.new('francium', false, 12, 4).store }

    #     it 'has the same attributes it was stored with' do
    #       subject.x.must_equal(12)
    #       subject.y.must_equal(4)
    #     end
    #   end

    #   context 'when the cursor does not exist' do
    #     it 'is created, stored, and has the default attributes' do
    #       subject.x.must_equal(1)
    #       subject.y.must_equal(1)
    #     end
    #   end
    # end

    describe '#empty?' do
      subject { described.empty? }

      context 'when the storage is empty' do
        it { subject.must_equal(true) }
      end

      context 'when the storage is not empty' do
        let(:storage) { [mock] }

        it { subject.must_equal(false) }
      end
    end

    describe '#find' do
      subject { described.find(model_name) }

      context 'when the model cannot be found' do
        let(:model_name) { 'not_found' }

        it { proc { subject }.must_raise(ModelNotFound) }
      end

      context 'when the model is found' do
        before { described.store(model) }

        it 'returns the stored model' do
          subject.must_equal(model)
        end
      end
    end

    # describe '#find_or_create' do
    #   subject { described.find_or_create(cursor_name) }

    #   it { return_type_for(described.find_or_create('zinc'), Cursor) }

    #   context 'when the cursor exists' do
    #     let(:cursor_name) { 'niobium' }

    #     before { Cursor.new('niobium', false, 7, 9).store }

    #     it 'has the same attributes it was stored with' do
    #       subject.x.must_equal(7)
    #       subject.y.must_equal(9)
    #     end
    #   end

    #   context 'when the cursor does not exist' do
    #     let(:cursor_name) { 'zinc'}

    #     it 'is created, stored and has the default attributes' do
    #       subject.x.must_equal(1)
    #       subject.y.must_equal(1)
    #     end
    #   end
    # end

    # describe '#registered' do
    #   it 'returns an Array' do
    #     RepositoriesTestClass.new.registered.must_be_instance_of(Array)
    #   end

    #   context 'when the storage is a Hash' do
    #     it 'returns a collection of the names of all the registered entities' do
    #       repo = RepositoriesTestClass.new
    #       repo.add({ 'rutherfordium' => { name: 'rutherfordium' } })

    #       repo.registered.must_equal(['rutherfordium'])
    #     end
    #   end

    #   context 'when the storage is an Array' do
    #     it 'returns the registered entities' do
    #       repo = RepositoriesTestClass.new([])
    #       repo.add('rutherfordium')

    #       repo.registered.must_equal(['rutherfordium'])
    #     end
    #   end

    #   context 'when the storage is a Set' do
    #     it 'returns the registered entities' do
    #       repo = RepositoriesTestClass.new(Set.new)
    #       repo.add('rutherfordium')

    #       repo.registered.must_equal(['rutherfordium'])
    #     end
    #   end

    #   it 'returns an empty collection when the storage is empty' do
    #     RepositoriesTestClass.new.registered.must_equal([])
    #   end
    # end

    # describe '#registered?' do
    #   it 'returns false when the storage is empty' do
    #     RepositoriesTestClass.new.registered?('terbium').must_equal(false)
    #   end

    #   it 'returns false when the model is not registered' do
    #     repo = RepositoriesTestClass.new
    #     repo.add({ name: 'samarium' })

    #     repo.registered?('terbium').must_equal(false)
    #   end
    # end

    describe '#remove' do
      subject { described.remove('francium') }

      context 'when the storage is empty' do
        it { return_type_for(subject, FalseClass) }
      end

      context 'when the model is not registered' do
        it { return_type_for(subject, FalseClass) }
      end

      # context 'when the model is registered' do
      #   before do
      #     described.add(mock('Model', name: 'gadolinium'))
      #     described.add(mock('Model', name: 'francium'))
      #   end

      #   it 'returns the storage with the model removed' do
      #     subject.must_equal([mock('Model', name: 'gadolinium')])
      #   end
      # end
    end

    describe '#reset' do
      it 'returns a Hash' do
        described.reset.must_be_instance_of(Hash)
      end

      it 'resets the repository' do
        described.reset.must_equal({})
      end
    end

    # describe '#store' do
    #   let(:model_name) { '' }
    #   let(:model)      { mock('Model', name: model_name) }

    #   subject { described.store(model) }

    #   context 'when a name attribute is empty or nil' do
    #     it { proc { subject }.must_raise(MissingRequired) }
    #   end

    #   context 'when a name attributes is provided' do
    #     let(:model_name) { 'hydrogen' }

    #     it { return_type_for(subject, model.class) }
    #     it { return_value_for(subject, model) }
    #   end
    # end

    describe '#use' do
      subject { described.use(model_name) }

      # context 'when the model exists' do
      #   before { Repository.new.store(model) }

      #   it { return_value_for(subject, model) }
      # end

      context 'when the model does not exist' do
        let(:model_name) { 'not_found' }

        it { return_type_for(subject, NilClass) }
      end
    end

  end # Repository

end # Vedeu
