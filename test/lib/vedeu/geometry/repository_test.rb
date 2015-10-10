require 'test_helper'

module Vedeu

  describe 'Bindings' do
    it { Vedeu.bound?(:_maximise_).must_equal(true) }
    it { Vedeu.bound?(:_unmaximise_).must_equal(true) }
    # it { Vedeu.bound?(:_geometry_down_).must_equal(true) }
    # it { Vedeu.bound?(:_geometry_left_).must_equal(true) }
    # it { Vedeu.bound?(:_geometry_right_).must_equal(true) }
    # it { Vedeu.bound?(:_geometry_up_).must_equal(true) }
    it { Vedeu.bound?(:_view_down_).must_equal(true) }
    it { Vedeu.bound?(:_view_left_).must_equal(true) }
    it { Vedeu.bound?(:_view_right_).must_equal(true) }
    it { Vedeu.bound?(:_view_up_).must_equal(true) }
  end

  module Geometry

    describe Repository do

      let(:described) { Vedeu::Geometry::Repository }

      after { Vedeu.geometries.reset }

      it { described.must_respond_to(:geometries) }

    end # Repository

  end # Geometry

end # Vedeu
