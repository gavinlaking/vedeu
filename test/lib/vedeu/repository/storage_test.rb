require_relative '../../../test_helper'

module Vedeu
  describe Storage do
    let(:described_class) { Storage }
    let(:subject)         { described_class.new }
    let(:record)          { DummyCommand.new }
    let(:klass)           {}

    it 'returns a Storage instance' do
      subject.must_be_instance_of(Storage)
    end

    it 'sets an instance variable' do
      subject.instance_variable_get('@counter').must_equal(0)
    end

    it 'sets an instance variable' do
      subject.instance_variable_get('@map').must_equal({})
    end

    describe '#create' do
      let(:subject) { described_class.new.create(record) }

      it 'returns the stored record' do
        subject.must_be_instance_of(DummyCommand)
      end
    end

    describe '#delete' do
      let(:subject) { described_class.new.delete(record) }

      it 'returns a NilClass' do
        subject.must_be_instance_of(NilClass)
      end
    end

    describe '#reset' do
      let(:subject) { described_class.new.reset(klass) }

      it 'returns an Array' do
        subject.must_be_instance_of(Array)
      end
    end

    describe '#find' do
      let(:subject) { described_class.new.find(klass, id) }
      let(:id)      { 'dummy' }

      it 'returns a NilClass' do
        subject.must_be_instance_of(NilClass)
      end
    end

    describe '#all' do
      let(:subject) { described_class.new.all(klass) }

      it 'returns an Array' do
        subject.must_be_instance_of(Array)
      end
    end

    describe '#query' do
      let(:subject)   { described_class.new.query(klass, attribute, value) }
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
