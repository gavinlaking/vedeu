require 'test_helper'

module Vedeu

  describe Translator do

    describe '#initialize' do
      it 'returns an instance of itself' do
        colour = ''

        Translator.new(colour).must_be_instance_of(Translator)
      end
    end

  end # Translator

end # Vedeu
