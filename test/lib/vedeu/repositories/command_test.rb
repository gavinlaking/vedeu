require_relative '../../../test_helper'
require_relative '../../../support/dummy_command'
require_relative '../../../../lib/vedeu/repositories/command'

module Vedeu
  module Repositories
    describe Command do
      before do
        Command.create({
          name:     'apple',
          entity:   DummyCommand,
          keypress: 'a',
          keyword:  'apple'
        })
        Command.create({
          name:     'banana',
          entity:   DummyCommand,
          keypress: 'b',
          keyword:  'banana'
        })
      end
      after { Command.reset }

      describe '.by_input' do
        it 'returns the correct command when the command was found by keypress' do
          command = Command.by_input('b')

          command.name.must_equal('banana')
          command.name.wont_equal('apple')
          command.keypress.must_equal('b')
        end

        it 'returns the correct command when the command was found by keyword' do
          command = Command.by_input('apple')

          command.keypress.must_equal('a')
          command.keypress.wont_equal('b')
          command.name.wont_equal('banana')
        end

        it 'returns false when no command was found' do
          Command.by_input('not_found').must_be_instance_of(FalseClass)
        end

        it 'returns false when there is no input' do
          Command.by_input('').must_be_instance_of(FalseClass)
        end
      end

      describe '.entity' do
        it 'returns Command' do
          Command.entity.must_equal(Vedeu::Command)
        end
      end
    end
  end
end
