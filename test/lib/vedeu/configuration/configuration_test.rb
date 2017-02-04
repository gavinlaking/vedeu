# frozen_string_literal: true

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
        it 'sends messages to the default log' do
          described.log.must_equal(Dir.tmpdir + '/vedeu_bootstrap.log')
        end
      end

      context 'when the log is configured with a filename' do
        before do
          Vedeu.configure do
            log Dir.tmpdir + '/vedeu.log'
          end
        end

        it { described.log.must_equal(Dir.tmpdir + '/vedeu.log') }
      end

      context 'when the log is configured with false' do
        before do
          Vedeu.configure do
            log false
          end
        end

        it { assert_nil(described.log) }
      end
    end

    describe '.log?' do
      context 'when the log is enabled' do
        it { described.log?.must_equal(true) }
      end

      context 'when the log is disabled' do
        before do
          Vedeu.configure do
            log false
          end
        end

        it { described.log?.must_equal(false) }
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

        it { described.log_except.must_include(:timer) }
        it { described.log_except.must_include(:event) }
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

        it { described.log_only.must_include(:timer) }
        it { described.log_only.must_include(:event) }
      end
    end

    describe '.loggable?' do
      subject { described.loggable?(type) }

      context 'when the type is invalid' do
        let(:type) { :hydrogen }

        it { subject.must_equal(false) }
      end

      context 'when the type is valid' do
        let(:type) { :debug }

        context 'when log_only and log_except are both empty' do
          it { subject.must_equal(true) }
        end

        context 'when log_only contains entries' do
          context 'when log_only includes the type' do
            before do
              Vedeu.configure do
                log_only [:info, :debug, :error]
              end
            end

            it { subject.must_equal(true) }
          end

          context 'when log_only does not include the type' do
            before do
              Vedeu.configure do
                log_only [:info, :error]
              end
            end

            it { subject.must_equal(false) }
          end
        end

        context 'when log_except contains entries' do
          context 'when log_except includes the type' do
            before do
              Vedeu.configure do
                log_except [:info, :debug, :error]
              end
            end

            it { subject.must_equal(false) }
          end

          context 'when log_except does not include the type' do
            before do
              Vedeu.configure do
                log_only [:info, :error]
              end
            end

            it { subject.must_equal(false) }
          end
        end
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
        assert_nil(described.stdin)
      end
    end

    describe '.stdout' do
      it 'returns the value of the redefined STDOUT' do
        assert_nil(described.stdout)
      end
    end

    describe '.stderr' do
      it 'returns the value of the redefined STDERR' do
        assert_nil(described.stderr)
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
