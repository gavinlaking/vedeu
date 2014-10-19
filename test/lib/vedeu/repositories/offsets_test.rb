require 'test_helper'

module Vedeu

  describe Offsets do

    before { Offsets.reset }

    describe '#move' do
      before { Focus.stubs(:current).returns('praseodymium') }

      it 'returns an instance of Offset' do
        Offsets.move(0, 1).must_be_instance_of(Offset)
      end

      it 'alters the offset of the interface in focus' do
        Offsets.move(0, 1).x.must_equal(1)
      end
    end

  end # Offsets

end # Vedeu
