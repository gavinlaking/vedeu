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

      it 'returns a Storage' do
        subject.must_be_instance_of(Storage)
      end
    end

    describe '#adaptor=' do
      let(:subject) { described_class.adaptor=(adaptor) }
      let(:adaptor) { Storage.new }

      it 'returns a Storage' do
        subject.must_be_instance_of(Storage)
      end
    end

    describe '#find' do
      let(:subject) { described_class.find(id) }
      let(:id)      { @dummy.id }

      it 'returns a Dummy' do
        subject.must_be_instance_of(Dummy)
      end
    end

    describe '#all' do
      let(:subject) { described_class.all }

      it 'returns all the stored items' do
        subject.must_be_instance_of(Array)
      end
    end

    describe '#query' do
      let(:subject)   { described_class.query(klass, attribute, value) }
      let(:klass)     { Dummy }
      let(:attribute) { :name }
      let(:value)     { "dummy" }

      it 'returns a Dummy' do
        subject.must_be_instance_of(Dummy)
      end
    end

    describe '#create' do
      let(:subject) { described_class.create(model) }
      let(:model)   { @dummy }

      it 'returns a Dummy' do
        subject.must_be_instance_of(Dummy)
      end
    end

    describe '#delete' do
      let(:subject) { described_class.delete(model) }
      let(:model)   { @dummy }

      it 'returns a Dummy' do
        subject.must_be_instance_of(Dummy)
      end
    end

    describe '#reset' do
      let(:subject) { described_class.reset }

      it 'returns an Array' do
        subject.must_be_instance_of(Array)
      end
    end
  end
end
