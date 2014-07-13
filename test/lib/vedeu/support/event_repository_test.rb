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
    end
  end
end
