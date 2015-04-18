require 'test_helper'

module Vedeu

  module DSL

    describe Geometry do

      let(:described) { Vedeu::DSL::Geometry }
      let(:instance)  { described.new(model) }
      let(:model)     { Vedeu::Geometry.new }

      before { Terminal.stubs(:size).returns([25, 80]) }

      describe 'alias methods' do
        it { instance.must_respond_to(:centred!) }
      end

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@model').must_equal(model) }
      end

      describe '#centred' do
        subject { instance.centred(true) }

        it 'sets the attribute to the value' do
          subject.must_equal(true)
        end

        context 'DSL #centred' do
          subject {
            Vedeu.geometry 'geometry' do
              centred false
            end
          }

          it { subject.must_be_instance_of(Vedeu::Geometry) }

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

      describe '#height' do
        subject { instance.height(6) }

        it 'sets the attribute to the value' do
          subject.must_equal(6)
        end

        context 'DSL #height' do
          subject {
            Vedeu.geometry 'geometry' do
              height 17
            end
          }

          it { subject.must_be_instance_of(Vedeu::Geometry) }

          it 'allows the use of height within geometry' do
            subject.height.must_equal(17)
          end
        end
      end

      describe '#width' do
        subject { instance.width(25) }

        it 'sets the attribute to the value' do
          subject.must_equal(25)
        end

        context 'DSL #width' do
          subject {
            Vedeu.geometry 'geometry' do
              width 29
            end
          }

          it { subject.must_be_instance_of(Vedeu::Geometry) }

          it 'allows the use of width within geometry' do
            subject.width.must_equal(29)
          end
        end
      end

      describe '#x' do
        subject { instance.x(2) }

        it 'sets the attribute to the value' do
          subject.must_equal(2)
        end

        context 'when a block is given' do
          subject {
            Vedeu::Geometry.build({}) do
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

          it { subject.must_be_instance_of(Vedeu::Geometry) }

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
              Vedeu::Geometry.build({}) do
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

        it 'sets the attribute to the value' do
          subject.must_equal(5)
        end

        context 'when a block is given' do
          subject {
            Vedeu::Geometry.build({}) do
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

          it { subject.must_be_instance_of(Vedeu::Geometry) }

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
              Vedeu::Geometry.build({}) do
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

        it { subject.must_equal(15) }

        context 'when a block is given' do
          subject {
            Vedeu::Geometry.build({}) do
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

        it { subject.must_equal(8) }

        context 'when a block is given' do
          subject {
            Vedeu::Geometry.build({}) do
              yn do
                5 + 4
              end
            end
          }

          it { subject.yn.must_equal(9) }
        end
      end

    end # Geometry

  end # DSL

end # Vedeu
