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
      context 'when already in use as a system key' do
        it 'returns false with a message' do
          result = KeymapValidator.check(storage, :shift_tab, interface)
          result.must_include(false)
          result.last.must_match(/by the system/)
        end
      end

      context 'when already in use as a global key' do
        it 'returns false with a message' do
          result = KeymapValidator.check(storage, 'g', interface)
          result.must_include(false)
          result.last.must_match(/as a global key/)
        end
      end

      context 'when already in use by the interface' do
        it 'returns false with a message' do
          result = KeymapValidator.check(storage, 'a', interface)
          result.must_include(false)
          result.last.must_match(/by this interface/)
        end
      end

      context 'when attempting to register a global key which is already in ' \
              'use by an interface' do
        it 'returns false with a message' do
          result = KeymapValidator.check(storage, 'a', '')
          result.must_include(false)
          result.last.must_match(/registered to an interface/)
        end
      end

      context 'when valid as a global key' do
        it 'returns true with a message' do
          result = KeymapValidator.check(storage, 'h', '')
          result.must_include(true)
          result.last.must_match(/can be registered/)
        end
      end

      context 'when valid as an interface key' do
        it 'returns true with a message' do
          result = KeymapValidator.check(storage, 'b', 'dubnium')
          result.must_include(true)
          result.last.must_match(/can be registered/)
        end
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

  end
end
