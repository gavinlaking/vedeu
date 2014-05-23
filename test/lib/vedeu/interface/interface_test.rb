require_relative '../../../test_helper'

module Vedeu
  describe Interface do
    let(:described_class)    { Interface }
    let(:described_instance) { described_class.new(options) }
    let(:options)            { {} }

    it { described_instance.must_be_instance_of(Interface) }

    describe '#initial_state' do
      subject { described_instance.initial_state }

      it { proc { subject }.must_raise(NotImplementedError) }
    end

    describe '#event_loop' do
      subject { described_instance.event_loop }

      it { skip }
    end

    describe '#input' do
      subject { described_instance.input }

      it { skip }
    end

    describe '#output' do
      subject { described_instance.output }

      it { skip }
    end

    describe '#geometry' do
      subject { described_instance.geometry }

      it { subject.must_be_instance_of(Geometry) }
    end
  end
end
