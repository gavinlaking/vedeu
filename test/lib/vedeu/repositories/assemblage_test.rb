require 'test_helper'

module Vedeu

  module Repositories

    class CollectionTestClass

      include Vedeu::Repositories::Assemblage

      attr_accessor :collection

      def initialize(collection)
        @collection = collection
      end

    end # CollectionTestClass

    describe Assemblage do

      let(:described)  { Vedeu::Repositories::Assemblage }
      let(:instance)   { Vedeu::Repositories::CollectionTestClass.new(collection) }
      let(:collection) { 'Some text...'.chars }

      describe '#[]' do
        let(:collection) { [:hydrogen, :helium, :lithium, :beryllium] }

        subject { instance[index] }

        context 'when the index is a range' do
          let(:index) { 1..2 }

          it { subject.must_be_instance_of(Array) }
          it { subject.must_equal([:helium, :lithium]) }
        end

        context 'when the index is an integer' do
          let(:index) { 3 }

          it { subject.must_be_instance_of(Symbol) }
          it { subject.must_equal(:beryllium) }
        end
      end

      describe '#any?' do
        subject { instance.any? }

        context 'when the collection is empty' do
          let(:collection) { [] }

          it { subject.must_equal(false) }
        end

        context 'when the collection is not empty' do
          it { subject.must_equal(true) }
        end
      end

      describe '#empty?' do
        subject { instance.empty? }

        context 'when the collection is empty' do
          let(:collection) { [] }

          it { subject.must_equal(true) }
        end

        context 'when the collection is not empty' do
          it { subject.must_equal(false) }
        end
      end

      describe '#eql?' do
        let(:other) { instance }

        subject { instance.eql?(other) }

        it { instance.must_respond_to(:==) }

        it { subject.must_equal(true) }

        context 'when different to other' do
          let(:some_collection)  {
            Vedeu::Repositories::CollectionTestClass.new('Some text...'.chars)
          }
          let(:other_collection) {
            Vedeu::Repositories::CollectionTestClass.new('Other text...'.chars)
          }

          it { (some_collection == other_collection).must_equal(false) }
        end
      end

      describe '#size' do
        subject { instance.size }

        context 'when the collection is empty' do
          let(:collection) { [] }

          it { subject.must_equal(0) }
        end

        context 'when the collection is not empty' do
          it { subject.must_equal(12) }
        end
      end

    end # Assemblage

  end # Repositories

end # Vedeu
