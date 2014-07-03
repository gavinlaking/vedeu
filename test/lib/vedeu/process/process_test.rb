require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/process/process'
require_relative '../../../../lib/vedeu/repository/interface_repository'

module Vedeu
  describe Process do
    let(:described_class) { Process }
    let(:input)           { nil }
    let(:result)          {}

    describe '#initialize' do
      let(:subject) { described_class.new }

      it 'returns a Process instance' do
        subject.must_be_instance_of(Process)
      end
    end

    describe '.evaluate' do
      let(:subject) { described_class.evaluate }
      let(:command) { Command.new }
      let(:json)    { {} }

      before do
        InterfaceRepository.create({
          name: 'dummy',
          width: 15,
          height: 2
        })
        Queue.stubs(:dequeue).returns(input)
        CommandRepository.stubs(:by_input).returns(command)
        command.stubs(:execute).returns(result)
        JSONParser.stubs(:parse).returns(json)
        Composition.stubs(:enqueue).returns([])
      end

      after do
        InterfaceRepository.reset
        Queue.clear
      end

      context 'when there is no input' do
        it 'raises an exception' do
          proc { subject }.must_raise(StopIteration)
        end
      end

      context 'when there is input' do
        let(:input) { "q" }

        context 'and there is a result' do
          let(:result) { { 'dummy' => [['output...']] } }

          it 'returns an Array' do
            subject.must_be_instance_of(Array)
          end
        end

        context 'or there is no result or the result is :stop' do
          let(:result) { :stop }

          it 'raises an exception' do
            proc { subject }.must_raise(StopIteration)
          end
        end
      end
    end
  end
end
