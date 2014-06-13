require_relative '../../../test_helper'

module Vedeu
  describe Command do
    let(:described_class)    { Command }
    let(:described_instance) { described_class.new(attributes) }
    let(:subject)            { described_instance }
    let(:attributes)         {
      {
        name:    'dummy',
        klass:   DummyCommand,
        options: {
          keyword:  "dummy",
          keypress: "d"
        }
      }
    }

    it { subject.must_be_instance_of(Command) }
    it { subject.instance_variable_get("@attributes").must_equal(attributes) }
    it { subject.instance_variable_get("@name").must_equal('dummy') }
    it { subject.instance_variable_get("@klass").must_equal(DummyCommand) }
    it { subject.instance_variable_get("@keyword").must_equal('dummy') }
    it { subject.instance_variable_get("@keypress").must_equal('d') }

    describe '#create' do
      let(:subject) { described_class.create(attributes) }

      it { subject.must_be_instance_of(Command) }
    end

    describe '#execute' do
      let(:subject) { described_instance.execute(args) }
      let(:args)    { [] }

      it { subject.must_be_instance_of(Symbol) }
      it { subject.must_equal(:dummy) }
    end

    describe '#executable' do
      let(:subject) { described_instance.executable }
    end
  end
end
