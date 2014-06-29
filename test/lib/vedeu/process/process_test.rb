require_relative '../../../test_helper'

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

      before do
        InterfaceRepository.create({ name: 'dummy', width: 15, height: 2 })
        Queue.stubs(:dequeue).returns(input)
        CommandRepository.stubs(:by_keypress).returns(command)
        CommandRepository.stubs(:by_keyword).returns(command)
        command.stubs(:execute).returns(result)
        Compositor.stubs(:arrange).returns([])
      end

      after do
        InterfaceRepository.reset
        Queue.clear
      end

      context 'when there is no input' do
        it 'returns a NilClass' do
          subject.must_be_instance_of(NilClass)
        end
      end

      context 'when the input is a keypress' do
        let(:input) { "q" }

        context 'but there is no result' do
          it 'returns a NilClass' do
            subject.must_be_instance_of(NilClass)
          end
        end

        context 'or the result is :stop' do
          let(:result) { :stop }

          it 'raises an exception' do
            proc { subject }.must_raise(StopIteration)
          end
        end

        context 'or the result is anything else' do
          let(:result) { { 'dummy' => [['output...']] } }

          it 'returns an Array' do
            subject.must_be_instance_of(Array)
          end
        end
      end

      context 'when the input is a keyword' do
        let(:input) { "quit" }

        context 'but there is no result' do
          it 'returns a NilClass' do
            subject.must_be_instance_of(NilClass)
          end
        end

        context 'or the result is :stop' do
          let(:result) { :stop }

          it 'raises an exception' do
            proc { subject }.must_raise(StopIteration)
          end
        end

        context 'or the result is anything else' do
          let(:result) { { 'dummy' => [['output...']] } }

          it 'returns an Array' do
            subject.must_be_instance_of(Array)
          end
        end
      end
    end
  end
end
