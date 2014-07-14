require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/repository/event_repository'

module Vedeu
  describe EventRepository do
    let(:described_class)    { EventRepository }

    describe '#handlers' do
      let(:subject) { described_class.handlers }

      it 'returns a Hash' do
        subject.must_be_instance_of(Hash)
      end
    end

    describe '#register' do
      let(:subject) { described_class.register(event) { proc { |x, y| x + y } } }
      let(:event)   { :some_event }

      it 'returns an Array' do
        subject.must_be_instance_of(Array)
      end
    end

    describe '#trigger' do
      let(:subject) { described_class.trigger(event, args) }
      let(:event)   { :some_event }
      let(:args)    { :arg }

      before do
        described_class.register(:some_event) { proc { |x| x } }
      end

      it 'returns an Array' do
        subject.must_be_instance_of(Array)
      end

      context 'when the event is pre-registered' do
        let(:event) { :_exit_ }

        it 'returns a collection containing the event' do
          subject.first.call.must_equal(:exit)
        end
      end

      context 'when the event has not been registered' do
        let(:event) { :_not_found_ }

        it 'returns an empty collection' do
          subject.must_be_empty
        end
      end
    end
  end
end
