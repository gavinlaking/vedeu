require 'test_helper'

module Vedeu
  describe Events do
    describe '#event' do
      it 'adds the event block to the handlers' do
        events = Events.new
        events.event(:sulphur) { proc { |x| x } }
        events.registered.must_equal([:sulphur])
      end
    end

    describe '#unevent' do
      it 'removes the event by name' do
        events = Events.new
        events.event(:chlorine) { proc { |x| x } }
        events.event(:argon)    { proc { |y| y } }
        events.unevent(:chlorine)
        events.registered.must_equal([:argon])
      end

      it 'removes the event by name only if the name exists' do
        events = Events.new
        events.event(:chlorine) { proc { |x| x } }
        events.event(:argon)    { proc { |y| y } }
        events.unevent(:potassium)
        events.registered.must_equal([:chlorine, :argon])
      end
    end

    describe '#registered' do
      it 'returns all the registered events by name' do
        events = Events.new do
          event(:some_event) { proc { |x| x } }
        end
        events.registered.must_equal([:some_event])
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

    describe '#reset' do
      it 'removes all events registered' do
        events = Events.new do
          event(:potassium) { proc { |x| x } }
        end
        events.reset.must_equal({})
      end
    end
  end
end
