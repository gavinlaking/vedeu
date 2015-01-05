require 'test_helper'

module Vedeu

  module Model

    describe Collection do

      let(:described)  { Collection }
      let(:instance)   { described.new(collection, parent, model_name) }
      let(:collection) { [] }
      let(:model_name) { 'elements' }
      let(:parent)     { Vedeu::ModelTestClass.new }

      describe '#initialize' do
        subject { instance }

        it { return_type_for(subject, Collection) }
        it { assigns(subject, '@collection', []) }
        it { assigns(subject, '@name', model_name) }
        it { assigns(subject, '@parent', parent) }
      end

      describe '#[]' do
        let(:collection) { [:hydrogen, :helium, :lithium, :beryllium] }
        let(:value) { 1..2 }

        subject { instance[value] }

        it { return_type_for(subject, Array) }
        it { return_value_for(subject, [:helium, :lithium]) }
      end

      describe '#add' do
        subject { instance.add(:hydrogen) }

        it { return_type_for(subject, Collection) }
        it { return_value_for(subject.all, [:hydrogen]) }

        context 'with multiple objects' do
          subject { instance.add(:hydrogen, :helium) }

          it 'adds all the objects to the collection' do
            return_value_for(subject.all, [:hydrogen, :helium])
          end
        end
      end

      describe '#all' do
        subject { instance.all }

        it { return_type_for(subject, Array) }
        it { return_value_for(subject, []) }

        context 'when the collection is not empty' do
          before { instance.add(:hydrogen) }

          it 'returns the populated collection' do
            return_value_for(subject, [:hydrogen])
          end
        end
      end

      describe '#empty?' do
        subject { instance.empty? }

        context 'when the collection is empty' do
          it { return_type_for(subject, TrueClass) }
        end

        context 'when the collection is not empty' do
          before { instance.add(:hydrogen) }

          it { return_type_for(subject, FalseClass) }
        end
      end

      describe '#size' do
        subject { instance.size }

        it { return_type_for(subject, Fixnum) }

        context 'when the collection is empty' do
          it { return_value_for(subject, 0) }
        end

        context 'when the collection is not empty' do
          before { instance.add(:hydrogen) }

          it { return_value_for(subject, 1) }
        end
      end

      describe '#to_s' do
        subject { instance.to_s }

        it { return_type_for(subject, String) }

        context 'when the collection is empty' do
          it { return_value_for(subject, '') }
        end

        context 'when the collection is not empty' do
          before { instance.add(:hydrogen) }

          it { return_value_for(subject, 'hydrogen') }
        end
      end

    end # Collection

  end # Model

end # Vedeu
