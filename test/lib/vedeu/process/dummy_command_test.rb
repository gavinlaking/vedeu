require_relative '../../../test_helper'

module Vedeu
  describe DummyCommand do
    let(:described_class) { DummyCommand }
    let(:subject) { described_class.new }

    it { subject.must_be_instance_of(DummyCommand) }

    describe '.dispatch' do
      let(:subject) { described_class.dispatch }

      it { subject.must_be_instance_of(String) }
    end
  end
end
