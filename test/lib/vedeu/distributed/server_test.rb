# frozen_string_literal: true

require 'test_helper'

module Vedeu

  describe 'Bindings' do
    it { Vedeu.bound?(:_drb_restart_).must_equal(true) }
    it { Vedeu.bound?(:_drb_start_).must_equal(true) }
    it { Vedeu.bound?(:_drb_status_).must_equal(true) }
    it { Vedeu.bound?(:_drb_stop_).must_equal(true) }
  end

  module Distributed

    describe Server do

      let(:described)     { Vedeu::Distributed::Server }
      let(:instance)      { described.instance }
      let(:configuration) {}
      let(:enabled)       { false }
      let(:running)       { false }

      before do
        Vedeu.stubs(:log)
        Vedeu.config.stubs(:drb?).returns(enabled)
        DRb.stubs(:thread).returns(running)
      end

      describe '.input' do
        let(:data) {}
        let(:type) { :keypress }

        subject { described.input(data, type) }

        it { Vedeu.expects(:trigger).with(:_drb_input_, nil, :keypress); subject }
      end

      describe '.output' do
        subject { described.output }

        it { Vedeu.expects(:trigger).with(:_drb_retrieve_output_); subject }
      end

      describe '.restart' do
        subject { described.restart }

        # @todo Add more tests.
        # it { skip }
        # it { subject.must_be_instance_of(NilClass) }
        context 'when the server is not enabled' do
          it { subject.must_equal(:drb_not_enabled) }
        end

        context 'when the server is enabled' do
          before { Vedeu.config.stubs(:drb?).returns(true) }

          context 'and the server is running' do
            before { DRb.stubs(:thread).returns(true) }

            # @todo Add more tests.
            # it { subject.must_equal(:running) }
            # it { skip }
          end

          context 'and the server is not running' do
            before { DRb.stubs(:thread).returns(false) }

            # @todo Add more tests.
            # it { subject.must_equal(:stopped) }
            # it { skip }
          end

        end
      end

      describe '.shutdown' do
        subject { described.shutdown }

        context 'when the server is not enabled' do
          it { subject.must_equal(:drb_not_enabled) }
        end

        context 'when the server is enabled' do
          let(:enabled) { true }

          before { Vedeu::Terminal.stubs(:restore_screen) }

          context 'and the server is running' do
            # @todo Add more tests.
            # it { subject.must_equal(:running) }
            # it { skip }
          end

          context 'and the server is not running' do
            # @todo Add more tests.
            # it { subject.must_equal(:stopped) }
            # it { skip }
          end

          it { Vedeu.expects(:trigger).with(:_exit_); subject }
        end
      end

      describe '.start' do
        subject { described.start }

        context 'when the server is not enabled' do
          it { subject.must_equal(:drb_not_enabled) }
        end

        context 'when the server is enabled' do
          let(:enabled) { true }

          context 'and the server is running' do
            let(:running) { true }

            it do
              Vedeu.expects(:log).
                with(type:    :drb,
                     message: "Attempting to start: 'druby://localhost:21420'")
              Vedeu.expects(:log).
                with(type:    :drb,
                     message: "Already started: 'druby://localhost:21420'")
              subject
            end
          end

          context 'and the server is not running' do
            it do
              Vedeu.expects(:log).
                with(type:    :drb,
                     message: "Attempting to start: 'druby://localhost:21420'")
              Vedeu.expects(:log).
                with(type:    :drb,
                     message: "Starting: 'druby://localhost:21420'")
              subject
            end
          end

        end
      end

      describe '.status' do
        subject { described.status }

        context 'when the server is not enabled' do
          it { subject.must_equal(:drb_not_enabled) }
        end

        context 'when the server is enabled' do
          let(:enabled) { true }

          context 'and the server is running' do
            let(:running) { true }

            it { subject.must_equal(:running) }
          end

          context 'and the server is not running' do
            it { subject.must_equal(:stopped) }
          end
        end
      end

      describe '.stop' do
        subject { described.stop }

        context 'when the server is not enabled' do
          it { subject.must_equal(:drb_not_enabled) }
        end

        context 'when the server is enabled' do
          let(:enabled) { true }

          context 'and the server is running' do
            let(:running) { true }

            it do
              Vedeu.expects(:log).
                with(type:    :drb,
                     message: "Attempting to stop: 'druby://localhost:21420'")
              Vedeu.expects(:log).
                with(type:    :drb,
                     message: "Stopping: 'druby://localhost:21420'")
              Vedeu.expects(:log).
                with(type:    :drb,
                     message: "Attempted to #join on DRb.thread.")
              subject
            end
          end

          context 'and the server is not running' do
            it do
              Vedeu.expects(:log).
                with(type:    :drb,
                     message: "Attempting to stop: 'druby://localhost:21420'")
              Vedeu.expects(:log).
                with(type:    :drb,
                     message: "Already stopped: 'druby://localhost:21420'")
              subject
            end
          end

        end
      end

      describe '#input' do
        it { instance.must_respond_to(:input) }
      end

      describe '#read' do
        it { instance.must_respond_to(:read) }
      end

      describe '#output' do
        it { instance.must_respond_to(:output) }
      end

      describe '#write' do
        it { instance.must_respond_to(:write) }
      end

      describe '#pid' do
        before { Process.stubs(:pid).returns(9876) }

        subject { instance.pid }

        it { subject.class < Integer }
        it { subject.must_equal(9876) }
      end

      describe '#restart' do
        it { instance.must_respond_to(:restart) }
      end

      describe '#shutdown' do
        it { instance.must_respond_to(:shutdown) }
      end

      describe '#start' do
        it { instance.must_respond_to(:start) }
      end

      describe '#status' do
        it { instance.must_respond_to(:status) }
      end

      describe '#stop' do
        it { instance.must_respond_to(:stop) }
      end

    end # Server

  end # Distributed

end # Vedeu
