require 'test_helper'

module Vedeu

  describe Log do

    let(:described) { Vedeu::Log }
    let(:_message)  { 'Some message...' }
    let(:force)     { false }
    let(:type)      { :info }

    describe '.log' do
      subject { described.log(message: _message, force: force, type: type) }

      it { subject.must_equal(
        ["\e[97m[info]   \e[39m", "\e[39mSome message...\e[39m"]
      ) }
    end

    describe '.log_stdout' do
      let(:type)     { :create }
      let(:_message) { 'Logging to stdout...' }

      subject { described.log_stdout(type: type, message: _message) }

      it {
        capture_io { subject }.must_equal(
          ["\e[92m[create] \e[39m\e[32mLogging to stdout...\e[39m\n", ""]
        )
      }
    end

    describe '.log_stdout' do
      let(:type)     { :debug }
      let(:_message) { 'Logging to stderr...' }

      subject { described.log_stderr(type: type, message: _message) }

      it {
        capture_io { subject }.must_equal(
          ["", "\e[91m[debug]  \e[39m\e[31mLogging to stderr...\e[39m\n"]
        )
      }
    end

  end # Log

end # Vedeu
