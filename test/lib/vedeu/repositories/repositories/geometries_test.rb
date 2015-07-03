require 'test_helper'

module Vedeu

  describe Geometries do

    let(:described) { Vedeu::Geometries }

    after { Vedeu.geometries.reset }

    it { described.must_respond_to(:geometries) }

    describe '.reset!' do
      subject { described.reset! }

      it {
        described.expects(:register).with(Vedeu::Geometry)
        subject
      }
    end

  end # Geometries

end # Vedeu
