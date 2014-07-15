require_relative '../../../test_helper'
require_relative '../../../support/dummy_command'
require_relative '../../../../lib/vedeu/repository/command_repository'

module Vedeu
  describe CommandRepository do
    let(:input) {}

    before do
      CommandRepository.create({
        name:     'apple',
        entity:   DummyCommand,
        keypress: 'a',
        keyword:  'apple'
      })
      CommandRepository.create({
        name:     'banana',
        entity:   DummyCommand,
        keypress: 'b',
        keyword:  'banana'
      })
    end
    after { CommandRepository.reset }

    describe '.by_input' do
      def subject
        CommandRepository.by_input(input)
      end
      let(:input)   { 'b' }

      it 'returns the Command instance' do
        subject.must_be_instance_of(Command)
      end

      context 'when the command was found by keypress' do
        it 'returns the correct command' do
          subject.name.must_equal('banana')
        end

        it 'returns the correct command' do
          subject.name.wont_equal('apple')
        end

        it 'returns the correct command' do
          subject.keypress.must_equal('b')
        end
      end

      context 'when the command was found by keyword' do
        let(:input) { 'apple' }

        it 'returns the correct command' do
          subject.keypress.must_equal('a')
        end

        it 'returns the correct command' do
          subject.keypress.wont_equal('b')
        end

        it 'returns the correct command' do
          subject.name.wont_equal('banana')
        end
      end

      context 'when no command was found' do
        let(:input) { 'not_found' }

        it 'returns FalseClass' do
          subject.must_be_instance_of(FalseClass)
        end
      end

      context 'when there is no input' do
        let(:input) {}

        it 'returns FalseClass' do
          subject.must_be_instance_of(FalseClass)
        end
      end
    end

    describe '.create' do
      def subject
        CommandRepository.create(attributes)
      end
      let(:attributes) { {} }

      it 'returns a Command' do
        subject.must_be_instance_of(Command)
      end
    end

    describe '.entity' do
      def subject
        CommandRepository.entity
      end

      it 'returns a Class instance' do
        subject.must_be_instance_of(Class)
      end

      it 'returns Command' do
        subject.must_equal(Command)
      end
    end
  end
end
