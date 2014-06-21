require_relative '../../../../test_helper'

module Vedeu
  module Buffer
    describe Composition do
      let(:described_class)    { Composition }
      let(:described_instance) { described_class.new(attributes) }
      let(:subject)            { described_instance }
      let(:attributes)         { { interface: [] } }

      it 'returns a Composition instance' do
        subject.must_be_instance_of(Composition)
      end

      it 'has an interface attribute' do
        subject.interface.must_be_instance_of(Array)
      end
    end
  end
end
