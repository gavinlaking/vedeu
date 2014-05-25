require_relative '../../../test_helper'

module Vedeu
  describe Dummy do
    let(:described_class)    { Dummy }
    let(:described_instance) { described_class.new }

    describe '#initial_state' do
      let(:subject) { described_instance.initial_state }

      it { subject.must_be_instance_of(NilClass) }
    end

    describe '#input' do
      let(:subject) { described_instance.input }
    end

    describe '#output' do
      let(:subject) { described_instance.output }
    end
  end
end
