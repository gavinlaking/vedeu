require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/support/events'

module Vedeu
  describe Events do
    describe '#on' do
      it 'returns an Array' do
        events = Events.new
        events.on(:some_event) { proc { |x| x } }
          .must_be_instance_of(Array)
      end
    end

    describe '#trigger' do
      it 'returns a collection containing the event when the event is pre-registered' do
        events = Events.new do
          on(:_exit_) { fail StopIteration }
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
