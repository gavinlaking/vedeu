require 'test_helper'

module Vedeu

  describe Configuration do

    let(:described) { Vedeu::Configuration }

    before { Configuration.reset! }
    after  { test_configuration }

    describe '.background' do
      it 'returns the value of the background option' do
        described.background.must_equal(:default)
      end
    end

    describe '.base_path' do
      it { described.must_respond_to(:base_path) }

      it 'returns the value of the base_path option' do
        described.base_path.must_equal(Dir.pwd)
      end
    end

    describe '.compression?' do
      it { described.must_respond_to(:compression) }

      it 'returns the value of the compression option' do
        described.compression?.must_equal(true)
      end
    end

    describe '.debug?' do
      it { described.must_respond_to(:debug) }

      it 'returns the value of the debug option' do
        described.debug?.must_equal(false)
      end
    end

    describe '.drb?' do
      it { described.must_respond_to(:drb) }

      it 'returns the value of the drb option' do
        described.drb?.must_equal(false)
      end
    end

    describe '.foreground' do
      it 'returns the value of the foreground option' do
        described.foreground.must_equal(:default)
      end
    end

    describe '.interactive?' do
      it { described.must_respond_to(:interactive) }

      it 'returns the value of the interactive option' do
        described.interactive?.must_equal(true)
      end
    end

    describe '.log' do
      context 'when the log is not configured' do
        it { described.log.must_equal(nil) }
      end

      context 'when the log is configured' do
        before do
          Vedeu.configure do
            log '/tmp/vedeu.log'
          end
        end

        it { described.log.must_equal('/tmp/vedeu.log') }
      end
    end

    describe '.log?' do
      context 'when the log is not configured' do
        it { described.log?.must_equal(false) }
      end

      context 'when the log is configured' do
        before do
          Vedeu.configure do
            log '/tmp/vedeu.log'
          end
        end

        it { described.log?.must_equal(true) }
      end
    end

    describe '.log_except' do
      context 'when log_except is not configured' do
        it { described.log_except.must_equal([]) }
      end

      context 'when log_except is configured' do
        before do
          Vedeu.configure do
            log_except :timer, :event
          end
        end

        it { described.log_except.must_equal([:timer, :event]) }
      end
    end

    describe '.log_only' do
      context 'when log_only is not configured' do
        it { described.log_only.must_equal([]) }
      end

      context 'when log_only is configured' do
        before do
          Vedeu.configure do
            log_only :timer, :event
          end
        end

        it { described.log_only.must_equal([:timer, :event]) }
      end
    end

    describe '.loggable?' do
      let(:type) { :hydrogen }

      subject { described.loggable?(type) }

      context 'when the type exists in log_only and log_except' do
        before do
          described.stubs(:log_only).returns([:hydrogen])
          described.stubs(:log_except).returns([:hydrogen])
        end

        it { subject.must_equal(true) }
      end

      context 'when the type exists in log_only' do
        before do
          described.stubs(:log_only).returns([:hydrogen])
          described.stubs(:log_except).returns([])
        end

        it { subject.must_equal(true) }
      end

      context 'when the type exists in log_except' do
        before do
          described.stubs(:log_only).returns([])
          described.stubs(:log_except).returns([:hydrogen])
        end

        it { subject.must_equal(false) }
      end

      context 'when the type does not exist in either' do
        before do
          described.stubs(:log_only).returns([])
          described.stubs(:log_except).returns([])
        end

        it { subject.must_equal(true) }
      end
    end

    describe '.mouse?' do
      it { described.must_respond_to(:mouse) }

      it 'returns the value of the mouse option' do
        described.mouse?.must_equal(true)
      end
    end

    describe '.once?' do
      it { described.must_respond_to(:once) }

      it 'returns the value of the once option' do
        described.once?.must_equal(false)
      end
    end

    describe '.stdin' do
      it 'returns the value of the redefined STDIN' do
        described.stdin.must_equal(nil)
      end
    end

    describe '.stdout' do
      it 'returns the value of the redefined STDOUT' do
        described.stdout.must_equal(nil)
      end
    end

    describe '.stderr' do
      it 'returns the value of the redefined STDERR' do
        described.stderr.must_equal(nil)
      end
    end

    describe '.terminal_mode' do
      it 'returns the value of the mode option' do
        described.terminal_mode.must_equal(:raw)
      end
    end

    describe '.configure' do
      it 'returns the options configured' do
        described.configure do
          # ...
        end.must_equal(Vedeu::Configuration)
      end
    end

  end # Configuration

end # Vedeu
