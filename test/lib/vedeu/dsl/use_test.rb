require 'test_helper'

module Vedeu

  module DSL

    describe Use do

      # before do
      #   Vedeu.interfaces.reset
      #   Vedeu.interface('hydrogen') do
      #     delay 0.75
      #   end
      #   Vedeu.interface('helium') do
      #     duplicate('hydrogen')
      #   end
      # end

      describe '#duplicate' do
        subject { model_instance.duplicate(_name) }

        context 'when the model exists' do
          # it { skip }
        end

        context 'when the model does not exist' do
          # it { skip }
        end
      end

      describe '#use' do
        context 'when the model exists' do
          # it { skip }
        end

        context 'when the model does not exist' do
          # it { skip }
        end
      end

    end # Use

  end # DSL

end # Vedeu
