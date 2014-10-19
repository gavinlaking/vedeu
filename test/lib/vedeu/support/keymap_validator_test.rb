require 'test_helper'

module Vedeu

  describe KeymapValidator do

    let(:storage)   {
      {
        'dubnium' => {
          'a' => proc { :do_something }
        },
        '_global_keymap_' => {
          'g' => proc { :do_something }
        }
      }
    }
    let(:key)       { 'a' }
    let(:interface) { 'dubnium' }

    describe '.check' do
      it 'raises an exception when already in use as a system key' do
        proc {
          KeymapValidator.check(storage, :shift_tab, interface)
        }.must_raise(KeyInUse)
      end

      it 'raises an exception when already in use as a global key' do
        proc {
          KeymapValidator.check(storage, 'g', interface)
        }.must_raise(KeyInUse)
      end

      it 'raises an exception when already in use by the interface' do
        proc {
          KeymapValidator.check(storage, 'a', interface)
        }.must_raise(KeyInUse)
      end

      it 'raises an exception when already in use' do
        proc { KeymapValidator.check(storage, 'a', '') }.must_raise(KeyInUse)
      end

      it 'returns true when valid as a global key' do
        KeymapValidator.check(storage, 'h', '').must_equal(true)
      end

      it 'returns true when valid as an interface key' do
        KeymapValidator.check(storage, 'b', 'dubnium').must_equal(true)
      end
    end

    describe '#initialize' do
      it 'returns an instance of itself' do
        storage   = {}
        key       = ''
        interface = ''

        KeymapValidator.new(storage, key, interface)
        .must_be_instance_of(KeymapValidator)
      end
    end

  end # KeymapValidator

end # Vedeu
