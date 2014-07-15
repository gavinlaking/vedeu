require_relative '../../../test_helper'
require_relative '../../../support/dummy_command'
require_relative '../../../../lib/vedeu/repository/command_repository'

module Vedeu
  describe CommandRepository do
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
      it 'returns the correct command when the command was found by keypress' do
        CommandRepository.by_input('b').name.must_equal('banana')
        CommandRepository.by_input('b').name.wont_equal('apple')
        CommandRepository.by_input('b').keypress.must_equal('b')
      end

      it 'returns the correct command when the command was found by keyword' do
        CommandRepository.by_input('apple').keypress.must_equal('a')
        CommandRepository.by_input('apple').keypress.wont_equal('b')
        CommandRepository.by_input('apple').name.wont_equal('banana')
      end

      it 'returns FalseClass when no command was found' do
        CommandRepository.by_input('not_found').must_be_instance_of(FalseClass)
      end

      it 'returns FalseClass when there is no input' do
        CommandRepository.by_input('').must_be_instance_of(FalseClass)
      end
    end

    describe '.create' do
      it 'returns a Command' do
        skip
        CommandRepository.create({}).must_be_instance_of(Command)
      end
    end

    describe '.entity' do
      it 'returns Command' do
        CommandRepository.entity.must_equal(Command)
      end
    end
  end
end
