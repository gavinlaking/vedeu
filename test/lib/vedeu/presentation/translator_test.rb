require 'test_helper'

module Vedeu

  describe Translator do

    let(:described) { Translator.new(colour) }
    let(:colour)    { '#ff0000' }

    describe '#initialize' do
      it { return_type_for(described, Translator) }
      it { assigns(described, '@colour', colour) }
    end

  end # Translator

end # Vedeu
