# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Repositories

    module StorageTestModule

      extend self
      extend Vedeu::Repositories::Storage

      def store(test_item = nil)
        storage << test_item if test_item
      end

      def in_memory
        []
      end

    end # StorageTestModule

    describe Storage do

      let(:extended_described) { Vedeu::Repositories::StorageTestModule }

      describe '#all' do
        it { extended_described.must_respond_to(:all) }
      end

      describe '#reset' do
        it { extended_described.must_respond_to(:reset) }
      end

      describe '#reset!' do
        before do
          extended_described.reset!
          extended_described.store(:some_item)
        end

        subject { extended_described.reset! }

        it 'resets the storage to an empty state' do
          extended_described.storage.must_equal([:some_item])
          subject.must_equal([])
        end
      end

      describe '#storage' do
        subject { extended_described.storage }

        context 'when the storage is empty' do
          before { extended_described.reset! }

          it { subject.must_equal([]) }
        end

        context 'when the storage is not empty' do
          let(:expected) { [:some_item, :other_item] }

          before do
            extended_described.reset!
            extended_described.store(:some_item)
            extended_described.store(:other_item)
          end

          it { subject.must_equal(expected) }
        end
      end

    end # Storage

  end # Repositories

end # Vedeu
