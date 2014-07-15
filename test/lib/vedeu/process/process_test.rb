require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/process/process'
require_relative '../../../support/dummy_command'
require_relative '../../../../lib/vedeu/repository/command_repository'

module Vedeu
  class QuitCommand
    def self.dispatch(*args)
      :stop
    end
  end

  class TestCommand
    def self.dispatch(*args)
      :test
    end
  end

  class NoResultCommand
    def self.dispatch(*args)
    end
  end

  describe Process do
    describe '.evaluate' do
      def subject
        Process.evaluate
      end

      before do
        CommandRepository.create({
          name:     'quit',
          entity:   QuitCommand,
          keypress: 'q'
        })
        CommandRepository.create({
          name:     'test',
          entity:   TestCommand,
          keypress: 't'
        })
        CommandRepository.create({
          name:     'no_result',
          entity:   NoResultCommand,
          keypress: 'n'
        })
        Queue.stubs(:dequeue).returns(input)
        Parser.stubs(:parse).returns(Composition.new)
      end

      after do
        CommandRepository.reset
      end

      context 'when there is no input' do
        let(:input) { '' }

        it 'returns a FalseClass' do
          subject.must_be_instance_of(FalseClass)
        end
      end

      context 'when there is input' do
        context 'and the result is :stop' do
          let(:input) { 'q' }

          it 'raises an exception' do
            proc { subject }.must_raise(StopIteration)
          end
        end

        context 'and there is a result' do
          let(:input) { 't' }

          it 'returns an Composition' do
            subject.must_be_instance_of(Composition)
          end
        end

        context 'but there is no result' do
          let(:input) { 'n' }

          it 'returns a NilClass' do
            subject.must_be_instance_of(NilClass)
          end
        end
      end
    end
  end
end
