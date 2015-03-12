require 'test_helper'

module Vedeu

  describe Refresh do

    let(:described) { Vedeu::Refresh }

    before { Vedeu.interfaces.reset }

    describe '.all' do
      subject { described.all }

      it { subject.must_be_instance_of(Array) }

      context 'when there are no registered interfaces' do
        it { subject.must_equal([]) }
      end
    end

    describe '.by_focus' do
      subject { described.by_focus }

      context 'when there are no registered interfaces' do
        before { Vedeu.focusable.reset }

        it { described.by_focus.must_equal(nil) }
      end

      context 'when there are registered interfaces' do
      end
    end

    describe '.by_group' do
      context 'when there are no registered groups' do
        before { Vedeu.groups.reset }

        it { proc { described.by_group('') }.must_raise(ModelNotFound) }
      end

      context 'when there are registered groups' do
      end
    end

    describe '.by_name' do
      let(:interface_name) { 'aluminium' }

      subject { described.by_name(interface_name) }

      context 'when the interface or buffer is not found' do
        let(:interface_name) { '' }

        it { proc { described.by_name('') }.must_raise(ModelNotFound) }
      end

      context 'when the interface or buffer is found' do
      end
    end

    describe '.cursor' do
      let(:_name) {}

      subject { described.cursor(_name) }

      before { Vedeu::RefreshCursor.stubs(:render) }

      context 'when there is a name' do
        let(:_name) { 'refresh_cursor' }

        it {
          Vedeu::RefreshCursor.expects(:render).with(_name)
          subject
        }
      end

      context 'when there is no name' do
        it { subject.must_equal(nil) }
      end
    end

  end # Refresh

end # Vedeu
