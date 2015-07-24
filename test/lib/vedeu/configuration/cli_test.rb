require 'test_helper'

module YourApp

  class SomeController

  end # SomeController

end # YourApp

module Vedeu

  module Config

    describe CLI do

      let(:described) { Vedeu::Config::CLI }
      let(:instance)  { described.new(args) }
      let(:args)      { [] }

      before { Configuration.reset! }
      after  { test_configuration }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@args').must_equal(args) }
        it { instance.instance_variable_get('@options').must_equal({}) }
      end

      describe '#colour_mode' do
        it '--colour-mode' do
          Configuration.configure(['--colour-mode', '16777216']) {}
          Configuration.colour_mode.must_equal(16_777_216)
        end

        it '--colour-mode' do
          Configuration.configure(['--colour-mode', '256'])
          Configuration.colour_mode.must_equal(256)
        end

        it '--colour-mode' do
          Configuration.configure(['--colour-mode', '16'])
          Configuration.colour_mode.must_equal(16)
        end

        it '--colour-mode' do
          Configuration.configure(['--colour-mode', '348'])
          Configuration.colour_mode.must_equal(8)
        end
      end

      describe '#debug?' do
        it '--debug' do
          Configuration.configure(['--debug'])
          Configuration.debug?.must_equal(true)
        end
      end

      describe '#drb' do
        it '--drb' do
          Configuration.configure(['--drb'])
          Configuration.drb?.must_equal(true)
        end
      end

      describe '#drb_height' do
        it '--drb-height' do
          Configuration.configure(['--drb-height'])
          Configuration.drb_height.must_equal(true)
        end
      end

      describe '#drb_host' do
        it '--drb-host' do
          Configuration.configure(['--drb-host'])
          Configuration.drb_host.must_equal(true)
        end
      end

      describe '#drb_port' do
        it '--drb-port' do
          Configuration.configure(['--drb-port'])
          Configuration.drb_port.must_equal(true)
        end
      end

      describe '#drb_width' do
        it '--drb-width' do
          Configuration.configure(['--drb-width'])
          Configuration.drb_width.must_equal(true)
        end
      end

      describe '#interactive?' do
        it '--interactive' do
          Configuration.configure(['--interactive'])
          Configuration.interactive?.must_equal(true)
        end

        it '--noninteractive' do
          Configuration.configure(['--noninteractive'])
          Configuration.interactive?.must_equal(false)
        end

        it '--standalone' do
          Configuration.configure(['--standalone'])
          Configuration.interactive?.must_equal(false)
        end
      end

      describe '#log' do
        it '--log' do
          Configuration.configure(['--log', '/tmp/vedeu_cli_test.log'])
          Configuration.log.must_equal('/tmp/vedeu_cli_test.log')
        end
      end

      describe '#once?' do
        it '--run-once' do
          Configuration.configure(['--run-once'])
          Configuration.once?.must_equal(true)
        end

        it '--run-many' do
          Configuration.configure(['--run-many'])
          Configuration.once?.must_equal(false)
        end
      end

      describe '#root' do
        it '--root' do
          Configuration.configure(['--root', 'YourApp::SomeController.new'])
          Configuration.root.must_equal('YourApp::SomeController.new')
        end
      end

      describe '#terminal_mode' do
        it '--cooked' do
          Configuration.configure(['--cooked'])
          Configuration.terminal_mode.must_equal(:cooked)
        end

        it '--raw' do
          Configuration.configure(['--raw'])
          Configuration.terminal_mode.must_equal(:raw)
        end
      end

    end # CLI

  end # Config

end # Vedeu
