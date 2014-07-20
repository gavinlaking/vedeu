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
        'Process#evaluate' => 'TestCommand.dispatch'
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
        Queue.reset
        Process.evaluate.must_be_instance_of(FalseClass)
      end

      it 'raises an exception when the result is :stop' do
        CommandRepository.reset
        CommandRepository.create({
          name:     'quit',
          entity:   QuitCommand,
          keypress: 'q'
        })
        Queue.reset
        Queue.enqueue('q')
        proc { Process.evaluate }.must_raise(StopIteration)
      end

      it 'returns a collection of interfaces when there is a result' do
        CommandRepository.reset
        CommandRepository.create({
          name:     'test',
          entity:   TestCommand,
          keypress: 't'
        })
        Queue.reset
        Queue.enqueue('t')
        evaluation = Process.evaluate

        evaluation.must_be_instance_of(Array)
        evaluation.size.must_equal(1)
      end

      it 'returns a NilClass when there is no result' do
        CommandRepository.reset
        CommandRepository.create({
          name:     'no_result',
          entity:   NoResultCommand,
          keypress: 'n'
        })
        Queue.reset
        Queue.enqueue('n')
        Process.evaluate.must_be_instance_of(NilClass)
      end
    end
  end
end
