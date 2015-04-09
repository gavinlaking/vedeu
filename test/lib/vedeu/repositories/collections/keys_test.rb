require 'test_helper'

module Vedeu

  describe Keys do

    let(:described) { Vedeu::Keys }
    let(:instance)  { described.new }

    describe '#initialize' do
      it { instance.must_be_instance_of(Vedeu::Keys) }
    end

  end # Keys

end # Vedeu
