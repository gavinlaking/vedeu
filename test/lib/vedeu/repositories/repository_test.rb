require 'test_helper'

module Vedeu

  class RepositoriesTestClass < Vedeu::Repository

    attr_accessor :storage
    alias_method :in_memory, :storage

    def initialize(storage = {})
      @storage = storage
    end

    def add(model)
      if storage.is_a?(Hash)
        @storage = in_memory.merge!(model)

      else
        @storage << model

      end
    end

  end # RepositoriesTestClass

  class TestRepository < Vedeu::Repository
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

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@model').must_equal(model) }
      it { instance.instance_variable_get('@storage').must_equal(storage) }
    end

    describe 'accessors' do
      it { instance.must_respond_to(:model) }
      it { instance.must_respond_to(:storage) }
    end

    describe '#all' do
      subject { instance.all }

      context 'when there are no models stored in the repository' do
        before { instance.reset }

        it { subject.must_equal([]) }
      end

      context 'when there are models stored in the repository' do
        context 'when the repository is a glorified Hash' do
          let(:storage) {
            {
              oxygen:    :life,
              plutonium: :death,
            }
          }
          it { subject.must_equal([:life, :death]) }
        end

        context 'when the repository is a glorified Set' do
          let(:storage) { Set[:oxygen, :hydrogen] }

          it { subject.must_equal([:oxygen, :hydrogen]) }
        end

        context 'when the repository is unknown' do
          let(:storage) { [:hydrogen, :helium] }

          it { subject.must_equal([:hydrogen, :helium]) }
        end
      end
    end

    describe '#by_name' do
      let(:_name) { 'carbon' }

      subject { instance.by_name(_name) }

      context 'when the model exists' do
        # it { skip }
      end

      context 'when the model does not exist' do
        # it { skip }
      end
    end

    describe '#current' do
      subject { instance.current }

      context 'when there is nothing in focus' do
        before { Vedeu.stubs(:focus) }

        it { subject.must_be_instance_of(NilClass) }
      end

      context 'when there something in focus' do
        before { Vedeu.stubs(:focus).returns('zinc') }

        it { subject.must_be_instance_of(Vedeu::TestModel) }
      end
    end

    describe '#find' do
      subject { instance.find(model_name) }

      context 'when the model cannot be found' do
        let(:model_name) { 'not_found' }

        it { subject.must_be_instance_of(NilClass) }
      end

      context 'when the model is found' do
        let(:model_instance) { model.new('terbium') }

        before { instance.store(model_instance) }

        it 'returns the stored model' do
          subject.must_equal(model_instance)
        end
      end
    end

    describe '#find!' do
      subject { instance.find!(model_name) }

      context 'when the model cannot be found' do
        let(:model_name) { 'not_found' }

        it { proc { subject }.must_raise(Vedeu::Error::ModelNotFound) }
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

    describe '#inspect' do
      subject { instance.inspect }

      it { subject.must_be_instance_of(String) }
      it { subject.must_equal('<Vedeu::Repository>') }
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
        repo.add(name: 'samarium')

        repo.registered?('terbium').must_equal(false)
      end
    end

    describe '#remove' do
      subject { instance.remove('francium') }

      it { instance.must_respond_to(:destroy) }
      it { instance.must_respond_to(:delete) }
      it { instance.must_respond_to(:deregister) }

      context 'when the storage is empty' do
        before { instance.reset }

        it { subject.must_be_instance_of(FalseClass) }
      end

      context 'when the model is not registered' do
        before {
          instance.reset
          instance.store(Vedeu::TestModel.new('zinc'))
        }

        it { subject.must_be_instance_of(FalseClass) }
      end

      context 'when the model is registered' do
        before {
          instance.reset
          instance.store(Vedeu::TestModel.new('gadolinium'))
          instance.store(Vedeu::TestModel.new('francium'))
        }

        it 'returns the storage with the model removed' do
          subject.size.must_equal(1)
        end
      end
    end

    describe '#store' do
      subject { instance.store(model_instance) }

      it { instance.must_respond_to(:register) }

      context 'when a name attribute is empty or nil' do
        before { model_instance.name = '' }

        it { proc { subject }.must_raise(Vedeu::Error::MissingRequired) }
      end

      context 'when a name attributes is provided' do
        let(:model_name) { 'hydrogen' }

        it { subject.must_be_instance_of(Vedeu::TestModel) }
      end
    end

  end # Repository

end # Vedeu
