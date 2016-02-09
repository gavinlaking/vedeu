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

    end # Log

  end # Logging

end # Vedeu
