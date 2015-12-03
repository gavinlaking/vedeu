require 'test_helper'

module Vedeu

  module Cells

    describe TopRight do

      let(:described) { Vedeu::Cells::TopRight }
      let(:instance)  { described.new }

      describe '#position' do
        let(:geometry) {
          Vedeu::Geometries::Geometry.new(x: 5, xn: 15, y: 3, yn: 9)
        }

        subject { instance.position }

        before { Vedeu.geometries.stubs(:by_name).returns(geometry) }

        it { subject.must_be_instance_of(Vedeu::Geometries::Position) }
        it { subject.x.must_equal(15) }
        it { subject.y.must_equal(3) }
      end

      describe '#type' do
        subject { instance.type }

        it { subject.must_equal(:top_right) }
      end

    end # TopRight

  end # Cells

end # Vedeu
