# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module DSL

    class TestUseClass

      include Vedeu::DSL::Use

    end

    describe Use do

      let(:described) { Vedeu::DSL::Use }
      let(:model_instance) { Vedeu::DSL::TestUseClass }

      describe '#use' do
        context 'when the model exists' do
          # @todo Add more tests.
          # it { skip }
        end

        context 'when the model does not exist' do
          # @todo Add more tests.
          # it { skip }
        end
      end

    end # Use

  end # DSL

end # Vedeu
