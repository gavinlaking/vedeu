# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Cells

    describe Corner do

      let(:described)  { Vedeu::Cells::Corner }

      describe '#position' do
        let(:geometry) {
          Vedeu::Geometries::Geometry.new(x: 5, xn: 15, y: 3, yn: 9)
        }

        before { instance.stubs(:geometry).returns(geometry) }

        subject { instance.position }

        context 'when providing the position for the bottom left corner' do
          let(:instance) { Vedeu::Cells::BottomLeft.new }

          it { subject.must_be_instance_of(Vedeu::Geometries::Position) }
          it { subject.x.must_equal(5) }
          it { subject.y.must_equal(9) }
        end

        context 'when providing the position for the bottom right corner' do
          let(:instance) { Vedeu::Cells::BottomRight.new }

          it { subject.must_be_instance_of(Vedeu::Geometries::Position) }
          it { subject.x.must_equal(15) }
          it { subject.y.must_equal(9) }
        end

        context 'when providing the position for the top left corner' do
          let(:instance) { Vedeu::Cells::TopLeft.new }

          it { subject.must_be_instance_of(Vedeu::Geometries::Position) }
          it { subject.x.must_equal(5) }
          it { subject.y.must_equal(3) }
        end

        context 'when providing the position for the top right corner' do
          let(:instance) { Vedeu::Cells::TopRight.new }

          it { subject.must_be_instance_of(Vedeu::Geometries::Position) }
          it { subject.x.must_equal(15) }
          it { subject.y.must_equal(3) }
        end
      end

      describe '#text' do
        let(:instance) { Vedeu::Cells::TopRight.new }

        subject { instance.text }

        it { subject.must_equal('+') }
      end

    end # Corner

  end # Cells

end # Vedeu
