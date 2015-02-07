require 'test_helper'

module Vedeu

  module DSL

    describe Use do

      describe '.use' do
        context 'when an interface has not been defined' do
          it { proc { Vedeu.use('unknown') }.must_raise(ModelNotFound) }
        end

        it 'returns an instance of the named interface' do
          Vedeu.interface('aluminium') do
            # ...
          end

          Vedeu.use('aluminium').must_be_instance_of(Vedeu::Interface)
        end
      end

    end # Use

  end # DSL

end # Vedeu
