require 'test_helper'

module Vedeu
  describe Offsets do

    before { Offsets.reset }

    describe '#add' do
      it 'raises an exception if a :name attribute is not provided' do
        proc { Offsets.add({ no_name: 'no_name' }) }
          .must_raise(MissingRequired)
      end

      it 'returns a new instance of Offset once stored' do
        Offsets.add({ name: 'praseodymium' }).must_be_instance_of(Offset)
      end
    end

    describe '#find' do
      it 'returns a new instance of Offset' do
        Offsets.find({ name: 'praseodymium' }).must_be_instance_of(Offset)
      end
    end

  end
end
