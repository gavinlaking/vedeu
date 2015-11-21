require 'test_helper'

module Vedeu

  module Editor

    class CollectionTestClass

      include Enumerable
      include Vedeu::Editor::Collection

      attr_accessor :collection

      def initialize(collection)
        @collection = collection
      end

    end # CollectionTestClass

    describe Collection do

      let(:described)  { Vedeu::Editor::Collection }
      let(:instance)   { Vedeu::Editor::CollectionTestClass.new(collection) }
      let(:collection) { 'Some text...'.chars }

      describe '#[]' do
        subject { instance.[](index) }

        context 'when the collection is a Vedeu::Editor::Line' do
          let(:collection) { 'Some text...' }

          context 'when index is a Fixnum' do
            let(:index)    { 2 }

            it { subject.must_equal('m') }
          end

          context 'when index is a Range' do
            let(:index)    { (3..6) }

            it { subject.must_equal('e te') }
          end
        end

        context 'when the collection is a Vedeu::Editor::Lines' do
          let(:collection) {
            [
              Vedeu::Editor::Line.new('Some text...'),
              Vedeu::Editor::Line.new('More text...'),
              Vedeu::Editor::Line.new('Other text...')
            ]
          }

          context 'when index is a Fixnum' do
            let(:index)    { 2 }
            let(:expected) {
              Vedeu::Editor::Line.new('Other text...')
            }

            it { subject.must_equal(expected) }
          end

          context 'when index is a Range' do
            let(:index)    { (1..2) }
            let(:expected) {
              [
                Vedeu::Editor::Line.new('More text...'),
                Vedeu::Editor::Line.new('Other text...')
              ]
            }

            it { subject.must_equal(expected) }
          end
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

        it { subject.must_equal(true) }

        context 'when different to other' do
          let(:some_collection)  {
            Vedeu::Editor::CollectionTestClass.new('Some text...'.chars)
          }
          let(:other_collection) {
            Vedeu::Editor::CollectionTestClass.new('Other text...'.chars)
          }

          it { (some_collection == other_collection).must_equal(false) }
        end
      end

      describe '#by_index' do
        let(:index) { 0 }

        subject { instance.by_index(index) }

        it { subject.must_be_instance_of(String) }
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

    end # Collection

  end # Editor

end # Vedeu
