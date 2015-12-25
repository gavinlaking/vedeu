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
      let(:force)     { false }
      let(:type)      { :info }

      describe '.log' do
        subject { described.log(message: _message, force: force, type: type) }

        it { subject.must_equal(
          "\e[97m[info]     \e[39m\e[37mSome message...\e[39m"
        ) }
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

      describe '.log_stdout' do
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
