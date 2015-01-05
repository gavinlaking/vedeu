require 'test_helper'

module Vedeu

  module DSL

    describe Shared do

      describe '.use' do
        context 'when an interface has not been defined' do
          it { proc { Vedeu.use('unknown') }.must_raise(ModelNotFound) }
        end

        it 'returns an instance of the named interface' do
          Vedeu.interface('aluminium')

          Vedeu.use('aluminium').must_be_instance_of(Vedeu::Interface)
        end
      end

    end # Shared

  end # DSL

end # Vedeu
