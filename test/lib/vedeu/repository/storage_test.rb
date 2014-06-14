require_relative '../../../test_helper'

module Vedeu
  describe Storage do
    let(:described_class) { Storage }
    let(:subject)         { described_class.new }
    let(:record)          { DummyCommand.new }
    let(:klass)           {}

    it { subject.must_be_instance_of(Storage) }
    it { subject.instance_variable_get("@counter").must_equal(0) }
    it { subject.instance_variable_get("@map").must_equal({}) }

    describe '#create' do
      let(:subject) { described_class.new.create(record) }

      it { subject.must_be_instance_of(DummyCommand) }
    end

    describe '#delete' do
      let(:subject) { described_class.new.delete(record) }

      it { subject.must_be_instance_of(NilClass) }
    end

    describe '#reset' do
      let(:subject) { described_class.new.reset(klass) }

      it { subject.must_be_instance_of(Array) }
    end

    describe '#find' do
      let(:subject) { described_class.new.find(klass, id) }
      let(:id)      { 'dummy' }

      it { subject.must_be_instance_of(NilClass) }
    end

    describe '#all' do
      let(:subject) { described_class.new.all(klass) }

      it { subject.must_be_instance_of(Array) }
    end

    describe '#query' do
      let(:subject)   { described_class.new.query(klass, attribute, value) }
      let(:attribute) {}
      let(:value)     {}

      it { subject.must_be_instance_of(Hash) }
    end
  end
end
