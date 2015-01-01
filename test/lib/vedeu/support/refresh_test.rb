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
      let(:interface_name) { 'aluminium' }

      subject { Refresh.by_name(interface_name) }

      context 'when the interface or buffer is not found' do
        let(:interface_name) { '' }

        it { proc { Refresh.by_name('') }.must_raise(ModelNotFound) }
      end

      context 'when the interface or buffer is found' do
        # it { return_type_for(subject, Array) }

        it { skip }
      end
    end

  end # Refresh

end # Vedeu
