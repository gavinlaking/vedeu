require 'test_helper'

module Vedeu

  describe Events do

    let(:described) { Vedeu::Events }
    let(:instance)  { described.new }

    describe '#initialize' do
      it { instance.must_be_instance_of(Vedeu::Events) }
    end

  end # Events

end # Vedeu
