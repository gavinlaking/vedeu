require 'test_helper'

module Vedeu

  module Geometry

    describe Repository do

      let(:described) { Vedeu::Geometry::Repository }

      after { Vedeu.geometries.reset }

      it { described.must_respond_to(:geometries) }

    end # Repository

  end # Geometry

end # Vedeu
