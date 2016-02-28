# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Repositories

    class CollectionTestClass
    end # CollectionTestClass

    describe Collection do

      let(:described)  { Vedeu::Repositories::Collection }
      let(:instance)   { described.new(collection, parent, model_name) }
      let(:collection) { [] }
      let(:model_name) { :vedeu_repositories_collection }
      let(:parent)     { Vedeu::Repositories::CollectionTestClass.new() }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@collection').must_equal([]) }
        it { instance.instance_variable_get('@name').must_equal(model_name) }
        it { instance.instance_variable_get('@parent').must_equal(parent) }
      end

      describe '#collection' do
        it { instance.must_respond_to(:collection) }
      end

      describe '#all' do
        it { instance.must_respond_to(:all) }
      end

      describe '#value' do
        it { instance.must_respond_to(:value) }
      end

      describe '#parent' do
        it { instance.must_respond_to(:parent) }
      end

      describe '#parent=' do
        it { instance.must_respond_to(:parent=) }
      end

      describe '#name' do
        it { instance.must_respond_to(:name) }
      end

      describe '#name=' do
        it { instance.must_respond_to(:name=) }
      end

      describe '.coerce' do
        subject { described.coerce(collection, parent, model_name) }

        # @todo Add more tests.
        # it { skip }
      end

      describe '#add' do
        subject { instance.add(:hydrogen) }

        it { subject.must_be_instance_of(described) }
        it { subject.all.must_equal([:hydrogen]) }
      end

      describe '#<<' do
        it { instance.must_respond_to(:<<) }
      end

      describe '#all' do
        subject { instance.all }

        it { subject.must_be_instance_of(Array) }
        it { subject.must_equal([]) }

        context 'when the collection is not empty' do
          before { instance.add(:hydrogen) }

          it 'returns the populated collection' do
            subject.must_equal([:hydrogen])
          end
        end
      end

      describe '#to_s' do
        subject { instance.to_s }

        it { subject.must_be_instance_of(String) }

        context 'when the collection is empty' do
          it { subject.must_equal('') }
        end

        context 'when the collection is not empty' do
          before { instance.add(:hydrogen) }

          it { subject.must_equal('hydrogen') }
        end
      end

      describe '#to_str' do
        it { instance.must_respond_to(:to_str) }
      end

    end # Collection

  end # Repositories

end # Vedeu
