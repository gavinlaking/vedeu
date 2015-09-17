require 'test_helper'

module Vedeu

  module Views

    describe Lines do

      let(:described) { Vedeu::Views::Lines }
      let(:instance)  { described.new }

      it { described.superclass.must_equal(Vedeu::Repositories::Collection) }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
      end

    end # Lines

  end # Views

end # Vedeu
