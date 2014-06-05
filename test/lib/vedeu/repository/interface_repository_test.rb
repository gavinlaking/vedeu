require_relative '../../../test_helper'

module Vedeu
  describe InterfaceRepository do
    let(:described_class) { InterfaceRepository }

    describe '.initial_state' do
      let(:subject) { described_class.initial_state }

      it { skip }
    end

    describe '.input' do
      let(:subject) { described_class.input }

      it { skip }
    end

    describe '.output' do
      let(:subject) { described_class.output }

      it { skip }
    end

    describe '.klass' do
      let(:subject) { described_class.klass }

      it { subject.must_equal(Interface) }
    end
  end
end
