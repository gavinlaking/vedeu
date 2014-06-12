require_relative '../../../test_helper'

module Vedeu
  describe Storage do
    let(:described_class) { Storage }
    let(:subject)         { described_class.new }
    let(:record)          {}
    let(:klass)           {}

    it { subject.must_be_instance_of(Storage) }

    describe '#create' do
      let(:subject) { described_class.new.create(record) }
    end

    describe '#delete' do
      let(:subject) { described_class.new.delete(record) }
    end

    describe '#reset' do
      let(:subject) { described_class.new.reset(klass) }
    end

    describe '#find' do
      let(:subject) { described_class.new.find(klass, id) }
    end

    describe '#all' do
      let(:subject) { described_class.new.all(klass) }
    end

    describe '#query' do
      let(:subject)   { described_class.new.query(klass, attribute, value) }
      let(:attribute) {}
      let(:value)     {}
    end
  end
end
