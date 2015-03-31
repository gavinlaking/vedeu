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

        it { subject.must_equal(nil) }
      end

      context 'when there are registered interfaces' do
      end
    end

    describe '.by_group' do
      subject { described.by_group(group_name) }

      context 'when there are no registered groups' do
        let(:group_name) { '' }

        before { Vedeu.groups.reset }

        it { proc { subject }.must_raise(ModelNotFound) }
      end

      context 'when there are registered groups' do
        let(:group_name) { 'elements' }

        before do
          Vedeu::Group.new({ name: group_name, members: 'aluminium' }).store
        end

        it { Vedeu::Compositor.expects(:compose).with('aluminium'); subject }
      end
    end

    describe '.by_name' do
      let(:interface_name) { 'aluminium' }

      subject { described.by_name(interface_name) }

      it { Vedeu::Compositor.expects(:compose).with(interface_name); subject }
    end

  end # Refresh

end # Vedeu
