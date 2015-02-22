require 'test_helper'

module Vedeu

  describe API do

    let(:event) { mock('Event') }

    before { Event.stubs(:new).returns(event) }

    # describe '.focus' do
    #   it 'sets the named interface to be focussed' do
    #     Interface.build({ name: 'plutonium' }).store

    #     Vedeu.expects(:trigger).with(:_focus_by_name_, 'plutonium')

    #     Vedeu.focus('plutonium')
    #   end

    #   context 'when the interface is not registered' do
    #     it { proc { Vedeu.focus('plutonium') }.must_raise(ModelNotFound) }
    #   end
    # end



    # describe '.keypress' do
    #   before do
    #     Interfaces.reset

    #     Vedeu.interface('barium') {}
    #   end

    #   context 'when the key is registered' do
    #     before do
    #       Vedeu.keys do
    #         interface 'barium'
    #         key('j') { :j_pressed }
    #       end
    #     end

    #     it 'returns the result of proc stored for the keypress' do
    #       Vedeu.keypress('j').must_equal(:j_pressed)
    #     end
    #   end

    #   context 'when the key is not registered' do
    #     it 'returns false' do
    #       Vedeu.keypress('k').must_equal(false)
    #     end
    #   end
    # end

    # describe '.keys' do
    #   context 'when a block was not given' do
    #     subject { Vedeu.keys }

    #     it { proc { subject }.must_raise(InvalidSyntax) }
    #   end

    #   context 'when a block was given' do
    #     subject { Vedeu.keys { :some_dsl_methods } }

    #     it { subject.must_be_instance_of(Vedeu::Keymap) }
    #   end
    # end

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

    # describe '.unbind' do
    #   it 'unregister the event by name' do
    #     Vedeu.bind(:calcium) { proc { |x| x } }
    #     Vedeu.events.registered.must_include(:calcium)

    #     Vedeu.unbind(:calcium)
    #     Vedeu.events.registered.wont_include(:calcium)
    #   end
    # end

    # describe '.view' do
    #   subject { Vedeu.view('holmium') }

    #   it { subject.must_be_instance_of(Hash) }
    # end

    # describe '.views' do
    #   it 'allows multiple views to be defined at once' do
    #     attrs = Vedeu.views do
    #       view 'view_1' do
    #         lines do
    #           text '1. A line of text in view 1.'
    #           text '2. Another line of text in view 1.'
    #         end
    #       end
    #       view 'view_2' do
    #         lines do
    #           text '1. A line of text in view 2.'
    #           text '2. Another line of text in view 2.'
    #         end
    #       end
    #     end
    #     attrs[:interfaces].size.must_equal(2)
    #   end

    #   context 'when a block was not given' do
    #     it { proc { Vedeu.views }.must_raise(InvalidSyntax) }
    #   end
    # end

  end # API

end # Vedeu
