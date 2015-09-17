require 'test_helper'

module Vedeu

  module Events

    describe Collection do

      let(:described) { Vedeu::Events::Collection }
      let(:instance)  { described.new }

      it { described.superclass.must_equal(Vedeu::Repositories::Collection) }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
      end

    end # Collection

  end # Events

end # Vedeu
