require 'test_helper'

module Vedeu

  module Editor

    describe Delete do

      let(:described)  { Vedeu::Editor::Delete }
      let(:instance)   { described.new(collection, index, size) }
      let(:collection) {}
      let(:index)      {}
      let(:size)       {}

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@collection').must_equal(collection) }
        it { instance.instance_variable_get('@index').must_equal(index) }
        it { instance.instance_variable_get('@size').must_equal(size) }
      end

      describe '.from' do
        subject { described.from(collection, index, size) }

        context 'when the collection is a String' do
          let(:collection) { 'Some text' }

          context 'when an index is given' do
            let(:index) { 2 }
            let(:size) { collection.size }

            it { subject.must_equal('Soe text') }

            context 'when the index > size' do
              let(:index) { size + 3 }

              it { subject.must_equal('Some tex') }
            end

            context 'when the index < 0' do
              let(:index) { -3 }

              it { subject.must_equal('ome text') }
            end
          end

          context 'when an index is not given' do
            it { subject.must_equal('Some tex') }
          end
        end

        context 'when the collection is an Array' do
          let(:collection) { [:hydrogen, :helium, :lithium, :beryllium] }

          context 'when an index is given' do
            let(:index) { 2 }
            let(:size) { collection.size }

            it { subject.must_equal([:hydrogen, :helium, :beryllium]) }

            context 'when the index > size' do
              let(:index) { size + 3 }

              it { subject.must_equal([:hydrogen, :helium, :lithium]) }
            end

            context 'when the index < 0' do
              let(:index) { -3 }

              it { subject.must_equal([:helium, :lithium, :beryllium]) }
            end
          end

          context 'when an index is not given' do
            it { subject.must_equal([:hydrogen, :helium, :lithium]) }
          end
        end
      end

      describe '#delete' do
        it { instance.must_respond_to(:delete) }
      end

    end # Delete

  end # Editor

end # Vedeu
