require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/repositories/interface'

module Vedeu
  module Repositories
    describe Interface do
      before { Interface.reset }

      describe '.update' do
        it 'returns an Interface' do
          Interface.update('dummy', { name: 'dumber' })
            .must_be_instance_of(Vedeu::Interface)
        end

        it 'updates and returns the existing interface when the interface exists' do
          Interface.update('dummy', { name: 'dumber' }).name
            .must_equal('dumber')
        end

        it 'returns a new interface when the interface does not exist' do
          Interface.update('dummy', { name: 'dumber' }).name
            .must_equal('dumber')
        end
      end

      describe '.entity' do
        it 'returns Interface' do
          Interface.entity.must_equal(Vedeu::Interface)
        end
      end
    end
  end
end
