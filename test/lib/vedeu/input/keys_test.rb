require 'test_helper'

module Vedeu

  module Input

    describe Keys do

      let(:described) { Vedeu::Input::Keys }
      let(:instance)  { described.new }

      it { described.superclass.must_equal(Vedeu::Collection) }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
      end

    end # Keys

  end # Input

end # Vedeu
