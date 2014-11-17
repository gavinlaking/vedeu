require 'test_helper'

module Vedeu

  describe Keymap do

    let(:described)  { Keymap.new(attributes) }
    let(:attributes) { {} }

    describe '.define' do
      it { return_type_for(Keymap.define, Keymap) }
    end

    describe '#initialize' do
      it { return_type_for(described, Keymap) }
      it { assigns(described, '@attributes', { interfaces: [], keys: [] }) }
    end

  end # Keymap

end # Vedeu
