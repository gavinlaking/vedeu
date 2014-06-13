require_relative '../../../test_helper'

module Vedeu
  describe Process do
    let(:described_class) { Process }
    let(:input)           { nil }
    let(:result)          {}
    let(:subject)         { described_class.new }

    it { subject.must_be_instance_of(Process) }

    describe '.evaluate' do
      let(:subject) { described_class.evaluate }
      let(:command) { Command.new }

      before do
        Queue.stubs(:dequeue).returns(input)
        CommandRepository.stubs(:by_keypress).returns(command)
        CommandRepository.stubs(:by_keyword).returns(command)
        command.stubs(:execute).returns(result)
      end

      after { Queue.clear }

      context 'when there is no input' do
        it { subject.must_be_instance_of(NilClass) }
      end

      context 'when the input is a keypress' do
        let(:input) { "q" }

        context 'but there is no result' do
          it { subject.must_be_instance_of(NilClass) }
        end

        context 'or the result is :stop' do
          let(:result) { :stop }

          it { proc { subject }.must_raise(Collapse) }
        end

        context 'or the result is anything else' do
          let(:result) { :something_else }

          it { subject.must_be_instance_of(Array) }
        end
      end

      context 'when the input is a keyword' do
        let(:input) { "quit" }

        context 'but there is no result' do
          it { subject.must_be_instance_of(NilClass) }
        end

        context 'or the result is :stop' do
          let(:result) { :stop }

          it { proc { subject }.must_raise(Collapse) }
        end

        context 'or the result is anything else' do
          let(:result) { :something_else }

          it { subject.must_be_instance_of(Array) }
        end
      end
    end
  end
end
