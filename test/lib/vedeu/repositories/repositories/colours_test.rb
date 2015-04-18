require 'test_helper'

module Vedeu

  describe Colours do

    let(:described) { Vedeu::Colours }
    let(:instance)  { described.new }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
    end

  end # Colours

end # Vedeu
