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
        keyword:  "dummy",
        keypress: "d"
      }
    }

    it 'returns a Command instance' do
      subject.must_be_instance_of(Command)
    end

    it 'has a name attribute' do
      subject.name.must_be_instance_of(String)

      subject.name.must_equal('dummy')
    end

    it 'has an entity attribute' do
      subject.entity.must_be_instance_of(Class)

      subject.entity.must_equal(DummyCommand)
    end

    it 'has a keypress attribute' do
      subject.keypress.must_be_instance_of(String)

      subject.keypress.must_equal('d')
    end

    it 'has an keyword attribute' do
      subject.keyword.must_be_instance_of(String)

      subject.keyword.must_equal('dummy')
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
