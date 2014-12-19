require 'test_helper'

module Vedeu

  describe Refresh do

    before { Interfaces.reset }

    describe '.all' do
      it 'returns an empty collection when there are no registered ' \
         'interfaces' do
        Refresh.all.must_equal([])
      end
    end

    describe '.by_focus' do
      context 'when there are no registered interfaces' do
        Focus.reset

        it { proc { Refresh.by_focus }.must_raise(NoInterfacesDefined) }
      end
    end

    describe '.by_group' do
      context 'when the group cannot be found' do
        Groups.reset

        it { proc { Refresh.by_group('') }.must_raise(ModelNotFound) }
      end
    end

    describe '.by_name' do
      context 'when the buffer cannot be found' do
        it { proc { Refresh.by_name('') }.must_raise(ModelNotFound) }
      end
    end

  end # Refresh

end # Vedeu
