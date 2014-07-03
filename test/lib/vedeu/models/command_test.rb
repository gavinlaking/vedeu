require_relative '../../../test_helper'
require_relative '../../../support/dummy_command'
require_relative '../../../../lib/vedeu/models/command'

module Vedeu
  describe Command do
    let(:described_class)    { Command }
    let(:described_instance) { described_class.new(attributes) }
    let(:subject)            { described_instance }
    let(:attributes)         {
      {
        name:      'dummy',
        entity:    DummyCommand,
        keyword:   "dummy",
        keypress:  "d",
        arguments: []
      }
    }

    describe '#initialize' do
      let(:subject) { described_instance }

      it 'returns a Command instance' do
        subject.must_be_instance_of(Command)
      end
    end

    describe '#name' do
      let(:subject) { described_instance.name }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'has a name attribute' do
        subject.must_equal('dummy')
      end
    end

    describe '#entity' do
      let(:subject) { described_instance.entity }

      it 'returns a Class' do
        subject.must_be_instance_of(Class)
      end

      it 'has an entity attribute' do
        subject.must_equal(DummyCommand)
      end
    end

    describe '#keypress' do
      let(:subject) { described_instance.keypress }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'has a keypress attribute' do
        subject.must_equal('d')
      end
    end

    describe '#keyword' do
      let(:subject) { described_instance.keyword }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'has an keyword attribute' do
        subject.must_equal('dummy')
      end
    end

    describe '#arguments' do
      let(:subject) { described_instance.arguments }

      it 'returns a String' do
        subject.must_be_instance_of(Array)
      end

      it 'has an arguments attribute' do
        subject.must_equal([])
      end
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

      it 'returns a proc' do
        subject.class.to_s.must_equal('Proc')
      end
    end
  end
end
