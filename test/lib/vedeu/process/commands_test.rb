require_relative '../../../test_helper'

module Vedeu
  class DummyCommandKlass
    def self.dispatch; end
  end

  describe Commands do
    let(:klass)    { Commands }
    let(:instance) { klass.instance }
    let(:block)    {}

    it { instance.must_be_instance_of(Vedeu::Commands) }

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
end
