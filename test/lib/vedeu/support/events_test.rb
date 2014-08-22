require 'test_helper'

module Vedeu
  describe Events do
    describe '#event' do
      it 'adds the event block to the handlers' do
        skip
        events = Events.new
        events.event(:some_event) { proc { |x| x } }
      end

      it 'adds the specified throttle to the throttles' do
        skip
        events = Events.new
        events.event(:some_event, 250) { proc { |x| x } }
      end
    end

    describe '#trigger' do
      it 'returns a collection containing the event when the event is ' \
         'pre-registered' do
        events = Events.new do
          event(:_exit_) { fail StopIteration }
        end
        proc { events.trigger(:_exit_) }.must_raise(StopIteration)
      end

      it 'returns an empty collection when the event has not been registered' do
        events = Events.new
        events.trigger(:_not_found_).must_be_empty
      end
    end
  end
end
