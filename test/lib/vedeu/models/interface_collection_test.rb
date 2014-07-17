require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/models/interface_collection'
require_relative '../../../../lib/vedeu/models/composition'

module Vedeu
  describe InterfaceCollection do
    describe '#coerce' do
      it 'returns a Array' do
        Composition.new.interfaces.must_be_instance_of(Array)
      end

      it 'returns an empty collection when there are no interfaces' do
        Composition.new.interfaces.must_equal([])
      end

      it 'returns a collection when there is a single interface' do
        skip
        Composition.new({ name: 'dummy' }).interfaces.first
          .must_be_instance_of(Interface)
      end

      it 'returns a collection when there are multiple interfaces' do
        Composition.new({ interfaces: [
          { name: 'dumb' },
          { name: 'dumber' }
        ]}).interfaces.size.must_equal(2)
      end
    end
  end
end
