require 'test_helper'

module Vedeu
  describe Keymaps do

    describe '#add' do
      it 'returns false when there are no keys defined' do
        attributes = {}

        Keymaps.add(attributes).must_equal(false)
      end

      it 'returns true when the key was registered with keymap storage' do
        attributes = { interfaces: ['gold'], keys: [{ 'a' => proc { :gold } }] }

        Keymaps.add(attributes).must_equal(true)
      end
    end

    describe '#all' do
      it 'returns' do
        skip
      end
    end

    describe '#find' do
      it 'returns' do
        skip
      end
    end

    describe '#registered' do
      it 'returns' do
        skip
      end
    end

    describe '#registered?' do
      it 'returns' do
        skip
      end
    end

    describe '#reset' do
      it 'removes all stored keymaps' do
        Keymaps.reset.must_equal({ '_global_keymap_' => {} })
      end
    end

    describe '#use' do
      context 'when registered as an interface key' do
        context 'and the interface is in focus' do
          it 'returns' do
            skip
          end
        end

        context 'but the interface is not in focus' do
          it 'returns' do
            skip
          end
        end
      end

      context 'when registered as a global key' do
        it 'returns' do
          skip
        end
      end

      context 'when registered as a system key' do
        it 'returns' do
          skip
        end
      end
    end

  end
end

interfaces = ['hydrogen', 'helium']

attributes = {
  interfaces: ['xenon', 'hassium'],
  keys:       [
    { key: 'a', action: proc { :a_action } },
    { key: 'b', action: proc { :b_action } },
    { key: 'c', action: proc { :c_action } },
    { key: 'd', action: proc { :d_action } }
  ],
}

storage = {
  'interface_name' => {
    'a' => proc { :some_action },
    'b' => proc { :some_action },
    'c' => proc { :some_action },
  },
  '_global_keymap_' => {
    'd' => proc { :some_action },
    'e' => proc { :some_action },
    'f' => proc { :some_action },
  },
  '_system_' => {

  }
}

# if keymap has no name use _global_keymap_ ?
# if keymap has more than on interface, create keymap for each interface name
