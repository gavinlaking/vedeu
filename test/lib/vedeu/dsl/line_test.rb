require 'test_helper'

module Vedeu

  module DSL

    describe Line do

      let(:described) { Vedeu::DSL::Line.new(model) }
      let(:model)     { Vedeu::Line.new }

      describe '#initialize' do
        it { return_type_for(described, Vedeu::DSL::Line) }
        it { assigns(described, '@model', model) }
      end

    end # Line

  end # DSL

end # Vedeu
