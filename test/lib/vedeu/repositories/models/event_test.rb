require 'test_helper'

module Vedeu

  describe Event do

    let(:event_name) { :some_event }
    let(:options)    { {} }
    let(:closure)    { proc { :event_triggered } }


    describe '#initialize' do
      it 'returns an instance of itself' do
        Event.new(event_name, options, closure).must_be_instance_of(Event)
      end
    end

    describe '#trigger' do
      it 'returns the result of calling the closure when debouncing' do
        event = Event.new(event_name, { debounce: 0.0025 }, closure)
        event.trigger.must_equal(nil)
        sleep 0.0015
        event.trigger.must_equal(nil)
        sleep 0.0015
        event.trigger.must_equal(:event_triggered)
        sleep 0.0015
        event.trigger.must_equal(nil)
      end

      it 'returns the result of calling the closure when throttling' do
        event = Event.new(event_name, { delay: 0.0025 }, closure)
        event.trigger.must_equal(:event_triggered)
        sleep 0.0015
        event.trigger.must_equal(nil)
        sleep 0.0015
        event.trigger.must_equal(:event_triggered)
      end

      it 'returns the result of calling the closure with its arguments' do
        event = Event.new(event_name, options, closure)
        event.trigger.must_equal(:event_triggered)
      end
    end

  end # Event

end # Vedeu
