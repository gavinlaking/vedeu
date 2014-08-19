require 'test_helper'

module Vedeu
  describe Buffer do
    let(:vars) {
      { name: 'interface', clear: '', current: '', group: '', next: '' }
    }

    describe '#initialize' do
      it 'returns a Buffer instance when all the vars are set' do
        #vars = { name: 'interface', clear: '', current: '', group: '', next: '' }
        Buffer.new(vars).must_be_instance_of(Buffer)
      end

      it 'raises an exception if a var is not set' do
        vars = {}
        proc { Buffer.new(vars) }.must_raise(KeyError)
      end
    end

    describe '#enqueue' do
      it 'creates a new Buffer instance with the sequence assigned to @_next' do
        buffer     = Buffer.new(vars)
        new_buffer = buffer.enqueue('some_sequence')

        buffer._next.must_equal('')
        new_buffer.wont_equal(buffer)
        new_buffer._next.must_equal('some_sequence')
      end
    end

    describe '#refresh' do
    end
  end
end
