require 'test_helper'

module Vedeu

  describe Event do

    let(:described)  { Event.new(event_name, options, closure) }
    let(:event_name) { :some_event }
    let(:options)    { {} }
    let(:closure)    { proc { :event_triggered } }

    describe '#initialize' do
      it { return_type_for(described, Event) }
      it { assigns(described, '@name', :some_event) }
      it { assigns(described, '@options', options) }

      it { assigns(described, '@deadline', 0) }
      it { assigns(described, '@executed_at', 0) }
      it { assigns(described, '@now', 0) }
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
