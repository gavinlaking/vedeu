require_relative '../../test_helper'

module Vedeu
  describe Interface do
    let(:klass)    { Interface }
    let(:instance) { klass.new(options) }
    let(:options)  { {} }

    before do
      Vedeu::Terminal.stubs(:width).returns(80)
      Vedeu::Terminal.stubs(:height).returns(25)
      Vedeu::Terminal.stubs(:show_cursor)
      Vedeu::Terminal.stubs(:hide_cursor)
    end

    it { instance.must_be_instance_of(Interface) }

    describe '#initial' do
      subject { instance.initial }

      context 'capturing output' do
        let(:io) { capture_io { subject }.join }

        it { io.must_be_instance_of(String) }
      end
    end

    describe '#main' do
      subject { instance.main }

      it { subject.must_be_instance_of(NilClass) }

      context 'capturing output' do
        let(:io) { capture_io { subject }.join }

        it { io.must_be_instance_of(String) }
      end
    end

    describe '#input' do
      subject { instance.input }

      it { subject.must_be_instance_of(NilClass) }

      context 'capturing output' do
        let(:io) { capture_io { subject }.join }

        it { io.must_be_instance_of(String) }
      end
    end

    describe '#output' do
      subject { instance.output }

      it { subject.must_be_instance_of(NilClass) }

      context 'capturing output' do
        let(:io) { capture_io { subject }.join }

        it { io.must_be_instance_of(String) }
      end
    end

    describe '#width' do
      subject { instance.width }

      it { subject.must_be_instance_of(Fixnum) }
    end

    describe '#height' do
      subject { instance.height }

      it { subject.must_be_instance_of(Fixnum) }
    end
  end
end
