# frozen_string_literal: true

require 'test_helper'

module Vedeu

  describe Launcher do

    let(:described) { Vedeu::Launcher }
    let(:instance)  { described.new }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@argv').must_equal([]) }
      it { instance.instance_variable_get('@stdin').must_equal(STDIN) }
      it { instance.instance_variable_get('@stdout').must_equal(STDOUT) }
      it { instance.instance_variable_get('@stderr').must_equal(STDERR) }
      it { instance.instance_variable_get('@kernel').must_equal(Kernel) }
      it { instance.instance_variable_get('@exit_code').must_equal(1) }
    end

    describe '#exit_code' do
      it { instance.must_respond_to(:exit_code) }
    end

    describe '#debug_execute!' do
      subject { instance.debug_execute! }

      context 'when debugging is enabled in the configuration' do
        # @todo Add more tests.
        # it { skip }
      end

      context 'when debugging is not enabled in the configuration' do
        # @todo Add more tests.
        # it { skip }
      end
    end

    describe '#execute!' do
      before do
        Vedeu::Runtime::Application.stubs(:start)
        Kernel.stubs(:exit)
        Kernel.stubs(:puts)
      end

      subject { instance.execute! }

      it 'returns 0 for successful execution' do
        subject
        instance.exit_code.must_equal(0)
      end

      context 'when an uncaught exception occurs' do
        before do
          Vedeu::Runtime::Application.
            stubs(:start).
            raises(StandardError, 'Oops!')
          Vedeu.config.stubs(:debug?).returns(debug)
        end

        context 'but debugging is disabled' do
          let(:debug) { false }

          before { Vedeu.stubs(:log_stderr).with(message: "Oops!\n") }

          it do
            Vedeu.expects(:log_stderr).with(message: "Oops!\n")
            subject
          end
        end

        context 'and debugging is enabled' do
          let(:debug) { true }

          # @todo Need to stub a backtrace.
          # it do
          #   Vedeu.expects(:log_stderr).with(message: "Oops!\n")
          #   subject
          # end
        end
      end
    end

  end # Launcher

end # Vedeu
