# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Events

    describe Event do

      let(:described)  { Vedeu::Events::Event }
      let(:instance)   { described.new(event_name, closure, options) }
      let(:event_name) { :some_event }
      let(:closure)    { proc { :event_triggered } }
      let(:options)    { {} }

      describe '.bind' do
        before { Vedeu.stubs(:log) }

        subject { described.bind(event_name, options) { :event_triggered } }

        it { described.must_respond_to(:event) }
        it { described.must_respond_to(:register) }
        it { subject.must_be_instance_of(TrueClass) }
      end

      describe '.bound?' do
        subject { described.bound?(event_name) }

        context 'when the event is registered' do
          before { Vedeu.bind(event_name) }
          after  { Vedeu.unbind(event_name) }

          it { subject.must_equal(true) }
        end

        context 'when the event is not registered' do
          before { Vedeu.unbind(event_name) }

          it { subject.must_equal(false) }
        end
      end

      describe '.unbind' do
        it { described.must_respond_to(:unbind ) }
      end

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@name').must_equal(event_name) }
        it { instance.instance_variable_get('@options').must_equal(options) }
        it { instance.instance_variable_get('@deadline').must_equal(0) }
        it { instance.instance_variable_get('@executed_at').must_equal(0) }
        it { instance.instance_variable_get('@now').must_equal(0) }
        it do
          instance.instance_variable_get('@repository').must_equal(Vedeu.events)
        end
      end

      describe '#bind' do
        subject { instance.bind }

        context 'when the event name is already registered' do
          before { Vedeu.bind(:some_event) { :already_registered } }

          it { subject.must_be_instance_of(TrueClass) }
        end

        context 'when the event name is not already registered' do
          it { subject.must_be_instance_of(TrueClass) }
        end
      end

      describe '#trigger' do
        it 'returns the result of calling the closure when debouncing' do
          event = described.new(event_name, closure, { debounce: 0.001 })
          assert_nil(event.trigger)
          sleep 0.0005
          assert_nil(event.trigger)
          sleep 0.0009
          event.trigger.must_equal(:event_triggered)
          sleep 0.0001
          assert_nil(event.trigger)
        end

        it 'returns the result of calling the closure when throttling' do
          event = described.new(event_name, closure, { delay: 0.001 })
          event.trigger.must_equal(:event_triggered)
          sleep 0.0005
          assert_nil(event.trigger)
          sleep 0.0005
          event.trigger.must_equal(:event_triggered)
        end

        it 'returns the result of calling the closure with its arguments' do
          event = described.new(event_name, closure, options)
          event.trigger.must_equal(:event_triggered)
        end
      end

      describe '#unbind' do
        before { Vedeu.stubs(:log) }

        context 'when the event exists' do
          before { Vedeu.bind(:gallium) { :some_action } }

          it { Vedeu.unbind(:gallium).must_equal(true) }
        end

        context 'when the event does not exist' do
          it { Vedeu.unbind(:gallium).must_equal(false) }
        end
      end

    end # Event

  end # Events

end # Vedeu
