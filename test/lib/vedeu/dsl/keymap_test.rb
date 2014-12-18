require 'test_helper'

module Vedeu

  module DSL

    describe Keymap do

      let(:described) { Vedeu::DSL::Keymap.new(model) }
      let(:model)     { Vedeu::Keymap.new }

      describe '#initialize' do
        it { return_type_for(described, Vedeu::DSL::Keymap) }
        it { assigns(described, '@model', model) }
      end

    end # Keymap

  end # DSL

end # Vedeu
