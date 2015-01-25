require 'test_helper'

module Vedeu

  describe Event do

    let(:described)  { Vedeu::Event }
    let(:instance)   { described.new(event_name, options, closure) }
    let(:event_name) { :some_event }
    let(:options)    { {} }
    let(:closure)    { proc { :event_triggered } }

    describe '.bind' do
      subject { described.bind(event_name, options) { :event_triggered } }

      it { return_type_for(subject, TrueClass) }
    end

    # describe '.unbind' do
    #   let(:event_name) { :chlorine }

    #   before do
    #     Vedeu.bind(:chlorine) { :some_event }
    #   end

    #   subject { instance.unbind(event_name) }

    #   context 'when the event exists' do
    #     it { return_type_for(subject, TrueClass) }
    #   end

    #   context 'when the event does not exist' do
    #     let(:event_name) { :does_not_exist }

    #     it { return_type_for(subject, FalseClass) }
    #   end
    # end

    describe '#initialize' do
      subject { instance }

      it { return_type_for(subject, Event) }
      it { subject.instance_variable_get('@name').must_equal(event_name) }
      it { subject.instance_variable_get('@options').must_equal(options) }
      # it { subject.instance_variable_get('@closure').must_equal(closure) }
      it { subject.instance_variable_get('@deadline').must_equal(0) }
      it { subject.instance_variable_get('@executed_at').must_equal(0) }
      it { subject.instance_variable_get('@now').must_equal(0) }
      it { subject.instance_variable_get('@repository').must_equal(Vedeu.events) }
    end

    describe '#bind' do
      subject { instance.bind }

      context 'when the event name is already registered' do
        before { Vedeu.bind(:some_event) { :already_registered } }

        it { return_type_for(subject, TrueClass) }
      end

      context 'when the event name is not already registered' do
        it { return_type_for(subject, TrueClass) }
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

    describe '#unbind' do
      context 'when the event exists' do
        before do
          Vedeu.bind(:gallium) { :some_action }
        end

        it { Vedeu.unbind(:gallium).must_equal(true) }
      end

      context 'when the event does not exist' do
        it { Vedeu.unbind(:gallium).must_equal(false) }
      end
    end

  end # Event

end # Vedeu
