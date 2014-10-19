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

    describe '#move' do
      before { Focus.stubs(:current).returns('praseodymium') }

      it 'returns an instance of Offset' do
        Offsets.move(0, 1).must_be_instance_of(Offset)
      end

      it 'alters the offset of the interface in focus' do
        Offsets.move(0, 1).x.must_equal(1)
      end
    end

  end
end
