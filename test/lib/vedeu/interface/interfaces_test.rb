require_relative '../../../test_helper'

module Vedeu
  class DummyInterface < Interface
    def initial_state; end

    def event_loop; end
  end

  describe Interfaces do
    let(:described_class) { Interfaces }

    describe '.define' do
      let(:subject) { described_class.define }

      it { subject.must_be_instance_of(Module) }

      context 'when a block is given' do
        let(:subject) { described_class.define { :some_block } }

        it { subject.must_be_instance_of(Symbol) }
      end
    end

    describe '.defined' do
      let(:subject) { described_class.defined }

      after { described_class.interfaces = {} }

      context 'when interfaces are not defined' do
        before { described_class.interfaces = {} }

        it 'adds the default interface and returns all interfaces' do
          subject.must_be_instance_of(Module)
        end
      end

      context 'when interfaces are defined' do
        before { described_class.interfaces = { mock: :interface } }

        it { subject.must_be_instance_of(Module) }
      end
    end

    describe '.list' do
      let(:subject) { described_class.list }

      it { subject.must_be_instance_of(String) }
    end

    describe '.add' do
      let(:subject)   { described_class.add(interface, options, klass) }
      let(:interface) {}
      let(:klass)     { DummyInterface }
      let(:options)   { {} }

      it { subject.must_be_instance_of(Module) }

      context 'when the interface class does not exist' do
        before { Object.stubs(:const_defined?).returns(false) }

        it { proc { subject }.must_raise(UndefinedInterface) }
      end
    end

    describe '.reset' do
      let(:subject) { described_class.reset }
      let(:interface) { :dummy }

      before { described_class.add(:dummy) }

      it { subject.must_be_instance_of(Hash) }

      it { subject.must_be_empty }
    end

    describe '.find' do
      let(:subject)   { described_class.find(interface) }
      let(:interface) { :dummy }

      context 'when the interface exists' do
        before { described_class.add(:dummy) }

        it { subject.must_be_instance_of(Dummy) }
      end

      context 'when the interface does not exist' do
        before { described_class.reset }

        it { subject.must_be_instance_of(NilClass) }
      end
    end

    describe '.initial_state' do
      let(:subject) { described_class.initial_state }

      it { subject.must_be_instance_of(Array) }
    end

    describe '.input' do
      let(:subject) { described_class.input }

      before { Terminal.stubs(:input).returns("some input") }

      it { subject.must_be_instance_of(Array) }
    end

    describe '.output' do
      let(:subject) { described_class.output(stream) }
      let(:stream) { "some output..." }

      it { subject.must_be_instance_of(Array) }
    end
  end
end
