require_relative '../../../test_helper'

module Vedeu
  describe Terminal do
    let(:described_class)    { Terminal }
    let(:console)  { stub }

    before do
      IO.stubs(:console).returns(console)
      console.stubs(:winsize).returns([25, 80])
    end

    describe '.input' do
      before  { console.stubs(:gets).returns("test") }

      subject { described_class.input }

      it { subject.must_be_instance_of(String) }
    end

    describe '.output' do
      before { console.stubs(:puts).returns("test") }

      subject { described_class.output }

      it { subject.must_be_instance_of(String) }
    end

    describe '.width' do
      subject { described_class.width }

      it { subject.must_be_instance_of(Fixnum) }

      it 'returns the width of the terminal' do
        subject.must_equal(80)
      end
    end

    describe '.height' do
      subject { described_class.height }

      it { subject.must_be_instance_of(Fixnum) }

      it 'returns the height of the terminal' do
        subject.must_equal(25)
      end
    end

    describe '.size' do
      subject { described_class.size }

      it { subject.must_be_instance_of(Array) }

      it 'returns the width and height of the terminal' do
        subject.must_equal([25, 80])
      end
    end

    describe '.open' do
      subject { described_class.open }

      it { skip }
    end

    describe '.close' do
      subject { described_class.close }

      it { skip }
    end

    describe '.cooked' do
      subject { described_class.cooked }

      it { skip }
    end

    describe '.raw' do
      subject { described_class.raw }

      it { skip }
    end

    describe '.console' do
      subject { described_class.console }

      it { skip }
    end

    describe '.clear_screen' do
      before do
        Esc.stubs(:clear).returns('')
        console.stubs(:puts)
      end

      subject { described_class.clear_screen }

      it { subject.must_be_instance_of(NilClass) }

      context 'capturing output' do
        let(:io) { capture_io { subject }.join }

        it { io.must_be_instance_of(String) }
      end
    end

    describe '.clear_line' do
      subject { described_class.clear_line }

      it { skip }
    end

    describe '.show_cursor' do
      before { console.stubs(:puts) }

      subject { described_class.show_cursor }

      it { subject.must_be_instance_of(NilClass) }

      context 'capturing output' do
        let(:io) { capture_io { subject }.join }

        it { io.must_be_instance_of(String) }
      end
    end

    describe '.hide_cursor' do
      before { console.stubs(:puts) }

      subject { described_class.hide_cursor }

      it { subject.must_be_instance_of(NilClass) }

      context 'capturing output' do
        let(:io) { capture_io { subject }.join }

        it { io.must_be_instance_of(String) }
      end
    end

    describe '#initialize' do
      subject { described_class.new }

      it { skip }
    end

    describe '#open' do
      subject { described_class.new.open }

      it { skip }
    end

    describe '#initial_setup!' do
      subject { described_class.new.initial_setup! }

      it { skip }
    end
  end
end
