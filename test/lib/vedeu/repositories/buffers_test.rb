require 'test_helper'

module Vedeu

  describe Buffers do

    before { Buffers.reset }

    describe '.add' do
      it 'returns the name of the buffer added to storage' do
        Buffers.add({ name: 'molybdenum' }).must_equal('molybdenum')
      end

      it 'raises an exception if the attributes does not have a :name key' do
        attributes = { no_name_key: '' }

        proc { Buffers.add(attributes) }.must_raise(MissingRequired)
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

    describe '.back' do
      context 'when the buffer does not exist' do
        it 'raises an exception' do
          proc { Buffers.back('actinium') }.must_raise(BufferNotFound)
        end
      end

      context 'when the buffer exists' do
        before { Buffers.add({ name: 'mercury' }) }

        it 'returns a Hash' do
          Buffers.back('mercury').must_be_instance_of(Hash)
        end

        it 'returns the stored attributes' do
          Buffers.back('mercury').must_equal({ name: 'mercury' })
        end
      end
    end

    describe '.front' do
      context 'when the buffer does not exist' do
        it 'raises an exception' do
          proc { Buffers.front('mercury') }.must_raise(BufferNotFound)
        end
      end

      context 'when the buffer exists but there is no content' do
        before { Buffers.add({ name: 'actinium' }) }

        it 'returns a NilClass' do
          Buffers.front('actinium').must_be_instance_of(NilClass)
        end
      end
    end

    describe '.latest' do
      context 'when the buffer does not exist' do
        it 'raises an exception' do
          proc { Buffers.front('nobelium') }.must_raise(BufferNotFound)
        end
      end

      context 'when the buffer exists and there is content' do
        before { Buffers.add({ name: 'nobelium' }) }

        it 'returns the stored attributes' do
          Buffers.latest('nobelium').must_equal({ name: 'nobelium' })
        end
      end
    end

  end # Buffers

end # Vedeu
