require 'test_helper'

module Vedeu

  describe Geometries do

    let(:described) { Vedeu::Geometries }

    after { Vedeu.geometries.reset }

    it { described.must_respond_to(:geometries) }

  end # Geometries

end # Vedeu
