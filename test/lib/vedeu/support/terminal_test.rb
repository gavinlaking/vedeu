require_relative '../../../test_helper'

module Vedeu
  describe Terminal do
    let(:klass)    { Terminal }
    let(:console)  { stub }

    before do
      IO.stubs(:console).returns(console)
      console.stubs(:winsize).returns([25, 80])
    end

    describe '.input' do
      before  { console.stubs(:getc).returns("t") }

      subject { klass.input }

      it { subject.must_be_instance_of(String) }
    end

    describe '.width' do
      subject { klass.width }

      it { subject.must_be_instance_of(Fixnum) }

      it 'returns the width of the terminal' do
        subject.must_equal(80)
      end
    end

    describe '.height' do
      subject { klass.height }

      it { subject.must_be_instance_of(Fixnum) }

      it 'returns the height of the terminal' do
        subject.must_equal(25)
      end
    end

    describe '.size' do
      subject { klass.size }

      it { subject.must_be_instance_of(Array) }

      it 'returns the width and height of the terminal' do
        subject.must_equal([25, 80])
      end
    end

    describe '.cooked' do
      subject { klass.cooked }

      it { skip }
    end

    describe '.raw' do
      subject { klass.raw }

      it { skip }
    end

    describe '.console' do
      subject { klass.console }

      it { skip }
    end

    describe '.clear_screen' do
      before { Esc.stubs(:clear).returns('') }

      subject { klass.clear_screen }

      it { subject.must_be_instance_of(NilClass) }

      context 'capturing output' do
        let(:io) { capture_io { subject }.join }

        it { io.must_be_instance_of(String) }
      end
    end

    describe '.show_cursor' do
      subject { klass.show_cursor }

      it { subject.must_be_instance_of(NilClass) }

      context 'capturing output' do
        let(:io) { capture_io { subject }.join }

        it { io.must_be_instance_of(String) }
      end
    end

    describe '.hide_cursor' do
      subject { klass.hide_cursor }

      it { subject.must_be_instance_of(NilClass) }

      context 'capturing output' do
        let(:io) { capture_io { subject }.join }

        it { io.must_be_instance_of(String) }
      end
    end

    describe '.set_position' do
      let(:y) { 0 }
      let(:x) { 0 }

      before { Esc.stubs(:set_position).returns(nil) }

      subject { klass.set_position(y, x) }

      it { subject.must_be_instance_of(NilClass) }

      context 'capturing output' do
        let(:io) { capture_io { subject }.join }

        it { skip }
      end
    end
  end
end
