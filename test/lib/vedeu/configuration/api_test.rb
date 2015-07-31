require 'test_helper'

module YourApp

  class SomeController
  end # SomeController

end # YourApp

module Vedeu

  module Config

    describe API do

      let(:described) { Vedeu::Config::API }
      let(:instance)  { described.new }

      after  { test_configuration }

      describe '#base_path' do
        it 'sets the option to the desired value' do
          configuration = Vedeu.configure { base_path 'somewhere' }
          configuration.base_path.must_equal('somewhere')
        end
      end

      describe '.configure' do
        it 'returns the configuration singleton' do
          Vedeu.configure do
            # ...
          end.must_equal(Vedeu::Configuration)
        end
      end

      describe '#interactive!' do
        it { instance.must_respond_to(:interactive) }

        it 'sets the option to the desired value' do
          configuration = Vedeu.configure { interactive! }
          configuration.interactive?.must_equal(true)
        end

        it 'sets the option to the desired value' do
          configuration = Vedeu.configure { interactive(false) }
          configuration.interactive?.must_equal(false)
        end

        it 'sets the option to the desired value' do
          configuration = Vedeu.configure { interactive(true) }
          configuration.interactive?.must_equal(true)
        end

        it 'sets the option to the desired value' do
          configuration = Vedeu.configure { interactive }
          configuration.interactive?.must_equal(true)
        end
      end

      describe '#standalone!' do
        it { instance.must_respond_to(:standalone) }

        it 'sets the option to the desired value' do
          configuration = Vedeu.configure { standalone! }
          configuration.interactive?.must_equal(false)
        end

        it 'sets the option to the desired value' do
          configuration = Vedeu.configure { standalone(false) }
          configuration.interactive?.must_equal(true)
        end

        it 'sets the option to the desired value' do
          configuration = Vedeu.configure { standalone(true) }
          configuration.interactive?.must_equal(false)
        end

        it 'sets the option to the desired value' do
          configuration = Vedeu.configure { standalone }
          configuration.interactive?.must_equal(false)
        end
      end

      describe '#run_once!' do
        it { instance.must_respond_to(:run_once) }

        it 'sets the option to the desired value' do
          configuration = Vedeu.configure { run_once! }
          configuration.once.must_equal(true)
        end

        it 'sets the option to the desired value' do
          configuration = Vedeu.configure { run_once(false) }
          configuration.once.must_equal(false)
        end

        it 'sets the option to the desired value' do
          configuration = Vedeu.configure { run_once(true) }
          configuration.once.must_equal(true)
        end

        it 'sets the option to the desired value' do
          configuration = Vedeu.configure { run_once }
          configuration.once.must_equal(true)
        end
      end

      describe '#drb!' do
        it { instance.must_respond_to(:drb) }

        it 'sets the option to the desired value' do
          configuration = Vedeu.configure { drb! }
          configuration.drb.must_equal(true)
        end

        it 'sets the option to the desired value' do
          configuration = Vedeu.configure { drb(false) }
          configuration.drb.must_equal(false)
        end

        it 'sets the option to the desired value' do
          configuration = Vedeu.configure { drb(true) }
          configuration.drb.must_equal(true)
        end

        it 'sets the option to the desired value' do
          configuration = Vedeu.configure { drb }
          configuration.drb.must_equal(true)
        end
      end

      describe '#drb_host' do
        it 'sets the options to the desired value' do
          configuration = Vedeu.configure { drb_host('localhost') }
          configuration.drb_host.must_equal('localhost')
        end
      end

      describe '#drb_port' do
        it 'sets the options to the desired value' do
          configuration = Vedeu.configure { drb_port('12345') }
          configuration.drb_port.must_equal('12345')
        end
      end

      describe '#drb_height' do
        it 'sets the options to the desired value' do
          configuration = Vedeu.configure { drb_height(15) }
          configuration.drb_height.must_equal(15)
        end
      end

      describe '#drb_width' do
        it 'sets the options to the desired value' do
          configuration = Vedeu.configure { drb_width(40) }
          configuration.drb_width.must_equal(40)
        end
      end

      describe '#cooked!' do
        it { instance.must_respond_to(:cooked) }

        it 'sets the option to the desired value' do
          configuration = Vedeu.configure { cooked! }
          configuration.terminal_mode.must_equal(:cooked)
        end
      end

      describe '#raw!' do
        subject { Vedeu.configure { raw! } }

        it { instance.must_respond_to(:raw) }

        it 'sets the option to the desired value' do
          subject.terminal_mode.must_equal(:raw)
        end
      end

      describe '#debug!' do
        it { instance.must_respond_to(:debug) }

        it 'sets the option to the desired value' do
          configuration = Vedeu.configure { debug! }
          configuration.debug.must_equal(true)
        end

        it 'sets the option to the desired value' do
          configuration = Vedeu.configure { debug(true) }
          configuration.debug.must_equal(true)
        end

        it 'sets the option to the desired value' do
          configuration = Vedeu.configure { debug(false) }
          configuration.debug.must_equal(false)
        end
      end

      describe '#colour_mode' do
        context 'when the value is invalid (nil)' do
          it { proc {
            Vedeu.configure { colour_mode(nil) }
          }.must_raise(InvalidSyntax) }
        end

        context 'when the value is invalid (empty)' do
          it { proc {
            Vedeu.configure { colour_mode('') }
          }.must_raise(InvalidSyntax) }
        end

        context 'when the value is invalid' do
          it { proc {
            Vedeu.configure { colour_mode(1234) }
          }.must_raise(InvalidSyntax) }
        end

        it 'sets the option to the desired value' do
          configuration = Vedeu.configure { colour_mode(256) }
          configuration.colour_mode.must_equal(256)
        end
      end

      describe '#log' do
        it 'sets the options to the desired value' do
          configuration = Vedeu.configure { log('/tmp/vedeu_api_test.log') }
          configuration.log.must_equal('/tmp/vedeu_api_test.log')
        end
      end

      describe '#log_only' do
        it 'sets the options to the desired value' do
          configuration = Vedeu.configure { log_only :debug, :store }
          configuration.log_only.must_equal([:debug, :store])
        end
      end

      describe '#renderer' do
        it { instance.must_respond_to(:renderers) }
      end

      describe '#root' do
        it 'sets the options to the desired value' do
          configuration = Vedeu.configure { root(::YourApp::SomeController.new) }
          configuration.root.must_be_instance_of(YourApp::SomeController)
        end
      end

      describe '#stdin' do
        let(:io) {}

        subject { instance.stdin(io) }

        # @todo Add more tests.
        # it { skip }
      end

      describe '#stdout' do
        let(:io) {}

        subject { instance.stdout(io) }

        # @todo Add more tests.
        # it { skip }
      end

      describe '#stderr' do
        let(:io) {}

        subject { instance.stderr(io) }

        # @todo Add more tests.
        # it { skip }
      end

      describe '#compression!' do
        it { instance.must_respond_to(:compression) }

        it 'sets the option to the desired value' do
          configuration = Vedeu.configure { compression! }
          configuration.compression.must_equal(true)
        end

        it 'sets the option to the desired value' do
          configuration = Vedeu.configure { compression(true) }
          configuration.compression.must_equal(true)
        end

        it 'sets the option to the desired value' do
          configuration = Vedeu.configure { compression(false) }
          configuration.compression.must_equal(false)
        end
      end

      describe '#terminal_mode' do
        context 'when setting to :raw mode' do
          it {
            configuration = Vedeu.configure { terminal_mode(:raw) }
            configuration.terminal_mode.must_equal(:raw)
          }
        end

        context 'when setting to :cooked mode' do
          it {
            configuration = Vedeu.configure { terminal_mode(:raw) }
            configuration.terminal_mode.must_equal(:raw)
          }
        end

        context 'when setting to an invalid mode' do
          it {
            proc {
              Vedeu.configure { terminal_mode(:invalid) }
            }.must_raise(Vedeu::InvalidSyntax)
          }
        end
      end

    end # API

  end # Config

end # Vedeu
