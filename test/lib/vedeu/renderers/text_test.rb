require 'test_helper'

module Vedeu

  module Renderers

    describe Text do

      let(:described) { Vedeu::Renderers::Text }
      let(:instance)  { described.new(options) }
      let(:options)   { {} }

      let(:geometry)  {
        Vedeu::Geometries::Geometry.new(name: 'Vedeu::Renderers::Text',
                                        x:    2,
                                        xn:   4,
                                        y:    2,
                                        yn:   4)
      }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
      end

      describe '#clear' do
        subject { instance.clear }

        it { subject.must_equal('') }
      end

      describe '#render' do
        let(:output) {}

        before do
          Vedeu.stubs(:height).returns(5)
          Vedeu.stubs(:width).returns(5)
          Vedeu.geometries.stubs(:by_name).returns(geometry)
          ::File.stubs(:write)
        end

        subject { instance.render(output) }

        context 'when the output is nil' do
          it { subject.must_equal('') }
        end

        context 'when the output is a Vedeu::Models::Page' do
          let(:output) { Vedeu::Models::Page.coerce(rows) }
          let(:rows) {
            [
              Vedeu::Models::Row.new([
                Vedeu::Cells::TopLeft.new,
                Vedeu::Cells::TopHorizontal.new,
                Vedeu::Cells::TopRight.new,
              ]),
              Vedeu::Models::Row.new([
                Vedeu::Cells::LeftVertical.new,
                Vedeu::Cells::Char.new,
                Vedeu::Cells::RightVertical.new,
              ]),
              Vedeu::Models::Row.new([
                Vedeu::Cells::BottomLeft.new,
                Vedeu::Cells::BottomHorizontal.new,
                Vedeu::Cells::BottomRight.new,
              ]),
            ]
          }
          let(:expected) {
            "     \n" \
            " + + \n" \
            "     \n" \
            " + + \n" \
            "     "
          }

          it { subject.must_equal(expected) }
        end
      end

    end # Text

  end # Renderers

end # Vedeu
