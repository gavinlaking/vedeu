require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/process/process'
require_relative '../../../support/dummy_command'
require_relative '../../../../lib/vedeu/repositories/command'

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
      before do
        Repositories::Command.reset
        Queue.reset
      end

      it 'returns false when there is no input' do
        Process.evaluate.must_be_instance_of(FalseClass)
      end

      it 'raises an exception when the result is :stop' do
        Repositories::Command.create({
          name:     'quit',
          entity:   QuitCommand,
          keypress: 'q'
        })
        Queue.enqueue('q')
        proc { Process.evaluate }.must_raise(StopIteration)
      end

      it 'returns a collection of interfaces when there is a result' do
        Repositories::Command.create({
          name:     'test',
          entity:   TestCommand,
          keypress: 't'
        })
        Queue.enqueue('t')
        evaluation = Process.evaluate

        evaluation.must_be_instance_of(Array)
        evaluation.size.must_equal(1)
      end

      it 'returns a NilClass when there is no result' do
        Repositories::Command.create({
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
