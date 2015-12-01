require 'test_helper'

module Vedeu

  module Output

    describe Viewport do

      let(:described)  { Vedeu::Output::Viewport }
      let(:instance)   { described.new(view) }
      let(:view)       {
        Vedeu::Views::View.build(name: 'lithium', style: nil) do
          lines do
            line 'barium'
            line 'carbon'
            line 'helium'
            line 'iodine'
            line 'nickel'
            line 'osmium'
          end
        end
      }
      let(:visible)   { true }
      let(:interface) {
        Vedeu::Interfaces::Interface.new(name:    'lithium',
                                         style:   nil,
                                         visible: visible)
      }
      let(:geometry)  {
        Vedeu::Geometries::Geometry.new(name:   'lithium',
                                      height: 3,
                                      width:  3)
      }
      let(:ready)     { true }

      before do
        Vedeu.interfaces.stubs(:by_name).returns(interface)
        Vedeu.geometries.stubs(:by_name).returns(geometry)
      end
      after { Vedeu.interfaces.reset }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@view').must_equal(view) }
      end

      describe '.render' do
        before do
          Vedeu.stubs(:render_output)
          Vedeu.stubs(:ready?).returns(ready)
        end

        subject { described.render(view) }

        context 'when the interface is visible' do
          context 'and Vedeu is ready' do
            it do
              Vedeu.expects(:render_output)
              subject
            end
          end

          context 'but Vedeu is not ready' do
            let(:ready) { false }

            it { subject.must_equal(nil) }
          end
        end

        context 'when the interface is not visible' do
          let(:visible) { false }

          it { subject.must_equal(nil) }
        end
      end

      describe '#render' do
        it { instance.must_respond_to(:render) }
      end

      describe '#to_s' do
        it { instance.must_respond_to(:to_s) }
      end

    end # Viewport

  end # Output

end # Vedeu
