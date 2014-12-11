require 'test_helper'

module Vedeu

  describe API do

    let(:event) { mock('Event') }

    before { Event.stubs(:new).returns(event) }

    describe '.configure' do
      it 'raises an exception unless a block was given' do
        proc { Vedeu.configure }.must_raise(InvalidSyntax)
      end
    end

    describe '.defined' do
      it 'returns a reference to the API::Defined module' do
        Vedeu.defined.must_equal(Vedeu::API::Defined)
      end
    end

    describe '.focus' do
      it 'sets the named interface to be focussed' do
        Vedeu.expects(:trigger).with(:_focus_by_name_, 'plutonium')

        Vedeu.focus('plutonium')
      end
    end

    describe '.interface' do
      it 'creates and stores a new interface' do
        Vedeu::Buffers.reset

        Vedeu.interface('Vedeu.interface').must_be_instance_of(API::Interface)
      end
    end

    describe '.keypress' do
      before do
        Interfaces.reset

        Vedeu.interface('barium') {}
      end

      context 'when the key is registered' do
        before do
          Vedeu.keys do
            interface 'barium'
            key('j') { :j_pressed }
          end
        end

        it 'returns the result of proc stored for the keypress' do
          Vedeu.keypress('j').must_equal(:j_pressed)
        end
      end

      context 'when the key is not registered' do
        it 'returns false' do
          Vedeu.keypress('k').must_equal(false)
        end
      end
    end

    describe '.keys' do
      it 'returns an instance of API::Keymap' do
        Vedeu.keys do
          # ...
        end.must_be_instance_of(API::Keymap)
      end

      it 'raises an exception when the block is not provided' do
        proc { Vedeu.keys }.must_raise(InvalidSyntax)
      end
    end

    describe '.log' do
      it 'writes the message to the log file when debugging is enabled' do
        Configuration.stub(:debug?, true) do
          Vedeu.log('Testing debugging to log').must_equal(true)
        end
      end

      it 'returns nil when debugging is disabled' do
        Configuration.stub(:debug?, false) do
          Vedeu.log('some message not logged...').must_equal(nil)
        end
      end

      it 'write the message to the log file when the `force` argument ' \
         'evaluates to true' do
        Configuration.stub(:debug?, false) do
          Vedeu.log('Testing forced debugging to log', true).must_equal(true)
        end
      end
    end

    describe '.menu' do
      it 'creates and stores a new menu' do
        Vedeu.menu('Vedeu.menu') do
          # ...
        end.must_be_instance_of(API::Menu)
      end
    end

    describe '.render' do
      it 'directly writes the view buffer to the terminal' do
        skip
      end
    end

    describe '.resize' do
      before do
        Interfaces.reset
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

    describe '.unevent' do
      it 'unregister the event by name' do
        Vedeu.event(:calcium) { proc { |x| x } }
        Events.registered.must_include(:calcium)
        Vedeu.unevent(:calcium)
        Events.registered.wont_include(:calcium)
      end
    end

    describe '.use' do
      before { Vedeu::Interfaces.reset }

      it 'raises an exception if the interface has not been defined' do
        proc { Vedeu.use('unknown') }
          .must_raise(ModelNotFound)
      end

      it 'returns an instance of the named interface' do
        Vedeu.interface('aluminium')

        Vedeu.use('aluminium').must_be_instance_of(Vedeu::Interface)
      end
    end

    describe '.view' do
      let(:composition) {
        {
          interfaces: [{
            name: "some_interface",
            cursor: :hide,
            group: '',
            lines: [],
            colour: {},
            style: '',
            geometry: {},
            delay: 0.0,
            parent: {}
          }]
        }
      }

      it 'returns the view attributes for an interface (see View)' do
        Vedeu.view('some_interface').must_equal(composition)
      end
    end

    describe '.views' do
      it 'allows multiple views to be defined at once' do
        attrs = Vedeu.views do
          view 'view_1' do
            line do
              text '1. A line of text in view 1.'
              text '2. Another line of text in view 1.'
            end
          end
          view 'view_2' do
            line do
              text '1. A line of text in view 2.'
              text '2. Another line of text in view 2.'
            end
          end
        end
        attrs[:interfaces].size.must_equal(2)
      end

      it 'raises an exception if a block was not given' do
        proc { Vedeu.views }.must_raise(InvalidSyntax)
      end
    end

  end # API

end # Vedeu
