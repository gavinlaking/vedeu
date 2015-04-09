require 'test_helper'

module Vedeu

  describe EventsRepository do

    let(:described) { Vedeu::EventsRepository }

    describe '.events' do
      subject { described.events }

      it { subject.must_be_instance_of(described) }
    end

  end # EventsRepository

end # Vedeu
