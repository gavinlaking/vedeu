require 'test_helper'

module Vedeu

  describe Log do

    let(:described) { Vedeu::Log }
    let(:_message) {}
    let(:force) {}
    let(:type) {}

    describe '.log' do
      subject { described.log(message: _message, force: force, type: type) }

      context 'when logging has been forced' do
        # it { skip }
      end

      context 'when logging has not been forced' do
        context 'when the configuration requests logging' do
          # it { skip }
        end

        context 'when the configuration does not request logging' do
          # it { skip }
        end
      end
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

    describe '.logger' do
      subject { described.logger }

      # it { skip }
    end

  end # Log

end # Vedeu
