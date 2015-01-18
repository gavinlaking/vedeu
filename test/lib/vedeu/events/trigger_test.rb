require 'test_helper'

module Vedeu

  describe Trigger do

    let(:described)  { Vedeu::Trigger }
    let(:instance)   { described.new(event_name, args) }
    let(:event_name) { :_testing_event_ }
    let(:args)       {}

    describe '.trigger' do
      before { Vedeu.bind(event_name) { :_only_one_result_ } }

      subject { described.trigger(event_name) }

      it { return_value_for(subject, :_only_one_result_) }
    end

    describe '#initialize' do
      subject { instance }

      it { return_type_for(subject, Vedeu::Trigger) }
      it { assigns(subject, '@name', event_name) }
      it { assigns(subject, '@args', [args]) }
      it { assigns(subject, '@repository', Vedeu.events) }
    end

    describe '#trigger' do
      subject { instance.trigger }

      context 'when only one result occurs from triggering the event' do
        let(:event_name) { :_one_result_ }

        before { Vedeu.bind(event_name) { :_only_one_result_ } }

        it { return_value_for(subject, :_only_one_result_) }
      end

      context 'when multiple results occur from triggering an event' do
        let(:event_name) { :_multiple_results_ }

        before do
          Vedeu::Event.register(event_name) { :_result_one_ }
          Vedeu::Event.register(event_name) { :_result_two_ }
        end

        it { return_value_for(subject, [:_result_one_, :_result_two_]) }
      end

      context 'when the event has not been registered' do
        let(:event_name) { :_not_found_ }

        it { return_value_for(subject, []) }
      end
    end

  end # Trigger

end # Vedeu
