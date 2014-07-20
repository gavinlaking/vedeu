require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/repository/event_repository'

module Vedeu
  describe EventRepository do
    describe '#handlers' do
      it 'returns a Hash' do
        EventRepository.handlers.must_be_instance_of(Hash)
      end
    end

    describe '#register' do
      it 'returns an Array' do
        EventRepository.register(:some_event) { proc { |x| x } }
          .must_be_instance_of(Array)
      end
    end

    describe '#trigger' do
      it 'returns a collection containing the event when the event is pre-registered' do
        EventRepository.register(:some_event) { proc { |x| x } }
        EventRepository.trigger(:_exit_, []).first.call
          .must_equal(:_stop_)
      end

      it 'returns an empty collection when the event has not been registered' do
        EventRepository.trigger(:_not_found_, []).must_be_empty
      end
    end
  end
end
