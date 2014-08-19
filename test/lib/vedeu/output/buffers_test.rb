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

    describe '.enqueue' do
      it 'raises an exception if the interface cannot be found by name' do
        name     = 'unknown'
        sequence = '...'
        proc { Buffers.enqueue(name, sequence) }.must_raise(RefreshFailed)
      end

      it 'saves the new sequence for the interface into :next' do
      end
    end

    describe '.refresh_all' do
      it 'requests each stored interface to be refreshed' do
      end
    end

    describe '.reset' do
      it 'destroys all saved buffers' do
      end
    end
  end
end
