require 'test_helper'

module Vedeu

  describe Translator do

    colour    = '#ff0000'
    described = Translator.new(colour)

    describe '#initialize' do
      it 'returns an instance of itself' do
        described.must_be_instance_of(Translator)
      end

      it 'assigns the colour' do
        assigns(described, '@colour', colour)
      end
    end

  end # Translator

end # Vedeu
