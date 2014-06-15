require_relative '../../../test_helper'

module Vedeu
  describe Terminal do
    let(:described_class) { Terminal }
    let(:console)         { stub }

    before do
      IO.stubs(:console).returns(console)
      console.stubs(:winsize).returns([25, 80])
      console.stubs(:print)
    end

    describe '.input' do
      let(:subject) { described_class.input }

      before { console.stubs(:gets).returns("test\n") }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns the entered string' do
        subject.must_equal("test")
      end
    end

    describe '.output' do
      let(:subject) { described_class.output }

      before { console.stubs(:print).returns("test") }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns the output' do
        subject.must_equal("test")
      end
    end

    describe '.width' do
      let(:subject) { described_class.width }

      it 'returns a Fixnum' do
        subject.must_be_instance_of(Fixnum)
      end

      it 'returns the width of the terminal' do
        subject.must_equal(80)
      end
    end

    describe '.height' do
      let(:subject) { described_class.height }

      it 'returns a Fixnum' do
        subject.must_be_instance_of(Fixnum)
      end

      it 'returns the height of the terminal' do
        subject.must_equal(25)
      end
    end

    describe '.size' do
      let(:subject) { described_class.size }

      it 'returns an Array' do
        subject.must_be_instance_of(Array)
      end

      it 'returns the width and height of the terminal' do
        subject.must_equal([25, 80])
      end
    end

    describe '.open' do
      let(:subject) { described_class.open }
    end

    describe '.close' do
      let(:subject) { described_class.close }
    end

    describe '.cooked' do
      let(:subject) { described_class.cooked }
    end

    describe '.raw' do
      let(:subject) { described_class.raw }
    end

    describe '.console' do
      let(:subject) { described_class.console }
    end

    describe '.clear_screen' do
      let(:subject) { described_class.clear_screen }

      before { Esc.stubs(:clear).returns('') }

      it 'returns a NilClass' do
        subject.must_be_instance_of(NilClass)
      end

      context 'capturing output' do
        let(:io) { capture_io { subject }.join }

        it 'returns a String' do
          io.must_be_instance_of(String)
        end
      end
    end

    describe '.clear_line' do
      let(:subject) { described_class.clear_line(index) }
      let(:index)   { 0 }

      it 'returns a NilClass' do
        subject.must_be_instance_of(NilClass)
      end
    end

    describe '.show_cursor' do
      let(:subject) { described_class.show_cursor }

      it 'returns a NilClass' do
        subject.must_be_instance_of(NilClass)
      end

      context 'capturing output' do
        let(:io) { capture_io { subject }.join }

        it 'returns a String' do
          io.must_be_instance_of(String)
        end
      end
    end

    describe '.hide_cursor' do
      let(:subject) { described_class.hide_cursor }

      it 'returns a NilClass' do
        subject.must_be_instance_of(NilClass)
      end

      context 'capturing output' do
        let(:io) { capture_io { subject }.join }

        it 'returns a String' do
          io.must_be_instance_of(String)
        end
      end
    end

    describe '.reset_colours' do
      let(:subject) { described_class.reset_colours }

      it 'returns a NilClass' do
        subject.must_be_instance_of(NilClass)
      end

      context 'capturing output' do
        let(:io) { capture_io { subject }.join }

        it 'returns a String' do
          io.must_be_instance_of(String)
        end
      end
    end

    describe '#initialize' do
      let(:subject) { described_class.new }

      it 'returns a Terminal instance' do
        subject.must_be_instance_of(Terminal)
      end
    end

    describe '#open' do
      let(:subject) { described_class.new.open }

      it 'returns a NilClass' do
        subject.must_be_instance_of(NilClass)
      end
    end

    describe '#initial_setup!' do
      let(:subject) { described_class.new.initial_setup! }

      it 'returns a NilClass' do
        subject.must_be_instance_of(NilClass)
      end
    end
  end
end
