require 'test_helper'

module Vedeu

  describe Keymap do

    describe '.define' do
      it 'returns an instance of Keymap' do
        Keymap.define.must_be_instance_of(Keymap)
      end
    end

    describe '#initialize' do
      it 'returns an instance of itself' do
        Keymap.new.must_be_instance_of(Keymap)
      end
    end

    describe '#method_missing' do
      it 'returns nil' do
        Keymap.new.some_missing_method(:test).must_equal(nil)
      end
    end

  end # Keymap

end # Vedeu
