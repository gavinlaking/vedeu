require 'test_helper'

module Vedeu

  module DSL

    describe Stream do

      let(:described) { Vedeu::DSL::Stream.new(model) }
      let(:model)     { Vedeu::Stream.new }

      describe '#initialize' do
        it { return_type_for(described, Vedeu::DSL::Stream) }
        it { assigns(described, '@model', model) }
      end

    end # Stream

  end # DSL

end # Vedeu
