require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/models/interface_collection'
require_relative '../../../../lib/vedeu/models/composition'

module Vedeu
  describe InterfaceCollection do
    let(:described_class) { InterfaceCollection }

    describe '#coerce' do
      let(:subject)    { Vedeu::Composition.new({ interfaces: interfaces }).interfaces }
      let(:interfaces) {}

      context 'when there are no interfaces' do
        it 'returns a Array' do
          subject.must_be_instance_of(Array)
        end

        it 'returns an empty array' do
          subject.must_equal([])
        end
      end

      context 'when there is a single interface' do
        let(:interfaces) { { name: 'dummy' } }

        it 'returns an Interface' do
          subject.must_be_instance_of(Interface)
        end
      end

      context 'when there are multiple interfaces' do
        let(:interfaces) {
          [
            { name: 'dumb' },
            { name: 'dumber' }
          ]
        }

        it 'returns an Array' do
          subject.must_be_instance_of(Array)
        end

        it 'returns a collection of Interface objects' do
          subject.first.must_be_instance_of(Interface)
        end
      end
    end
  end
end
