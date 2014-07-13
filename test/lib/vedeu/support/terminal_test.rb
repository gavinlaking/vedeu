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
      let(:subject) { described_class.input }

      before { console.stubs(:gets).returns("test\n") }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns the entered string' do
        subject.must_equal('test')
      end
    end

    describe '.output' do
      let(:subject) { described_class.output }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns the output' do
        subject.must_equal('')
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

    describe '.console' do
      let(:subject) { described_class.console }

      it 'returns the console' do
        subject.must_equal(console)
      end
    end
  end
end
