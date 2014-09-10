require 'test_helper'

module Vedeu
  describe Buffers do

    describe '.add' do
      it 'returns the name of the buffer added to storage' do
        Buffers.add({ name: 'molybdenum' }).must_equal('molybdenum')
      end

      context 'when the buffer is already registered' do
        it 'retrieves the buffer in storage, and adds the attributes to the ' \
           'back buffer, preserving the front which may already have content' do
          skip
        end
      end

      context 'when the buffer was not registered' do
        it 'stores a new buffer by name, and adds the attributes to the back ' \
           'buffer' do
          skip
        end
      end
    end

    describe '.find' do
      context 'when the buffer does not exist by this name' do
        it '' do
          skip
        end
      end

      context 'when the buffer can be found by name' do
        it '' do
          skip
        end
      end
    end

    describe '.latest' do
      context 'when the buffer does not exist by this name' do
        it '' do
          skip
        end
      end

      context 'when the buffer can be found by name' do
        it '' do
          skip
        end
      end
    end

    describe '.reset' do
      it '' do
          skip
        end
    end

  end
end
