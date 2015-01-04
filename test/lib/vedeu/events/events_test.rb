require 'test_helper'

module Vedeu

  NastyException = Class.new(StandardError)

  describe Events do

    let(:described) { Events.new(model) }
    let(:model)     { Vedeu::Model::Collection }

    describe '#initialize' do
      it { return_type_for(described, Vedeu::Events) }
    end

    describe '#event' do
      subject { described.event(:sulphur) { proc { |x| x } } }

      context 'when the event is added' do
        it { return_type_for(subject, TrueClass) }
      end
    end

    describe '#unevent' do
      let(:event_name) { :chlorine }

      before do
        described.event(:chlorine) { proc { |x| x } }
        described.event(:argon)    { proc { |y| y } }
      end

      subject { described.unevent(event_name) }

      context 'when the event exists' do
        it { return_type_for(subject, TrueClass) }
      end

      context 'when the event does not exist' do
        let(:event_name) { :potassium }

        it { return_type_for(subject, FalseClass) }
      end
    end

  end # Events

end # Vedeu
