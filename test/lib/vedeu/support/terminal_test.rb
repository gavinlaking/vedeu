require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/support/terminal'

module Vedeu
  describe Terminal do
    describe '.input' do
      it 'returns the entered string' do
        console = IO.console
        console.stub :gets, "test\n" do
          Terminal.input.must_equal('test')
        end
      end
    end

    describe '.output' do
      it 'returns the output' do
        Terminal.output.must_equal('')
      end
    end

    describe '.width' do
      it 'returns the width of the terminal' do
        console = IO.console
        console.stub :winsize, [25, 80] do
          Terminal.width.must_equal(80)
        end
      end
    end

    describe '.height' do
      it 'returns the height of the terminal' do
        console = IO.console
        console.stub :winsize, [25, 80] do
          Terminal.height.must_equal(25)
        end
      end
    end

    describe '.size' do
      it 'returns the width and height of the terminal' do
        console = IO.console
        console.stub :winsize, [25, 80] do
          Terminal.size.must_equal([25, 80])
        end
      end
    end

    describe '.open' do
      it 'returns a NilClass' do
        skip
        Terminal.open.must_be_instance_of(NilClass)
      end
    end

    describe '.console' do
      it 'returns the console' do
        console = IO.console
        Terminal.console.must_equal(console)
      end
    end
  end
end
