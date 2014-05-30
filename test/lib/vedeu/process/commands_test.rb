require_relative '../../../test_helper'

module Vedeu
  class DummyCommand
    def self.dispatch
      :noop
    end
  end

  describe Commands do
    let(:described_class) { Commands }

    describe '.define' do
      let(:subject) { described_class.define }

      context 'when a block is given' do
        let(:subject) { described_class.define { :nil } }

        it 'yields the block' do
          subject.must_be_instance_of(Symbol)
        end
      end

      context 'when a block is not given' do
        it { subject.must_be_instance_of(Module) }
      end
    end

    describe '.execute' do
      let(:subject) { described_class.execute(command) }
      let(:command) {}

      context 'when the command does not exist' do
        it { subject.must_be_instance_of(NilClass) }
      end

      context 'when the command exists' do
        let(:command) { :exit }

        before { Exit.stubs(:dispatch).returns(true) }

        it { subject.must_be_instance_of(TrueClass) }
      end
    end

    describe '.list' do
      let(:subject) { described_class.list }

      it { subject.must_be_instance_of(String) }
    end

    describe '.add' do
      let(:subject) { described_class.add(command_name, command_klass, args, options) }
      let(:command_name)  { :some_name }
      let(:command_klass) { DummyCommand }
      let(:args)          { [] }
      let(:options)       { {} }

      it { subject.must_be_instance_of(Hash) }
    end
  end
end
