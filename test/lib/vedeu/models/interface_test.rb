require_relative '../../../test_helper'

module Vedeu
  module Buffer
    describe Interface do
      let(:described_class)    { Interface }
      let(:described_instance) { described_class.new(attributes) }
      let(:attributes)         { { name: 'dummy', line: [] } }

      describe '#initialize' do
        let(:subject) { described_instance }

        it 'returns a Interface instance' do
          subject.must_be_instance_of(Interface)
        end
      end

      describe '#name' do
        let(:subject) { described_instance.name }

        it 'has a name attribute' do
          subject.must_be_instance_of(String)

          subject.must_equal('dummy')
        end
      end

      describe '#line' do
        let(:subject) { described_instance.line }

        it 'has a line attribute' do
          subject.must_be_instance_of(Array)

          subject.must_equal([])
        end
      end

      describe '#to_compositor' do
        let(:subject) { described_instance.to_compositor }

        it 'returns an Array' do
          subject.must_be_instance_of(Array)

          subject.must_equal([])
        end
      end
    end
  end
end
