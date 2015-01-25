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

        it { subject.must_be_instance_of(Collection) }
        it { subject.instance_variable_get('@collection').must_equal([]) }
        it { subject.instance_variable_get('@name').must_equal(model_name) }
        it { subject.instance_variable_get('@parent').must_equal(parent) }
      end

      describe '#[]' do
        let(:collection) { [:hydrogen, :helium, :lithium, :beryllium] }
        let(:value) { 1..2 }

        subject { instance[value] }

        it { subject.must_be_instance_of(Array) }
        it { subject.must_equal([:helium, :lithium]) }
      end

      describe '#add' do
        subject { instance.add(:hydrogen) }

        it { subject.must_be_instance_of(Collection) }
        it { subject.all.must_equal([:hydrogen]) }

        context 'with multiple objects' do
          subject { instance.add(:hydrogen, :helium) }

          it 'adds all the objects to the collection' do
            subject.all.must_equal([:hydrogen, :helium])
          end
        end
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

      describe '#empty?' do
        subject { instance.empty? }

        context 'when the collection is empty' do
          it { subject.must_be_instance_of(TrueClass) }
        end

        context 'when the collection is not empty' do
          before { instance.add(:hydrogen) }

          it { subject.must_be_instance_of(FalseClass) }
        end
      end

      describe '#size' do
        subject { instance.size }

        it { subject.must_be_instance_of(Fixnum) }

        context 'when the collection is empty' do
          it { subject.must_equal(0) }
        end

        context 'when the collection is not empty' do
          before { instance.add(:hydrogen) }

          it { subject.must_equal(1) }
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

  end # Model

end # Vedeu
