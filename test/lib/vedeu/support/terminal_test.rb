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

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns the output' do
        subject.must_equal("")
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

      it 'returns a NilClass' do
        subject.must_be_instance_of(NilClass)
      end
    end

    describe '.close' do
      let(:subject) { described_class.close }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an escape sequence' do
        subject.must_equal("\e[24;1H                                                                                \e[24;1H")
      end
    end

    describe '.cooked' do
      let(:subject)  { described_class.cooked(instance) }
      let(:instance) {}

      it 'returns a NilClass' do
        subject.must_be_instance_of(NilClass)
      end
    end

    describe '.raw' do
      let(:subject)  { described_class.raw(instance) }
      let(:instance) {}

      it 'returns a NilClass' do
        subject.must_be_instance_of(NilClass)
      end
    end

    describe '.console' do
      let(:subject) { described_class.console }

      it 'returns the console' do
        subject.must_equal(console)
      end
    end

    describe '.clear_screen' do
      let(:subject) { described_class.clear_screen }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an escape sequence' do
        subject.must_equal("\e[2J")
      end
    end

    describe '.clear_line' do
      let(:subject) { described_class.clear_line(index) }
      let(:index)   { 0 }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an escape sequence' do
        subject.must_equal("\e[0;1H                                                                                \e[0;1H")
      end
    end

    describe '.show_cursor' do
      let(:subject) { described_class.show_cursor }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an escape sequence' do
        subject.must_equal("\e[?25h")
      end
    end

    describe '.hide_cursor' do
      let(:subject) { described_class.hide_cursor }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an escape sequence' do
        subject.must_equal("\e[?25l")
      end
    end

    describe '.reset_colours' do
      let(:subject) { described_class.reset_colours }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an escape sequence' do
        subject.must_equal("\e[0m")
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

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an escape sequence' do
        subject.must_equal("\e[1;1H")
      end
    end
  end
end
