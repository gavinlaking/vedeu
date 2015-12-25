# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Repositories

    class StoreTestClass
      include Vedeu::Repositories::Store

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

      let(:described) { Vedeu::Repositories::Store }
      let(:instance)  { Vedeu::Repositories::StoreTestClass.new(model, storage) }
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
      end

      describe '#registered?' do
        it { instance.must_respond_to(:registered?) }
      end

      describe '#registered' do
        subject { instance.registered }

        it { subject.must_be_instance_of(Array) }

        context 'when the storage is a Hash' do
          let(:storage) {
            {
              'rutherfordium' => { name: 'rutherfordium' }
            }
          }

          it 'returns a collection of the names of all the registered entities' do
            subject.must_equal(['rutherfordium'])
          end
        end

        context 'when the storage is an Array' do
          let(:storage) { ['rutherfordium'] }

          it 'returns the registered entities' do
            subject.must_equal(['rutherfordium'])
          end
        end

        context 'when the storage is a Set' do
          let(:storage) { Set['rutherfordium'] }

          it 'returns the registered entities' do
            subject.must_equal(['rutherfordium'])
          end
        end

        context 'when the storage is empty' do
          it 'returns an empty collection' do
            subject.must_equal([])
          end
        end
      end

      describe '#reset' do
        before { Vedeu.stubs(:log) }

        it 'returns a Hash' do
          instance.reset.must_be_instance_of(Hash)
        end

        it 'resets the repository' do
          instance.reset.must_equal({})
        end
      end

      describe '#reset!' do
        it { instance.must_respond_to(:reset!) }
      end

      describe '#clear' do
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
      end

      describe '#all' do
        it { instance.must_respond_to(:all) }
      end

    end # Store

  end # Repositories

end # Vedeu
