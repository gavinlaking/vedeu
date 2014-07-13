require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/repository/event_repository'

module Vedeu
  describe EventRepository do
    let(:described_class)    { EventRepository }
    let(:described_instance) { described_class.new }

    describe '#handlers' do
      let(:subject) { described_instance.handlers }

      it 'returns a Hash' do
        subject.must_be_instance_of(Hash)
      end
    end

    describe '#register' do
      let(:subject) { described_instance.register(event) { proc { |x, y| x + y } } }
      let(:event)   { :some_event }

      it 'returns an Array' do
        subject.must_be_instance_of(Array)
      end
    end

    describe '#trigger' do
      let(:subject) { described_instance.trigger(event, args) }
      let(:event)   { :some_event }
      let(:args)    { :arg }

      before do
        described_instance.on(:some_event) { proc { |x| x } }
      end

      it 'returns an Array' do
        subject.must_be_instance_of(Array)
      end
    end
  end
end
