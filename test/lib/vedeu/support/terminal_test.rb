require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/support/terminal'

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
      def subject
        Terminal.input
      end

      before { console.stubs(:gets).returns("test\n") }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns the entered string' do
        subject.must_equal('test')
      end
    end

    describe '.output' do
      def subject
        Terminal.output
      end

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns the output' do
        subject.must_equal('')
      end
    end

    describe '.width' do
      def subject
        Terminal.width
      end

      it 'returns a Fixnum' do
        subject.must_be_instance_of(Fixnum)
      end

      it 'returns the width of the terminal' do
        subject.must_equal(80)
      end
    end

    describe '.height' do
      def subject
        Terminal.height
      end

      it 'returns a Fixnum' do
        subject.must_be_instance_of(Fixnum)
      end

      it 'returns the height of the terminal' do
        subject.must_equal(25)
      end
    end

    describe '.size' do
      def subject
        Terminal.size
      end

      it 'returns an Array' do
        subject.must_be_instance_of(Array)
      end

      it 'returns the width and height of the terminal' do
        subject.must_equal([25, 80])
      end
    end

    describe '.open' do
      def subject
        Terminal.open
      end

      it 'returns a NilClass' do
        subject.must_be_instance_of(NilClass)
      end
    end

    describe '.console' do
      def subject
        Terminal.console
      end

      it 'returns the console' do
        subject.must_equal(console)
      end
    end
  end
end
