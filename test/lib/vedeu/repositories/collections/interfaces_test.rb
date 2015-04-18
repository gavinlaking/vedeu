require 'test_helper'

module Vedeu

  describe Interfaces do

    let(:described) { Vedeu::Interfaces }
    let(:instance)  { described.new }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
    end

  end # Interfaces

end # Vedeu
