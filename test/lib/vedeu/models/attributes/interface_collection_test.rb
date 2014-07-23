require_relative '../../../../test_helper'
require_relative '../../../../../lib/vedeu/models/attributes/interface_collection'
require_relative '../../../../../lib/vedeu/models/composition'

module Vedeu
  describe InterfaceCollection do
    describe '#coerce' do
      before { Repositories::InterfaceRepository.reset }

      it 'returns an empty collection when there are no interfaces' do
        composition = Composition.new
        composition.interfaces.must_equal([])
      end

      it 'returns a collection when there is a single interface' do
        composition = Composition.new({ interfaces: { name: 'InterfaceCollection#coerce' } })
        composition.interfaces.first.must_be_instance_of(Interface)
      end

      it 'returns a collection when there are multiple interfaces' do
        composition = Composition.new({ interfaces: [
          { name: 'dumb' },
          { name: 'dumber' }
        ]})
        composition.interfaces.size.must_equal(2)
      end
    end
  end
end
