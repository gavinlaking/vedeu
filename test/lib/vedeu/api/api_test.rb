require 'test_helper'

module Vedeu
  describe API do
    let(:event) { mock('Event') }

    before { Event.stubs(:new).returns(event) }

    describe '.event' do
      it 'registers and returns the event' do
        Vedeu.event(:some_event).must_equal(
          {
            events: [event],
          }
        )
      end
    end

    describe '.events' do
      it 'should not be visible to the client' do
        skip
      end

      it 'returns the Events singleton' do
        Vedeu.events.must_be_instance_of(Vedeu::Events)
      end
    end

    describe '.height' do
      it 'returns the terminal height' do
        IO.console.stub(:winsize, [24, 40]) do
          Vedeu.height.must_equal(24)
        end
      end
    end

    describe '.interface' do
      it 'creates and stores a new interface' do
        Vedeu::Buffers.reset

        Vedeu.interface('Vedeu.interface').must_equal(true)
      end
    end

    describe '.keypress' do
      before { event.stubs(:trigger).returns(nil) }

      it 'returns nil' do
        skip
        Vedeu.keypress('k').must_equal(nil)
      end
    end

    describe '.log' do
      it 'returns true after writing the message to the log' do
        Vedeu.log('some message').must_equal(true)
      end
    end

    describe '.trigger' do
      it 'triggers the specifed event and returns the collection of events' \
         ' which this trigger triggers' do
        Vedeu.trigger(:vedeu_trigger_event, :event_arguments).must_equal([])
      end
    end

    describe '.use' do
      it 'raises an exception if the interface has not been defined' do
        Vedeu::Buffers.reset

        proc { Vedeu.use('some_interface') }.must_raise(Vedeu::EntityNotFound)
      end

      it 'returns' do
        Vedeu.interface('some_interface')

        Vedeu.use('some_interface').must_be_instance_of(Vedeu::Interface)
      end
    end

    describe '.view' do
      it 'returns the view attributes for an interface (see View)' do
        Vedeu.view('some_interface').must_equal(
          { interfaces: [{
            name: "some_interface",
            group: "",
            lines: [],
            colour: {},
            style: "",
            geometry: {},
            cursor: true,
            delay: 0.0
          }] }
        )
      end
    end

    describe '.views' do
      it 'returns the view attributes for a composition (a collection of ' \
         'interfaces)' do
        Vedeu.views do
          view 'osmium'
          view 'iridium'
        end.must_equal(
          {
            interfaces: [
              {
                name: "osmium",
                group: "",
                lines: [],
                colour: {},
                style: "",
                geometry: {},
                cursor: true,
                delay: 0.0
              }, {
                name: "iridium",
                group: "",
                lines: [],
                colour: {},
                style: "",
                geometry: {},
                cursor: true,
                delay: 0.0
              }
            ]
          }
        )
      end
    end

    describe '.width' do
      it 'returns the terminal width' do
        IO.console.stub(:winsize, [24, 40]) do
          Vedeu.width.must_equal(40)
        end
      end
    end
  end
end
