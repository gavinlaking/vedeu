require_relative '../../../test_helper'

module Vedeu
  describe Command do
    let(:described_class)    { Command }
    let(:described_instance) { described_class.new(attributes) }
    let(:subject)            { described_instance }
    let(:attributes)         {
      {
        name:    'dummy',
        entity:   DummyCommand,
        options: {
          keyword:  "dummy",
          keypress: "d"
        }
      }
    }

    it 'returns a Command instance' do
      subject.must_be_instance_of(Command)
    end

    it 'sets an instance variable' do
      subject.instance_variable_get('@attributes').must_equal(attributes)
    end

    it 'sets an instance variable' do
      subject.instance_variable_get('@name').must_equal('dummy')
    end

    it 'sets an instance variable' do
      subject.instance_variable_get('@entity').must_equal(DummyCommand)
    end

    it 'sets an instance variable' do
      subject.instance_variable_get('@keyword').must_equal('dummy')
    end

    it 'sets an instance variable' do
      subject.instance_variable_get('@keypress').must_equal('d')
    end

    describe '#execute' do
      let(:subject) { described_instance.execute(args) }
      let(:args)    { [] }

      it 'returns a Symbol' do
        subject.must_be_instance_of(Symbol)
      end

      it 'returns the result of execution' do
        subject.must_equal(:dummy)
      end
    end

    describe '#executable' do
      let(:subject) { described_instance.executable }
    end
  end
end
