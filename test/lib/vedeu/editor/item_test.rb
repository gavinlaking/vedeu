# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Editor

    describe Item do

      let(:described)  { Vedeu::Editor::Item }
      let(:instance)   { described.new(collection, index) }
      let(:collection) {}
      let(:index)      {}

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@collection').must_equal(collection) }
        it { instance.instance_variable_get('@index').must_equal(index) }
      end

      describe '.by_index' do
        subject { described.by_index(collection, index) }

        context 'when the collection is empty or nil' do
          it { assert_nil(subject) }
        end

        context 'when the collection is not empty' do
          let(:collection) { [:hydrogen, :helium, :lithium] }

          context 'when the index is nil' do
            it 'returns the last item' do
              subject.must_equal(:lithium)
            end
          end

          context 'when the index is greater than the size of the collection' do
            let(:index) { 4 }

            it 'returns the last item' do
              subject.must_equal(:lithium)
            end
          end

          context 'when the index < 0' do
            let(:index) { -2 }

            it { subject.must_equal(:hydrogen) }
          end

          context 'when the index == 0' do
            let(:index) { 0 }

            it { subject.must_equal(:hydrogen) }
          end

          context 'when the index > 0 and the index is less than the size of ' \
                  'the collection' do
            let(:index) { 1 }

            it { subject.must_equal(:helium) }
          end
        end
      end

      describe '#by_index' do
        it { instance.must_respond_to(:by_index) }
      end

    end # Item

  end # Editor

end # Vedeu
