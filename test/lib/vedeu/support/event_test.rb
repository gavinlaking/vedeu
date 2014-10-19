require 'test_helper'

module Vedeu

  describe Event do

    let(:closure) { proc { :event_triggered } }
    let(:options) { {} }

    describe '#initialize' do
      it 'returns an instance of itself' do
        Event.new(closure, options).must_be_instance_of(Event)
      end
    end

    describe '#trigger' do
      it 'returns the result of calling the closure when debouncing' do
        event = Event.new(closure, { debounce: 0.0025 })
        event.trigger.must_equal(nil)
        sleep 0.0015
        event.trigger.must_equal(nil)
        sleep 0.0015
        event.trigger.must_equal(:event_triggered)
        sleep 0.0015
        event.trigger.must_equal(nil)
      end

      it 'returns the result of calling the closure when throttling' do
        event = Event.new(closure, { delay: 0.0025 })
        event.trigger.must_equal(:event_triggered)
        sleep 0.0015
        event.trigger.must_equal(nil)
        sleep 0.0015
        event.trigger.must_equal(:event_triggered)
      end

      it 'returns the result of calling the closure with its arguments' do
        event = Event.new(closure, options)
        event.trigger.must_equal(:event_triggered)
      end
    end

  end # Event

end # Vedeu
