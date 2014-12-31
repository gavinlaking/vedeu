require 'test_helper'

module Vedeu

  module Model

    describe Collection do

      let(:described)  { Collection.new(parent, collection) }
      let(:parent)     { Vedeu::ModelTestClass.new }
      let(:collection) {}

      describe '#initialize' do
        it { return_type_for(described, Collection) }
        it { assigns(described, '@parent', parent) }
        it { assigns(described, '@collection', []) }
      end

      describe '#add' do
        it { return_type_for(described.add(:hydrogen), Collection) }
        it { return_value_for(described.add(:hydrogen).all, [:hydrogen]) }

        context 'with multiple objects' do
          subject { described.add(:hydrogen, :helium) }

          it 'adds all the objects to the collection' do
            return_value_for(subject.all, [:hydrogen, :helium])
          end
        end
      end

      describe '#all' do
        it { return_type_for(described.all, Array) }
        it { return_value_for(described.all, []) }

        context 'when models have been added to the collection' do
          it 'returns the populated collection' do
            described.add(:hydrogen)
            return_value_for(described.all, [:hydrogen])
          end
        end
      end

      describe '#empty?' do
        context 'when the collection is empty' do
          it { return_type_for(described.empty?, TrueClass) }
        end

        context 'when the collection is not empty' do
          before { described.add(:hydrogen) }

          it { return_type_for(described.empty?, FalseClass) }
        end
      end

      describe '#size' do
        it { return_type_for(described.size, Fixnum) }

        context 'when the collection is empty' do
          it { return_value_for(described.size, 0) }
        end

        context 'when the collection is not empty' do
          before { described.add(:hydrogen) }

          it { return_value_for(described.size, 1) }
        end
      end

      describe '#to_s' do
        it { return_type_for(described.to_s, String) }

        context 'when the collection is empty' do
          it { return_value_for(described.to_s, '') }
        end

        context 'when the collection is not empty' do
          before { described.add(:hydrogen) }

          it { return_value_for(described.to_s, 'hydrogen') }
        end
      end

    end # Collection

  end # Model

end # Vedeu
