require 'test_helper'

module Vedeu

  module Repositories

    describe Collection do

      let(:described)  { Vedeu::Repositories::Collection }
      let(:instance)   { described.new(collection, parent, model_name) }
      let(:collection) { [] }
      let(:model_name) { 'elements' }
      let(:parent)     { Vedeu::Repositories::ModelTestClass.new }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@collection').must_equal([]) }
        it { instance.instance_variable_get('@name').must_equal(model_name) }
        it { instance.instance_variable_get('@parent').must_equal(parent) }
      end

      describe 'accessors' do
        it do
          instance.must_respond_to(:collection)
          instance.must_respond_to(:all)
          instance.must_respond_to(:value)
          instance.must_respond_to(:parent)
          instance.must_respond_to(:parent=)
          instance.must_respond_to(:name)
          instance.must_respond_to(:name=)
        end
      end

      describe '.coerce' do
        subject { described.coerce(collection, parent, model_name) }

        # @todo Add more tests.
        # it { skip }
      end

      describe '#add' do
        subject { instance.add(:hydrogen) }

        it { instance.must_respond_to(:<<) }
        it { subject.must_be_instance_of(Vedeu::Repositories::Collection) }
        it { subject.all.must_equal([:hydrogen]) }
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

    end # Collection

  end # Repositories

end # Vedeu
