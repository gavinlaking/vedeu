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
        # @todo
        # it { skip }
      end
    end

    describe '.by_group' do
      let(:group_name) { 'elements' }
      let(:_name)      { 'aluminium' }

      subject { described.by_group(group_name) }

      it {
        Vedeu::RefreshGroup.expects(:by_name).with(group_name)
        subject
      }
    end

    describe '.by_name' do
      let(:_name)  { 'aluminium' }
      let(:buffer) { Vedeu::Null::Buffer.new(_name) }

      subject { described.by_name(_name) }

      it {
        Vedeu.buffers.expects(:by_name).with(_name).returns(buffer)
        buffer.expects(:render)
        subject
      }
    end

  end # Refresh

end # Vedeu
