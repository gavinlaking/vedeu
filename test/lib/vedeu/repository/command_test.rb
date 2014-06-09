require_relative '../../../test_helper'

module Vedeu
  class DummyCommand
    def self.dispatch; end
  end

  describe Command do
    let(:described_class)    { Command }
    let(:described_instance) { described_class.new(attributes) }
    let(:attributes)         { { name: :test_command } }

    it { described_instance.must_be_instance_of(Command) }

    describe '#create' do
      let(:subject) { described_class.create(attributes) }

      it { subject.must_be_instance_of(Command) }
    end

    describe '#execute' do
      let(:subject) { described_class.execute(args) }

      it { skip }
    end

    describe '#name' do
      let(:subject) { described_instance.name }

      context 'when the name is undefined' do
        let(:attributes) { {} }

        it { subject.must_be_instance_of(NilClass) }
      end

      context 'when the name is defined' do
        it { subject.must_be_instance_of(Symbol) }

        it { subject.must_equal(:test_command) }
      end
    end

    describe '#executable' do
      let(:subject) { described_instance.executable }

      it { skip }
    end

    describe '#options' do
      let(:subject) { described_instance.options }

      it { subject.must_be_instance_of(Hash) }
    end

    describe '#execute' do
      let(:subject) { described_instance.execute }

      it { skip }
    end
  end
end
