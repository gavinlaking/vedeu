require 'test_helper'

module Vedeu

  module Terminal

    describe Mode do

      let(:described) { Vedeu::Terminal::Mode }

      describe '.cooked_mode?' do
        subject { described.cooked_mode? }

        it 'returns true if the terminal is in cooked mode' do
          described.cooked_mode!
          subject.must_equal(true)
        end

        it 'returns false if the terminal is not in cooked mode' do
          described.raw_mode!
          subject.must_equal(false)
        end
      end

      describe '.fake_mode?' do
        subject { described.fake_mode? }

        it 'returns true if the terminal is in fake mode' do
          described.fake_mode!
          subject.must_equal(true)
        end

        it 'returns false if the terminal is not in fake mode' do
          described.raw_mode!
          subject.must_equal(false)
        end
      end

      describe '.raw_mode?' do
        subject { described.raw_mode? }

        it 'returns true if the terminal is in raw mode' do
          described.raw_mode!
          subject.must_equal(true)
        end

        it 'returns false if the terminal is not in raw mode' do
          described.cooked_mode!
          subject.must_equal(false)
        end
      end

      describe '.switch_mode!' do
        let(:mode) {}

        subject { described.switch_mode!(mode) }

        context 'when the mode is not given' do
          it 'returns :fake if previously :raw' do
            described.raw_mode!
            subject
            Vedeu::Configuration.terminal_mode.must_equal(:fake)
          end

          it 'returns :cooked if previously :fake' do
            described.fake_mode!
            subject
            Vedeu::Configuration.terminal_mode.must_equal(:cooked)
          end

          it 'returns :raw if previously :cooked' do
            described.cooked_mode!
            subject
            Vedeu::Configuration.terminal_mode.must_equal(:raw)
          end
        end

        context 'when the mode is given' do
          let(:mode) { :cooked }

          it {
            subject
            Vedeu::Configuration.terminal_mode.must_equal(:cooked)
          }

          context 'when the mode given is not valid' do
            let(:mode) { :invalid }

            before { described.cooked_mode! }

            it {
              subject
              Vedeu::Configuration.terminal_mode.must_equal(:raw)
            }
          end
        end
      end

      describe '.mode' do
        subject { described.mode }

        before { described.raw_mode! }

        it { subject.must_be_instance_of(Symbol) }

        it 'returns the configured terminal mode' do
          subject.must_equal(:raw)
        end

        context 'when the mode has been changed' do
          before { described.fake_mode! }

          it { subject.must_equal(:fake) }
        end
      end

    end # Mode

  end # Terminal

end # Vedeu
