require 'test_helper'

module Vedeu

  class StoreTestClass
    include Vedeu::Store

    attr_reader :model

    def initialize(model = nil, storage = {})
      @model   = model
      @storage = storage
    end

    private

    def in_memory
      {}
    end
  end

  describe Store do

    let(:described) { Vedeu::Store }
    let(:instance)  { Vedeu::StoreTestClass.new(model, storage) }
    let(:model)     {}
    let(:storage)   {}

    describe '#each' do
      subject { instance.each }

      it { subject.must_be_instance_of(Enumerator) }
    end

    describe '#empty?' do
      subject { instance.empty? }

      context 'when empty' do
        it { subject.must_equal(true) }
      end

      context 'when not empty' do
        let(:storage) { [:item] }

        it { subject.must_equal(false) }
      end
    end

    describe '#exists?' do
      let(:_name) {}

      subject { instance.exists?(_name) }

      context 'when empty' do
        let(:_name) { 'terbium' }

        it { subject.must_equal(false) }
      end

      context 'with no name' do
        it { subject.must_equal(false) }
      end

      context 'with empty name' do
        let(:_name) { '' }

        it { subject.must_equal(false) }
      end

      context 'when the model does not exist' do
        let(:storage) { { 'samarium' => [:some_model_data] } }
        let(:_name)   { 'terbium' }

        it { subject.must_equal(false) }
      end

      context 'when the model exists' do
        let(:storage) { { 'samarium' => [:some_model_data] } }
        let(:_name)   { 'samarium' }

        it { subject.must_equal(true) }
      end

      it { instance.must_respond_to(:registered?) }
    end

    describe '#reset' do
      it 'returns a Hash' do
        instance.reset.must_be_instance_of(Hash)
      end

      it 'resets the repository' do
        instance.reset.must_equal({})
      end

      it { instance.must_respond_to(:reset!) }
      it { instance.must_respond_to(:clear) }
    end

    describe '#size' do
      subject { instance.size }

      context 'when empty' do
        it { subject.must_equal(0) }
      end

      context 'when not empty' do
        let(:storage) { [:item] }

        it { subject.must_equal(1) }
      end
    end

    describe '#storage' do
      subject { instance.storage }

      it { subject.must_equal({}) }

      it { instance.must_respond_to(:all) }
    end

  end # Store

end # Vedeu
