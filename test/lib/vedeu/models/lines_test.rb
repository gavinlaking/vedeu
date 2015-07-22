require 'test_helper'

module Vedeu

  describe Lines do

    let(:described) { Vedeu::Lines }
    let(:instance)  { described.new }

    it { described.superclass.must_equal(Vedeu::Collection) }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
    end

  end # Lines

end # Vedeu
