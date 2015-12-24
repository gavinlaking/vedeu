require 'test_helper'

module Vedeu

  module Views

    describe Views do

      let(:described) { Vedeu::Views::Views }
      let(:instance)  { described.new }

      it { described.superclass.must_equal(Vedeu::Repositories::Collection) }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
      end

    end # Views

  end # Views

end # Vedeu
