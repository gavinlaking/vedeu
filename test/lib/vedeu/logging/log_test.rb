# frozen_string_literal: true

require 'test_helper'

module Vedeu

  describe 'Bindings' do
    it { Vedeu.bound?(:_log_).must_equal(true) }
  end

  module Logging

    describe Log do

      let(:described) { Vedeu::Logging::Log }
      let(:_message)  { 'Some message...' }
      let(:type)      { :info }

      describe '.count' do
        it { described.must_respond_to(:count) }
      end

      describe '.count=' do
        it { described.must_respond_to(:count=) }
      end

      describe '.indent' do
        context 'when the block is given' do
          subject { described.indent { :block_given } }

          it { subject.must_equal(:block_given) }
        end

        context 'when the block is not given' do
          subject { described.indent }

          it { subject.must_equal(nil) }
        end

        context 'when the indentation count > 0' do
          before { described.count = 2 }
          after  { described.count = nil }

          subject { described.indent { :block_given } }

          it { subject; described.count.must_equal(2) }
        end

        context 'when the indentation count is 0' do
          before { described.count = 0 }
          after  { described.count = nil }

          subject { described.indent { :block_given } }

          it { subject; described.count.must_equal(0) }
        end

        context 'when the indentation count < 0' do
          before { described.count = -2 }
          after  { described.count = nil }

          subject { described.indent { :block_given } }

          it { subject; described.count.must_equal(0) }
        end
      end

      describe '.log' do
        before { Vedeu.config.stubs(:log?).returns(enabled) }

        subject { described.log(message: _message, type: type) }

        context 'when the log is enabled' do
          let(:enabled)  { true }
          let(:expected) {
            "\e[97m[info]     \e[39m\e[37mSome message...\e[39m"
          }

          it { subject.must_equal(expected) }
        end

        context 'when the log is disabled' do
          let(:enabled)  { false }

          it { subject.must_equal(nil) }
        end
      end

      describe '.log_stdout' do
        let(:type)     { :create }
        let(:_message) { 'Logging to stdout...' }

        subject { described.log_stdout(type: type, message: _message) }

        it do
          capture_io { subject }.must_equal(
            ["\e[96m[create]   \e[39m\e[36mLogging to stdout...\e[39m\n", ""]
          )
        end
      end

      describe '.log_stderr' do
        let(:type)     { :debug }
        let(:_message) { 'Logging to stderr...' }

        subject { described.log_stderr(type: type, message: _message) }

        it do
          capture_io { subject }.must_equal(
            ["", "\e[97m[debug]    \e[39m\e[37mLogging to stderr...\e[39m\n"]
          )
        end
      end

      describe '.log_timestamp' do
        it { described.must_respond_to(:log_timestamp) }
      end

      describe '.outdent' do
        context 'when the block is given' do
          subject { described.outdent { :block_given } }

          it { subject.must_equal(:block_given) }
        end

        context 'when the block is not given' do
          subject { described.outdent }

          it { subject.must_equal(nil) }
        end

        context 'when the indentation count > 0' do
          before { described.count = 2 }
          after  { described.count = nil }

          subject { described.outdent { :block_given } }

          it { subject; described.count.must_equal(1) }
        end

        context 'when the indentation count is 0' do
          before { described.count = 0 }
          after  { described.count = nil }

          subject { described.outdent { :block_given } }

          it { subject; described.count.must_equal(0) }
        end

        context 'when the indentation count < 0' do
          before { described.count = -2 }
          after  { described.count = nil }

          subject { described.outdent { :block_given } }

          it { subject; described.count.must_equal(0) }
        end
      end

      describe '.timestamp' do
        subject { described.timestamp }

        # @todo Add more tests.
      end

    end # Log

  end # Logging

end # Vedeu
