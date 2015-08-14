require 'test_helper'

module Vedeu

  describe EventCollection do

    let(:described) { Vedeu::EventCollection }
    let(:instance)  { described.new }

    it { described.superclass.must_equal(Vedeu::Collection) }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
    end

  end # EventCollection

end # Vedeu
