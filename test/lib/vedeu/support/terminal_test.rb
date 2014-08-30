require 'test_helper'

module Vedeu
  describe Terminal do
    let(:console) { IO.console }

    describe '.open' do
      before { IO.console.stubs(:print) }

      it 'raises an exception when no block is given' do
        proc { Terminal.open }.must_raise(InvalidSyntax)
      end

      it 'opens a new terminal console in raw mode' do
        Configuration.stub(:terminal_mode, :raw) do
          capture_io do
            Terminal.open do
              print "Hello from raw mode!"
            end
          end.must_equal(["Hello from raw mode!", ""])
        end
      end

      it 'opens a new terminal console in cooked mode' do
        Configuration.stub(:terminal_mode, :cooked) do
          capture_io do
            Terminal.open do
              print "Hello from cooked mode!"
            end
          end.must_equal(["Hello from cooked mode!", ""])
        end
      end
    end

    describe '.input' do
      # it 'returns the entered string in cooked mode' do
      #   Configuration.stub(:terminal_mode, :cooked) do
      #     Terminal.console.stub(:gets, "test\n") do
      #       Terminal.input.must_equal('test')
      #     end
      #   end
      # end

      # it 'returns the entered string in raw mode' do
      #   Configuration.stub(:terminal_mode, :raw) do
      #     console.stub :getch, "a" do
      #       Terminal.input.must_equal("a")
      #     end
      #   end
      # end
    end

    describe '.output' do
      before { IO.console.stubs(:print) }

      it 'returns the output' do
        Terminal.output('Some output...').must_equal('Some output...')
      end
    end

    describe '.clear_last_line' do
      it 'returns an escape sequence to clear the last line' do
        console.stub :winsize, [25, 25] do
          Terminal.clear_last_line
            .must_equal("\e[24;1H\e[38;2;39m\e[48;2;49m\e[2K")
        end
      end
    end

    describe '.mode' do
      before do
        Configuration.stubs(:terminal_mode).returns(:raw)
        Terminal.switch_mode! if Terminal.mode == :cooked
      end

      it 'returns the configured terminal mode' do
        Terminal.mode.must_equal(:raw)
      end
    end

    describe '.centre' do
      it 'returns the centre point on the terminal' do
        console.stub :winsize, [25, 80] do
          Terminal.centre.must_equal([12, 40])
        end
      end
    end

    describe '.centre_y' do
      it 'returns the centre `y` point on the terminal' do
        console.stub :winsize, [25, 80] do
          Terminal.centre_y.must_equal(12)
        end
      end
    end

    describe '.centre_x' do
      it 'returns the centre `x` point on the terminal' do
        console.stub :winsize, [25, 80] do
          Terminal.centre_x.must_equal(40)
        end
      end
    end

    describe '.width' do
      it 'returns the width of the terminal' do
        console.stub :winsize, [25, 80] do
          Terminal.width.must_equal(80)
        end
      end
    end

    describe '.height' do
      it 'returns the height of the terminal' do
        console.stub :winsize, [25, 80] do
          Terminal.height.must_equal(25)
        end
      end
    end

    describe '.size' do
      it 'returns the width and height of the terminal' do
        console.stub :winsize, [25, 80] do
          Terminal.size.must_equal([25, 80])
        end
      end
    end

    describe '.console' do
      it 'returns the console' do
        Terminal.console.must_equal(console)
      end
    end
  end
end
