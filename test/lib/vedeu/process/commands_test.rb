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

      it { skip }
    end

    describe '.execute' do
      let(:subject) { described_class.execute }

      it { skip }
    end

    describe '.list' do
      let(:subject) { described_class.list }

      it { subject.must_be_instance_of(String) }
    end

    describe '.add' do
      let(:subject) { described_class.add(command_name, command_klass, args, options) }
      let(:command_name)  { "some_name" }
      let(:command_klass) { DummyCommand }
      let(:args)          { [] }
      let(:options)       { {} }

      it { subject.must_be_instance_of(Hash) }
    end
  end
end
