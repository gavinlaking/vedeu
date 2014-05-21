require_relative '../../../test_helper'

module Vedeu
  describe Dummy do
    let(:described_class) { Dummy }
    let(:instance)        { described_class.new }

    describe '#initial_state' do
      subject { instance.initial_state }

      it { subject.must_be_instance_of(NilClass) }
    end

    describe '#input' do
      subject { instance.input }
    end

    describe '#output' do
      subject { instance.output }
    end
  end
end
