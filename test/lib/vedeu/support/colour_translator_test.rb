require 'test_helper'

module Vedeu

  describe ColourTranslator do

    describe '#initialize' do
      it 'returns an instance of itself' do
        colour = ''

        ColourTranslator.new(colour).must_be_instance_of(ColourTranslator)
      end
    end

  end # ColourTranslator

end # Vedeu
