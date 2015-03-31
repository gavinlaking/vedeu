require 'test_helper'

module Vedeu

  describe Lines do

    let(:described) { Vedeu::Lines }
    let(:instance)  { described.new }

    describe '#initialize' do
      it { instance.must_be_instance_of(Vedeu::Lines) }
    end

  end # Lines

end # Vedeu
