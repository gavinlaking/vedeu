require 'test_helper'

module Vedeu

  module Views

    describe ViewCollection do

      let(:described) { Vedeu::Views::ViewCollection }
      let(:instance)  { described.new }

      it { described.superclass.must_equal(Vedeu::Repositories::Collection) }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
      end

    end # ViewCollection

  end # Views

end # Vedeu
