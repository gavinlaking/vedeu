require 'test_helper'

module Vedeu

  describe Terminal do

    let(:described) { Vedeu::Terminal }
    let(:console)   { IO.console }

    before do
      console.stubs(:winsize).returns([25, 80])
      console.stubs(:print)
    end

    describe '.open' do
      context 'when a block was not given' do
        it {
          proc { Vedeu::Terminal.open }.must_raise(Vedeu::Error::RequiresBlock)
        }
      end

      it 'opens a new terminal console in raw mode' do
        Vedeu::Configuration.stub(:terminal_mode, :raw) do
          capture_io do
            Vedeu::Terminal.open do
              print 'Hello from raw mode!'
            end
          end.must_equal(['Hello from raw mode!', ''])
        end
      end

      it 'opens a new terminal console in cooked mode' do
        Vedeu::Configuration.stub(:terminal_mode, :cooked) do
          capture_io do
            Vedeu::Terminal.open do
              print 'Hello from cooked mode!'
            end
          end.must_equal(['Hello from cooked mode!', ''])
        end
      end
    end

    describe '.input' do
      subject { Vedeu::Terminal.input }

      it { described.must_respond_to(:read) }

      context 'when the terminal is in cooked mode' do
        let(:mode)  { :cooked }
        let(:input) { "Some input\r\n" }

        before do
          Vedeu::Terminal.stubs(:mode).returns(mode)
          console.stubs(:gets).returns(input)
        end

        it { subject.must_equal('Some input') }
      end

      # context 'when the terminal is in raw mode' do
      #   let(:mode)  { :raw }
      #   let(:input) { "\e[A" }

      #   before do
      #     Vedeu::Terminal.stubs(:mode).returns(mode)
      #     # console.stubs(:getch).returns(input)
      #     # input.stubs(:ord).returns(27)
      #     # console.stubs(:read_nonblock)
      #   end

      #   it { subject.must_be_instance_of(Symbol) }
      # end
    end

    describe '.output' do
      before { IO.console.stubs(:print) }

      subject { described.output(*_value) }

      it { described.must_respond_to(:write) }

      context 'when the value is a String' do
        let(:_value) { 'Some output...' }

        it { subject.must_equal(['Some output...']) }
      end

      context 'when there are multiple values' do
        let(:_value) { ['Some output...', 'more output...', 'even more...'] }

        it { subject.must_equal(['Some output...',
                                 'more output...',
                                 'even more...']) }
      end
    end

    describe '.resize' do
      subject { described.resize }

      it { subject.must_be_instance_of(TrueClass) }
    end

    describe '.clear' do
      subject { described.clear }

      it 'clears the screen' do
        subject.must_equal(["\e[39m\e[49m\e[2J"])
      end
    end

    describe '.set_cursor_mode' do
      subject { described.set_cursor_mode }

      it 'shows the cursor in cooked mode' do
        described.cooked_mode!
        subject.must_equal(["\e[?25h"])
      end

      it 'hides the cursor in raw mode' do
        described.raw_mode!
        subject.must_equal(nil)
      end
    end


    describe '.cursor' do
      subject { described.cursor }

      #it { subject.must_be_instance_of(Array) }
      #it { subject.must_be_instance_of(Vedeu::Geometry::Position) }
    end

    describe '.centre' do
      subject { described.centre }

      it { subject.must_be_instance_of(Array) }

      it 'returns the centre point on the terminal' do
        subject.must_equal([12, 40])
      end
    end

    describe '.centre_y' do
      subject { described.centre_y }

      it { subject.must_be_instance_of(Fixnum) }

      it 'returns the centre `y` point on the terminal' do
        subject.must_equal(12)
      end
    end

    describe '.centre_x' do
      subject { described.centre_x }

      it { subject.must_be_instance_of(Fixnum) }

      it 'returns the centre `x` point on the terminal' do
        subject.must_equal(40)
      end
    end

    describe '.origin' do
      subject { Vedeu::Terminal.origin }

      it { subject.must_be_instance_of(Fixnum) }
      it { subject.must_equal(1) }
      it { described.must_respond_to(:x) }
      it { described.must_respond_to(:y) }
      it { described.must_respond_to(:tx) }
      it { described.must_respond_to(:ty) }
    end

    describe '.width' do
      subject { Vedeu::Terminal.width }

      it { subject.must_be_instance_of(Fixnum) }
      it { described.must_respond_to(:xn) }
      it { described.must_respond_to(:txn) }

      context 'via method' do
        it 'returns the width' do
          subject.must_equal(80)
        end
      end

      context 'via API' do
        it 'returns the width' do
          Vedeu.width.must_equal(80)
        end
      end
    end

    describe '.height' do
      subject { Vedeu::Terminal.height }

      it { subject.must_be_instance_of(Fixnum) }
      it { described.must_respond_to(:yn) }
      it { described.must_respond_to(:tyn) }

      context 'via method' do
        it 'returns the height' do
          subject.must_equal(24)
        end
      end

      context 'via API' do
        it 'returns the height' do
          Vedeu.height.must_equal(24)
        end
      end
    end

    describe '.size' do
      subject { Vedeu::Terminal.size }

      it { subject.must_be_instance_of(Array) }

      it 'returns the width and height' do
        subject.must_equal([24, 80])
      end
    end

    describe '.console' do
      it 'returns the console' do
        Vedeu::Terminal.console.must_equal(console)
      end
    end

  end # Terminal

end # Vedeu
