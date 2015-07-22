require 'test_helper'

module Vedeu

	describe InterfaceCollection do

    let(:described) { Vedeu::InterfaceCollection }
    let(:instance)  { described.new }

    it { described.superclass.must_equal(Vedeu::Collection) }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
    end

  end # InterfaceCollection

end # Vedeu
