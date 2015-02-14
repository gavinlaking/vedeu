require 'test_helper'

module Vedeu

  module DSL

    describe Geometry do

      let(:described) { Vedeu::DSL::Geometry.new(model) }
      let(:model)     { Vedeu::Geometry.new }

      describe '#initialize' do
        it { described.must_be_instance_of(Vedeu::DSL::Geometry) }
        it { described.instance_variable_get('@model').must_equal(model) }
      end

      describe '#centred' do
        subject { Vedeu::Geometry.build({}) { centred true } }

        it 'sets the attribute to the value' do
          subject.centred.must_equal(true)
        end

        context 'DSL #centred' do
          subject {
            Vedeu.interface 'geometry' do
              geometry do
                centred false
              end
            end
          }

          it { subject.must_be_instance_of(Vedeu::Interface) }

          it 'allows the use of centred within geometry' do
            subject.geometry.centred.must_equal(false)
          end

          context 'when no value is given' do
            subject {
              Vedeu.interface 'geometry' do
                geometry do
                  centred
                end
              end
            }

            it { subject.geometry.centred.must_equal(true) }
          end
        end
      end

      describe '#height' do
        subject { Vedeu::Geometry.build({}) { height 6 } }

        it 'sets the attribute to the value' do
          subject.height.must_equal(6)
        end

        context 'DSL #height' do
          subject {
            Vedeu.interface 'geometry' do
              geometry do
                height 17
              end
            end
          }

          it { subject.must_be_instance_of(Vedeu::Interface) }

          it 'allows the use of height within geometry' do
            subject.geometry.height.must_equal(17)
          end
        end
      end

      describe '#width' do
        subject { Vedeu::Geometry.build({}) { width 25 } }

        it 'sets the attribute to the value' do
          subject.width.must_equal(25)
        end

        context 'DSL #width' do
          subject {
            Vedeu.interface 'geometry' do
              geometry do
                width 29
              end
            end
          }

          it { subject.must_be_instance_of(Vedeu::Interface) }

          it 'allows the use of width within geometry' do
            subject.geometry.width.must_equal(29)
          end
        end
      end

      describe '#x' do
        subject { Vedeu::Geometry.build({}) { x 2 } }

        it 'sets the attribute to the value' do
          subject.x.must_equal(2)
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
            Vedeu.interface 'geometry' do
              geometry do
                x 7
              end
            end
          }

          it { subject.must_be_instance_of(Vedeu::Interface) }

          it 'allows the use of x within geometry' do
            subject.geometry.x.must_equal(7)
          end

          context 'when no value is given' do
            subject {
              Vedeu.interface 'geometry' do
                geometry do
                  x
                end
              end
            }

            it { subject.geometry.x.must_equal(0) }
          end

          context 'when a block is given' do
          end
        end
      end

      describe '#y' do
        subject { Vedeu::Geometry.build({}) { y 5 } }

        it 'sets the attribute to the value' do
          subject.y.must_equal(5)
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
            Vedeu.interface 'geometry' do
              geometry do
                y 4
              end
            end
          }

          it { subject.must_be_instance_of(Vedeu::Interface) }

          it 'allows the use of y within geometry' do
            subject.geometry.y.must_equal(4)
          end

          context 'when no value is given' do
            subject {
              Vedeu.interface 'geometry' do
                geometry do
                  y
                end
              end
            }

            it { subject.geometry.y.must_equal(0) }
          end

          context 'when a block is given' do
          end
        end
      end

    end # Geometry

  end # DSL

end # Vedeu
