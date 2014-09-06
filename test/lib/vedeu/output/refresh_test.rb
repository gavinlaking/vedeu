require 'test_helper'

module Vedeu
  describe Refresh do
    describe '.add_interface' do
      it 'returns false when provided with no attributes' do
        Refresh.add_interface({}).must_equal(false)
      end
    end

    describe '.add_group' do
      it 'returns false when provided with no attributes' do
        Refresh.add_group({}).must_equal(false)
      end
    end

    describe '.all' do
      it 'returns an empty collection when there are no registered ' \
         'interfaces' do
        Interfaces.reset

        Refresh.all.must_equal([])
      end
    end

    describe '.by_focus' do
      it 'raises an exception when there are no registered interfaces' do
        Focus.reset

        proc { Refresh.by_focus }.must_raise(NoInterfacesDefined)
      end
    end

    describe '.by_group' do
      it 'raises an exception when the group cannot be found' do
        Groups.reset

        proc { Refresh.by_group('') }.must_raise(GroupNotFound)
      end
    end

    describe '.by_name' do
      it 'raises an exception when the buffer cannot be found' do
        proc { Refresh.by_name('') }.must_raise(BufferNotFound)
      end
    end
  end
end
