require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/support/events'

module Vedeu
  describe Events do
    let(:described_class)    { Events }
    let(:described_instance) { described_class.new }

    describe '#initialize' do
      let(:subject) { described_instance }

      it 'returns an Events instance' do
        subject.must_be_instance_of(Events)
      end

      it 'sets an instance variable' do
        subject.instance_variable_get('@handlers')
          .must_be_instance_of(Hash)
      end
    end

    describe '#on' do
      let(:subject) { described_instance.on(event) { proc { |x, y| x + y } } }
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
