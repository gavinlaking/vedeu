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
      subject { capture_io { instance.initial }.join }

      it { subject.must_be_instance_of(String) }
    end

    describe '#main' do
      subject { capture_io { instance.main }.join }

      it { subject.must_be_instance_of(String) }
    end

    describe '#input' do
      subject { capture_io { instance.input }.join }

      it { subject.must_be_instance_of(String) }
    end

    describe '#output' do
      subject { capture_io { instance.output }.join }

      it { subject.must_be_instance_of(String) }
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
