require_relative '../../../test_helper'

module Vedeu
  describe Interface do
    let(:described_class)    { Interface }
    let(:instance) { described_class.new(options) }
    let(:options)  { {} }

    before do
      Terminal.stubs(:width).returns(80)
      Terminal.stubs(:height).returns(25)
      Terminal.stubs(:show_cursor)
      Terminal.stubs(:hide_cursor)
    end

    it { instance.must_be_instance_of(Interface) }

    describe '#initial_state' do
      subject { instance.initial_state }

      context 'capturing output' do
        let(:io) { capture_io { subject }.join }

        it { io.must_be_instance_of(String) }
      end
    end

    describe '#event_loop' do
      subject { instance.event_loop }

      it { subject.must_be_instance_of(NilClass) }

      context 'capturing output' do
        let(:io) { capture_io { subject }.join }

        it { io.must_be_instance_of(String) }
      end
    end
  end
end
