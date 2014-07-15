require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/process/process'
require_relative '../../../support/dummy_command'
require_relative '../../../../lib/vedeu/repository/command_repository'

module Vedeu
  class QuitCommand
    def self.dispatch
      :stop
    end
  end

  class TestCommand
    def self.dispatch
      {
        'dummy' => 'Some text...'
      }
    end
  end

  class NoResultCommand
    def self.dispatch
    end
  end

  describe Process do
    describe '.evaluate' do
      it 'returns false when there is no input' do
        Queue.clear
        Process.evaluate.must_be_instance_of(FalseClass)
      end

      it 'raises an exception when the result is :stop' do
        CommandRepository.reset
        CommandRepository.create({
          name:     'quit',
          entity:   QuitCommand,
          keypress: 'q'
        })
        Queue.enqueue('q')
        proc { Process.evaluate }.must_raise(StopIteration)
      end

      it 'returns an Composition when there is a result' do
        CommandRepository.reset
        CommandRepository.create({
          name:     'test',
          entity:   TestCommand,
          keypress: 't'
        })
        Queue.enqueue('t')
        Process.evaluate.must_be_instance_of(Composition)
      end

      it 'returns a NilClass when there is no result' do
        CommandRepository.reset
        CommandRepository.create({
          name:     'no_result',
          entity:   NoResultCommand,
          keypress: 'n'
        })
        Queue.enqueue('n')
        Process.evaluate.must_be_instance_of(NilClass)
      end
    end
  end
end
