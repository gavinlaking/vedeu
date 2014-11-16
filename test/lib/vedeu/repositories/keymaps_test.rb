require 'test_helper'

module Vedeu

  describe Keymaps do

    before { Keymaps.reset }

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

    describe '#find' do
      let(:attributes) {
        {
          interfaces: ['flerovium'],
          keys: [{ key: 'u', action: proc { :some_action } }]
        }
      }

      before { Keymaps.add(attributes) }

      it 'returns false when the named keymap cannot be found' do
        Keymaps.find('vanadium').must_equal({})
      end

      it 'returns the keymap when the named keymap was found' do
        Keymaps.find('flerovium').wont_be_empty
      end
    end

    describe '#global_key?' do
      before { Keymaps.stubs(:global_keys).returns(['i', 'j']) }

      it 'returns false when the key is not registered as a global key' do
        Keymaps.global_key?('h').must_equal(false)
      end

      it 'returns true when the key is registered as a global key' do
        Keymaps.global_key?('j').must_equal(true)
      end
    end

    describe '#global_keys' do
      let(:attributes) {
        {
          keys: [
            {
              key: 'a', action: proc { :action_a }
            },{
              key: 'b', action: proc { :action_b }
            },{
              key: 'c', action: proc { :action_c }
            }
          ]
        }
      }

      before { Keymaps.add(attributes) }

      it 'returns the defined global keys' do
        Keymaps.global_keys.must_equal(['a', 'b', 'c'])
      end
    end

    describe '#interface_key?' do
      before { Keymaps.stubs(:interface_keys).returns(['g', 'h']) }

      it 'returns false when the key is not registered with an interface' do
        Keymaps.interface_key?('f').must_equal(false)
      end

      it 'returns true when the key is registered with an interface' do
        Keymaps.interface_key?('g').must_equal(true)
      end

      context 'when the interface argument is provided' do
        before do
          Keymaps.stubs(:find).returns({ 'j' => proc { :some_action } })
        end

        it 'return false when the key is not registered with the specified ' \
           'interface' do
          Keymaps.interface_key?('k', 'cadmium').must_equal(false)
        end

        it 'return true when the key is registered with the specified ' \
           'interface' do
          Keymaps.interface_key?('j', 'cadmium').must_equal(true)
        end
      end
    end

    describe '#interface_keys' do
      let(:rhodium_attributes) {
        {
          interfaces: ['rhodium'],
          keys: [
            {
              key: 'd', action: proc { :action_d }
            },{
              key: 'e', action: proc { :action_e }
            }
          ]
        }
      }
      let(:magnesium_attributes) {
        {
          interfaces: ['magnesium'],
          keys: [
            {
              key: 'e', action: proc { :action_e }
            },{
              key: 'f', action: proc { :action_g }
            }
          ]
        }
      }

      before do
        Keymaps.add(rhodium_attributes)
        Keymaps.add(magnesium_attributes)
      end

      it 'returns the defined keys for all interfaces' do
        Keymaps.interface_keys.must_equal(['d', 'e', 'f'])
      end

      it 'returns the defined keys for the specified interface' do
        Keymaps.interface_keys('magnesium').must_equal(['e', 'f'])
      end
    end

    describe '#registered?' do
      it 'returns false when the named keymap is not registered' do
        Keymaps.registered?('vanadium').must_equal(false)
      end

      it 'returns true when the named keymap is registered' do
        Keymaps.registered?('_global_keymap_').must_equal(true)
      end
    end

    describe '#system_key?' do
      it 'returns false when the key is not registered as a system key' do
        Keymaps.system_key?('r').must_equal(false)
      end

      it 'returns true when the key is registered as a system key' do
        Keymaps.system_key?('q').must_equal(true)
      end
    end

    describe '#system_keys' do
      it 'returns the defined system keys' do
        Keymaps.system_keys.must_equal(['q', :tab, :shift_tab, :escape])
      end
    end

    describe '#use' do
      let(:meitnerium_attributes) {
        {
          interfaces: ['meitnerium'],
          keys: [{
            key: 'm', action: proc { :key_m_pressed }
          }]
        }
      }
      let(:global_attributes) {
        {
          keys: [{
            key: 'o', action: proc { :key_o_pressed }
          }]
        }
      }

      before do
        Keymaps.add(meitnerium_attributes)
        Keymaps.add(global_attributes)
        Vedeu::Focus.stubs(:current).returns('meitnerium')
        Vedeu::Configuration.stubs(:system_keys).returns({ :key_p_pressed => 'p' })
        Vedeu.stubs(:trigger).returns(:system_key_p_pressed)
      end

      context 'when not registered' do
        it 'returns false' do
          Keymaps.use('l').must_equal(false)
        end
      end

      context 'when registered as an interface key and the interface is in ' \
              'focus' do
        it 'returns the result of the keypress' do
          Keymaps.use('m').must_equal(:key_m_pressed)
        end
      end

      context 'when registered as a global key' do
        it 'returns the result of the keypress' do
          Keymaps.use('o').must_equal(:key_o_pressed)
        end
      end

      context 'when registered as a system key' do
        it 'returns the result of the keypress' do
          Keymaps.use('p').must_equal(:system_key_p_pressed)
        end
      end
    end

  end # Keymaps

end # Vedeu
