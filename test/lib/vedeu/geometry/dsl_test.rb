require 'test_helper'

module Vedeu

  module Geometry

    describe DSL do

      let(:described) { Vedeu::Geometry::DSL }
      let(:instance)  { described.new(model) }
      let(:model)     { Vedeu::Geometry::Geometry.new }

      describe '.geometry' do
        it { described.must_respond_to(:geometry) }
      end

      describe '#alignment' do
        let(:_value) { :none }
        let(:width)  { 20 }

        subject { instance.alignment(_value, width) }

        context 'when a value and width is given' do
          it { subject.must_be_instance_of(Vedeu::Geometry::Geometry) }

          context 'when the value is :center' do
            let(:_value) { :center }

            it { subject.alignment.must_equal(:centre) }
          end

          context 'when the value is :centre' do
            let(:_value) { :centre }

            it { subject.alignment.must_equal(:centre) }
          end

          context 'when the value is :left' do
            let(:_value) { :left }

            it { subject.alignment.must_equal(:left) }
          end

          context 'when the value is :right' do
            let(:_value) { :right }

            it { subject.alignment.must_equal(:right) }
          end
        end

        context 'when a value is not given' do
          let(:_value) {}

          it { proc { subject }.must_raise(Vedeu::Error::InvalidSyntax) }
        end

        context 'when a width is not given' do
          let(:_value) { :none }
          let(:width)  {}

          it { proc { subject }.must_raise(Vedeu::Error::InvalidSyntax) }
        end
      end

      describe '#align_centre' do
        let(:width) { 20 }

        subject { instance.align_centre(width) }

        it { instance.must_respond_to(:align_center) }

        context 'when a width is given' do
          it { subject.must_be_instance_of(Vedeu::Geometry::Geometry) }
        end

        context 'when a width is not given' do
          let(:width) {}

          it { proc { subject }.must_raise(Vedeu::Error::InvalidSyntax) }
        end
      end

      describe '#align_left' do
        let(:width) { 20 }

        subject { instance.align_left(width) }

        context 'when a width is given' do
        end

        context 'when a width is not given' do
          let(:width) {}

          it { proc { subject }.must_raise(Vedeu::Error::InvalidSyntax) }
        end
      end

      describe '#align_right' do
        let(:width) { 20 }

        subject { instance.align_right(width) }

        context 'when a width is given' do
        end

        context 'when a width is not given' do
          let(:width) {}

          it { proc { subject }.must_raise(Vedeu::Error::InvalidSyntax) }
        end
      end

      describe '#centred' do
        subject { instance.centred(true) }

        it { instance.must_respond_to(:centred!) }
        it { instance.must_respond_to(:centred=) }

        it 'sets the attribute to the value' do
          subject.must_equal(true)
        end

        context 'DSL #centred' do
          subject {
            Vedeu.geometry 'geometry' do
              centred false
            end
          }

          it { subject.must_be_instance_of(Vedeu::Geometry::Geometry) }

          it 'allows the use of centred within geometry' do
            subject.centred.must_equal(false)
          end

          context 'when no value is given' do
            subject {
              Vedeu.geometry 'geometry' do
                centred
              end
            }

            it { subject.centred.must_equal(true) }
          end
        end
      end

      describe '#columns' do
        before { Vedeu::Terminal.stubs(:size).returns([25, 80]) }

        subject { instance.columns(3) }

        it { subject.must_equal(18) }

        context 'DSL #columns' do
          before { Vedeu.stubs(:width).returns(80) }

          subject {
            Vedeu.geometry 'geometry' do
              width columns(8)
            end
          }

          it { subject.width.must_equal(48) }
        end
      end

      describe '#height' do
        subject { instance.height(6) }

        it { instance.must_respond_to(:height=) }

        it 'sets the attribute to the value' do
          subject.call.must_equal(6)
        end

        context 'DSL #height' do
          subject {
            Vedeu.geometry 'geometry' do
              height 17
            end
          }

          it { subject.must_be_instance_of(Vedeu::Geometry::Geometry) }

          it 'allows the use of height within geometry' do
            subject.height.must_equal(17)
          end
        end
      end

      describe '#rows' do
        before { Vedeu::Terminal.stubs(:size).returns([25, 80]) }

        subject { instance.rows(3) }

        it { subject.must_equal(6) }

        context 'DSL #rows' do
          before { Vedeu.stubs(:height).returns(38) }

          subject {
            Vedeu.geometry 'geometry' do
              height rows(8)
            end
          }

          it { subject.height.must_equal(24) }
        end
      end

      describe '#use' do
        before {
          Vedeu.geometry 'some_geometry' do
            x 5
          end
          Vedeu.geometry 'other_geometry' do
            x use('some_geometry').x
          end
        }
        after { Vedeu.geometries.reset }

        subject { instance.use('other_geometry').x }

        it 'allows the use of another models attributes' do
          subject
          Vedeu.geometries.by_name('other_geometry').x.must_equal(5)
        end
      end

      describe '#width' do
        subject { instance.width(25) }

        it { instance.must_respond_to(:width=) }

        it 'sets the attribute to the value' do
          subject.call.must_equal(25)
        end

        context 'DSL #width' do
          subject {
            Vedeu.geometry 'geometry' do
              width 29
            end
          }

          it { subject.must_be_instance_of(Vedeu::Geometry::Geometry) }

          it 'allows the use of width within geometry' do
            subject.width.must_equal(29)
          end
        end
      end

      describe '#x' do
        subject { instance.x(2) }

        it { instance.must_respond_to(:x=) }

        it 'sets the attribute to the value' do
          subject.must_equal(2)
        end

        context 'when a block is given' do
          subject {
            Vedeu::Geometry::Geometry.build({}) do
              x do
                3 + 4
              end
            end
          }

          it { subject.x.must_equal(7) }
        end

        context 'DSL #x' do
          subject {
            Vedeu.geometry 'geometry' do
              x 9
            end
          }

          it { subject.must_be_instance_of(Vedeu::Geometry::Geometry) }

          it 'allows the use of x within geometry' do
            subject.x.must_equal(9)
          end

          context 'when no value is given' do
            subject {
              Vedeu.geometry 'geometry' do
                x
              end
            }

            it { subject.x.must_equal(1) }
          end

          context 'when a block is given' do
            subject {
              Vedeu::Geometry::Geometry.build({}) do
                x do
                  8 + 8
                end
              end
            }

            it { subject.x.must_equal(16) }
          end
        end
      end

      describe '#y' do
        subject { instance.y(5) }

        it { instance.must_respond_to(:y=) }

        it 'sets the attribute to the value' do
          subject.must_equal(5)
        end

        context 'when a block is given' do
          subject {
            Vedeu::Geometry::Geometry.build({}) do
              y do
                2 + 7
              end
            end
          }

          it { subject.y.must_equal(9) }
        end

        context 'DSL #y' do
          subject {
            Vedeu.geometry 'geometry' do
              y 4
            end
          }

          it { subject.must_be_instance_of(Vedeu::Geometry::Geometry) }

          it 'allows the use of y within geometry' do
            subject.y.must_equal(4)
          end

          context 'when no value is given' do
            subject {
              Vedeu.geometry 'geometry' do
                y
              end
            }

            it { subject.y.must_equal(1) }
          end

          context 'when a block is given' do
            subject {
              Vedeu::Geometry::Geometry.build({}) do
                y do
                  8 + 8
                end
              end
            }

            it { subject.y.must_equal(16) }
          end
        end
      end

      describe '#xn' do
        subject { instance.xn(15) }

        it { instance.must_respond_to(:xn=) }
        it { subject.must_equal(15) }

        context 'when a block is given' do
          subject {
            Vedeu::Geometry::Geometry.build({}) do
              xn do
                8 + 8
              end
            end
          }

          it { subject.xn.must_equal(16) }
        end
      end

      describe '#yn' do
        subject { instance.yn(8) }

        it { instance.must_respond_to(:yn=) }
        it { subject.must_equal(8) }

        context 'when a block is given' do
          subject {
            Vedeu::Geometry::Geometry.build({}) do
              yn do
                5 + 4
              end
            end
          }

          it { subject.yn.must_equal(9) }
        end
      end

    end # DSL

  end # Geometry

end # Vedeu
