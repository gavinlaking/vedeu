require_relative '../../../test_helper'
require_relative '../../../support/dummy_command'
require_relative '../../../../lib/vedeu/models/command'

module Vedeu
  describe Command do
    let(:attributes) {
      {
        name:      'dummy',
        entity:    DummyCommand,
        keyword:   'dummy',
        keypress:  'd',
        arguments: []
      }
    }

    describe '#initialize' do
      def subject
        Command.new(attributes)
      end

      it 'returns a Command instance' do
        subject.must_be_instance_of(Command)
      end
    end

    describe '#name' do
      def subject
        Command.new(attributes).name
      end

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'has a name attribute' do
        subject.must_equal('dummy')
      end
    end

    describe '#entity' do
      def subject
        Command.new(attributes).entity
      end

      it 'returns a Class' do
        subject.must_be_instance_of(Class)
      end

      it 'has an entity attribute' do
        subject.must_equal(DummyCommand)
      end
    end

    describe '#keypress' do
      def subject
        Command.new(attributes).keypress
      end

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'has a keypress attribute' do
        subject.must_equal('d')
      end
    end

    describe '#keyword' do
      def subject
        Command.new(attributes).keyword
      end

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'has an keyword attribute' do
        subject.must_equal('dummy')
      end
    end

    describe '#arguments' do
      def subject
        Command.new(attributes).arguments
      end

      it 'returns a String' do
        subject.must_be_instance_of(Array)
      end

      it 'has an arguments attribute' do
        subject.must_equal([])
      end
    end

    describe '#execute' do
      def subject
        Command.new(attributes).execute(:dummy)
      end

      it 'returns a Symbol' do
        subject.must_be_instance_of(Symbol)
      end

      it 'returns the result of execution' do
        subject.must_equal(:dummy)
      end
    end

    describe '#executable' do
      def subject
        Command.new(attributes).executable
      end

      it 'returns a proc' do
        subject.class.to_s.must_equal('Proc')
      end
    end
  end
end
