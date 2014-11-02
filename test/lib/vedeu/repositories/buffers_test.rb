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

    describe '.update' do
      let(:buffer) { Buffer.new({ name: 'einsteinium' }) }

      subject { Buffers.update(buffer) }

      it { subject.must_equal(true) }
    end

  end # Buffers

end # Vedeu
