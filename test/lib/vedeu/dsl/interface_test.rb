require 'test_helper'

module Vedeu

  module DSL

    describe Interface do

      let(:described) { Vedeu::DSL::Interface.new(model) }
      let(:model)     { Vedeu::Interface.new }

      describe '#initialize' do
        it { return_type_for(described, Vedeu::DSL::Interface) }
        it { assigns(described, '@model', model) }
      end

    end # Interface

  end # DSL

end # Vedeu
