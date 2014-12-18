require 'test_helper'

module Vedeu
  describe Composition do

    let(:described) { Vedeu::DSL::Composition.new(model) }
    let(:model)     { Vedeu::Composition.new }

    describe '#initialize' do
      it { return_type_for(described, Vedeu::DSL::Composition) }
      it { assigns(described, '@model', model) }
    end

  end # Composition

end # Vedeu
