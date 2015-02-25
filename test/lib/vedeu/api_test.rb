require 'test_helper'

module Vedeu

  describe API do

    describe '.log' do
      it 'writes the message to the log file when debugging is enabled' do
        Configuration.stub(:debug?, true) do
          Vedeu.log(type: :test, message: 'Testing debugging to log').must_equal(true)
        end
      end

      it 'returns nil when debugging is disabled' do
        Configuration.stub(:debug?, false) do
          Vedeu.log(type: :test, message: 'some message not logged...').must_equal(nil)
        end
      end

      it 'write the message to the log file when the `force` argument ' \
         'evaluates to true' do
        Configuration.stub(:debug?, false) do
          Vedeu.log(type: :test, message: 'Testing forced debugging to log', force: true).must_equal(true)
        end
      end
    end

    describe '.menu' do
      it 'creates and stores a new menu' do
        Vedeu.menu('Vedeu.menu') do
          # ...
        end.must_be_instance_of(Vedeu::Menu)
      end
    end

    describe '.menus' do
      it 'accesses the menus repository' do
        Vedeu.menus.must_be_instance_of(Vedeu::Menus)
      end
    end

    describe '.resize' do
      before do
        Vedeu.interfaces.reset
        Terminal.console.stubs(:print)
      end

      it 'returns a TrueClass' do
        Vedeu.resize.must_be_instance_of(TrueClass)
      end
    end

    describe '.trigger' do
      it 'triggers the specifed event and returns the collection of events' \
         ' which this trigger triggers' do
        Vedeu.trigger(:vedeu_trigger_event, :event_arguments).must_equal([])
      end
    end

  end # API

end # Vedeu
