require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/models/composition'

module Vedeu
  describe Composition do
    let(:described_class)    { Composition }
    let(:described_instance) { described_class.new(attributes) }
    let(:attributes)         { { interfaces: interfaces } }
    let(:interfaces)         { { name: 'dummy' } }

    describe '#initialize' do
      let(:subject) { described_instance }

      it 'returns a Composition instance' do
        subject.must_be_instance_of(Composition)
      end
    end

    describe '#enqueue' do
      let(:subject) { described_instance.enqueue }

      it 'creates a composition and enqueues the interface for rendering' do
        skip
      end
    end

    describe '#to_json' do
      let(:subject) { described_instance.to_json }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end
    end

    describe '#to_s' do
      let(:subject) { described_instance.to_s }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end
    end
  end
end
