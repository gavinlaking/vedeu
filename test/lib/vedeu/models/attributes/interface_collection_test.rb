require 'test_helper'
require 'vedeu/models/composition'
require 'vedeu/models/attributes/interface_collection'

module Vedeu
  describe InterfaceCollection do
    describe '#coerce' do
      before { Persistence.reset }

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
