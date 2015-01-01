require 'test_helper'

module Vedeu

  describe Interfaces do

    describe '#reset' do
      before { Interfaces.reset }

      it 'removes all known interfaces from the storage' do
        Interface.new({ name: 'bromine' }).store

        Interfaces.registered.must_equal(['bromine'])

        Interfaces.reset.must_be_empty
      end
    end

  end # Interfaces

end # Vedeu
