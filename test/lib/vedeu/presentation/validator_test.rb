require 'test_helper'

module Vedeu

  describe Validator do

    let(:described)  { Validator.new(attributes) }
    let(:attributes) { {} }

    describe '#initialize' do
      it { return_type_for(described, Validator) }
      it { assigns(described, '@attributes', attributes) }
    end

    describe '.check' do
      it { proc { Validator.check(attributes) }.must_raise(InvalidSyntax) }
    end

  end # Validator

end # Vedeu
