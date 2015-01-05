require 'test_helper'

module Vedeu

  describe Events do

    let(:described) { Vedeu::Events }
    let(:instance)  { described.new(model) }
    let(:model)     { Vedeu::Model::Collection }

    describe '#initialize' do
      subject { instance }

      it { return_type_for(subject, Vedeu::Events) }
    end

    describe '#unevent' do
      let(:event_name) { :chlorine }

      before do
        Vedeu::Event.register(:chlorine) { :some_event }
      end

      subject { instance.unevent(event_name) }

      context 'when the event exists' do
        it { return_type_for(subject, TrueClass) }
      end

      context 'when the event does not exist' do
        let(:event_name) { :does_not_exist }

        it { return_type_for(subject, FalseClass) }
      end
    end

  end # Events

end # Vedeu
