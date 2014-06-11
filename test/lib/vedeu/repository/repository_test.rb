require_relative '../../../test_helper'

module Vedeu
  class Dummy
    attr_accessor :id

    def name
      "dummy"
    end
  end

  class DummyRepository
    extend Repository

    def self.klass
      Dummy
    end
  end

  describe Repository do
    let(:described_class) { DummyRepository }

    before do
      @dummy = DummyRepository.create(Dummy.new)
    end

    after do
      DummyRepository.reset
    end

    describe '#adaptor' do
      let(:subject) { described_class.adaptor }

      it { subject.must_be_instance_of(Storage) }
    end

    describe '#adaptor=' do
      let(:subject) { described_class.adaptor=(adaptor) }
      let(:adaptor) { Storage.new }

      it { subject.must_be_instance_of(Storage) }
    end

    describe '#find' do
      let(:subject) { described_class.find(id) }
      let(:id)      { @dummy.id }

      it { subject.must_be_instance_of(Dummy) }
    end

    describe '#all' do
      let(:subject) { described_class.all }

      it { subject.must_be_instance_of(Array) }
    end

    describe '#query' do
      let(:subject)   { described_class.query(klass, attribute, value) }
      let(:klass)     { Dummy }
      let(:attribute) { :name }
      let(:value)     { "dummy" }

      it { subject.must_be_instance_of(Dummy) }
    end

    describe '#create' do
      let(:subject) { described_class.create(model) }
      let(:model)   { @dummy }

      it { subject.must_be_instance_of(Dummy) }
    end

    describe '#delete' do
      let(:subject) { described_class.delete(model) }
      let(:model)   { @dummy }

      it { subject.must_be_instance_of(Dummy) }
    end

    describe '#reset' do
      let(:subject) { described_class.reset }

      it { subject.must_be_instance_of(Array) }

      # it { subject.must_be_empty }
    end
  end
end
