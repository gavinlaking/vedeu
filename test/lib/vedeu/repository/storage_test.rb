require_relative '../../../test_helper'
require_relative '../../../support/dummy_command'
require_relative '../../../../lib/vedeu/repository/storage'


module Vedeu
  describe Storage do
    let(:record) { DummyCommand.new }
    let(:entity) {}

    describe '#initialize' do
      def subject
        Storage.new
      end

      it 'returns a Storage instance' do
        subject.must_be_instance_of(Storage)
      end

      it 'sets an instance variable' do
        subject.instance_variable_get('@map').must_equal({})
      end
    end

    describe '#create' do
      def subject
        Storage.new.create(record)
      end

      it 'returns the stored record' do
        subject.must_be_instance_of(DummyCommand)
      end
    end

    describe '#delete' do
      def subject
        Storage.new.delete(record)
      end

      it 'returns a NilClass' do
        subject.must_be_instance_of(NilClass)
      end
    end

    describe '#reset' do
      def subject
        Storage.new.reset(entity)
      end

      it 'returns an Array' do
        subject.must_be_instance_of(Array)
      end
    end

    describe '#find' do
      def subject
        Storage.new.find(entity, record_name)
      end
      let(:record_name) { 'dummy' }

      it 'returns a NilClass' do
        subject.must_be_instance_of(NilClass)
      end
    end

    describe '#all' do
      def subject
        Storage.new.all(entity)
      end

      it 'returns an Array' do
        subject.must_be_instance_of(Array)
      end
    end

    describe '#query' do
      def subject
        Storage.new.query(entity, attribute, value)
      end
      let(:attribute) {}
      let(:value)     {}

      context 'when the item cannot be found' do
        it 'returns a NilClass' do
          subject.must_be_instance_of(NilClass)
        end
      end
    end
  end
end
