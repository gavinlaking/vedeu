require 'test_helper'

module Vedeu

  describe Buffers do

    before { Buffers.reset }

    describe '.add' do
      it 'returns the name of the buffer added to storage' do
        Buffers.add({ name: 'molybdenum' }).must_equal('molybdenum')
      end

      context 'when the attributes do not have a :name key' do
        attributes = { no_name_key: '' }

        it { proc { Buffers.add(attributes) }.must_raise(MissingRequired) }
      end

    end

  end # Buffers

end # Vedeu
