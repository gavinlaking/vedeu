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

    describe '#method_missing' do
      it 'returns nil' do
        Keymap.new.some_missing_method(:test).must_equal(nil)
      end
    end

  end # Keymap

end # Vedeu
