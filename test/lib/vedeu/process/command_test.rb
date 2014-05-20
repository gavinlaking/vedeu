require_relative '../../../test_helper'

module Vedeu
  class DummyCommand
    class << self
      def dispatch; end
    end
  end

  describe Command do
    let(:described_class)       { Command }
    let(:instance)    { described_class.new(cmd_name, cmd_klass, cmd_args, cmd_options) }
    let(:cmd_name)    { "dummy" }
    let(:cmd_klass)   { DummyCommand }
    let(:cmd_args)    { [] }
    let(:cmd_options) { {} }

    it { instance.must_be_instance_of(Command) }

    describe '#define' do
      subject do
        described_class.define(cmd_name, cmd_klass, cmd_args, cmd_options)
      end

      it { subject.must_be_instance_of(Hash) }

      it { subject.wont_be_empty }

      context "when the command name is empty" do
        let(:cmd_name) { "" }

        it { proc { subject }.must_raise(InvalidCommand) }
      end

      context "when the command class is empty" do
        let(:cmd_klass) { "" }

        it { proc { subject }.must_raise(InvalidCommand) }
      end

      context "when the command class is not defined" do
        before { Object.stubs(:const_defined?).returns(false) }

        it { proc { subject }.must_raise(InvalidCommand) }
      end

      context "when the command class doesn't have a .dispatch method" do
        before { cmd_klass.stubs(:singleton_methods).returns([]) }

        it { proc { subject }.must_raise(InvalidCommand) }
      end
    end
  end
end
