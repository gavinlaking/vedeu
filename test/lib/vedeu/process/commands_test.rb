require_relative '../../../test_helper'

module Vedeu
  class DummyCommandKlass
    def self.dispatch; end
  end

  describe Commands do
    let(:described_class)    { Commands }
    let(:instance) { described_class.instance }
    let(:block)    {}

    it { instance.must_be_instance_of(Vedeu::Commands) }

    describe '.execute' do
      subject { described_class.execute }

      it { skip }
    end

    describe '.list' do
      subject { described_class.list }

      it { subject.must_be_instance_of(String) }
    end

    describe '#define' do
      let(:command_name)  { "some_name" }
      let(:command_klass) { DummyCommandKlass }
      let(:args)          { [] }
      let(:options)       { {} }

      subject { instance.define(command_name, command_klass, args, options) }

      it { subject.must_be_instance_of(Hash) }
    end

    describe '#execute' do
      subject { instance.execute }

      it { skip }
    end

    describe '#list' do
      subject { instance.list }

      it { subject.must_be_instance_of(String) }
    end
  end

  describe Exit do
    let(:described_class)    { Exit }

    describe '.dispatch' do
      subject { described_class.dispatch }

      it { subject.must_be_instance_of(Symbol) }

      it { subject.must_equal(:stop) }
    end
  end
end
