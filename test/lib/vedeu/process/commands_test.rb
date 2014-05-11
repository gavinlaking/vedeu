require_relative '../../../test_helper'

module Vedeu
  module Process
    class DummyCommand
      def self.dispatch; end
    end

    describe Commands do
      let(:klass)    { Commands }
      let(:instance) { klass.instance }
      let(:block)    {}

      subject { instance }

      it { subject.must_be_instance_of(Vedeu::Process::Commands) }

      describe '#add' do
        let(:interface_name)  { "dummy" }
        let(:interface_klass) { DummyCommand }

        subject { instance.add(interface_name, interface_klass) }

        it { subject.must_be_instance_of(Hash) }

        it { subject.wont_be_empty }

        context 'when the interface class does not exist' do
          before { Object.stubs(:const_defined?).returns(false) }

          it { proc { subject }.must_raise(InvalidCommand) }
        end
      end

      describe '#show' do
        subject { instance.show }

        it { subject.must_be_instance_of(Hash) }
      end
    end
  end
end
