require 'test_helper'

module Vedeu
  describe Buffers do
    before do
      Buffers.reset
    end

    describe '.create' do
      it 'creates an entry for the interface, and saves :clear' do
      end
    end

    describe '.create_events' do

    end

    describe '.enqueue' do
      it 'raises an exception if the interface cannot be found by name' do
        name     = 'unknown'
        sequence = '...'
        proc { Buffers.enqueue(name, sequence) }.must_raise(RefreshFailed)
      end

      it 'saves the new sequence for the interface into :next' do
      end
    end

    describe '.query' do
      it 'raises an exception if the interface cannot be found by name' do
        name     = 'unknown'
        proc { Buffers.query(name) }.must_raise(RefreshFailed)
      end

      it 'returns the interface buffer when found' do

      end
    end

    describe '.refresh' do
      it 'raises an exception if the interface cannot be found by name' do
        name     = 'unknown'
        proc { Buffers.refresh(name) }.must_raise(RefreshFailed)
      end
    end

    describe '.refresh_all' do
      it 'requests each stored interface to be refreshed' do
      end
    end

    describe '.refresh_group' do
    end

    describe '.reset' do
      it 'destroys all saved buffers' do
      end
    end

    describe '.store' do
      it 'stores a new buffer by name, and returns the buffer' do
        name   = 'my_buffer'
        buffer = mock('Buffer')
        Buffers.store(name, buffer).must_equal(buffer)
      end
    end
  end
end
