require 'test_helper'

module Vedeu
  describe Buffers do
    before { Buffers.reset }

    describe '.enqueue' do
      it 'raises an exception if the interface cannot be found by name' do
        name = 'unknown'
        view = '...'
        proc { Buffers.enqueue(name, view) }.must_raise(InterfaceNotFound)
      end
    end
  end
end
