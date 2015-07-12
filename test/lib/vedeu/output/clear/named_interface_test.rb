require 'test_helper'

module Vedeu

  module Clear

    describe NamedInterface do

      let(:described) { Vedeu::Clear::NamedInterface }
      let(:instance)  { described.new(_name) }
      let(:_name)     { 'Vedeu::Clear::NamedInterface' }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@name').must_equal(_name) }
      end

      describe '.render' do
        it { described.must_respond_to(:by_name) }
        it { described.must_respond_to(:clear_by_name) }
        it { described.must_respond_to(:render) }
      end

      describe '#render' do
        let(:interface) { Vedeu::Interface.new(name: _name, visible: visible) }
        let(:visible)   { true }
        let(:geometry)  {
          Vedeu::Geometry.new(name: _name, x: 1, y: 1, xn: 2, yn: 2)
        }

        before do
          Vedeu.interfaces.stubs(:by_name).returns(interface)
          Vedeu.geometries.stubs(:by_name).returns(geometry)
        end

        subject { instance.render }

        context 'when the interface is visible' do
          let(:output) {
            [
              [
                Vedeu::Char.new(value: ' ', position: [1, 1]),
                Vedeu::Char.new(value: ' ', position: [1, 2]),

              ], [
                Vedeu::Char.new(value: ' ', position: [2, 1]),
                Vedeu::Char.new(value: ' ', position: [2, 2]),

              ]
            ]
          }

          it { subject.must_equal(output) }
        end

        context 'when the interface is not visible' do
          let(:visible) { false }

          it { subject.must_equal([]) }
        end

      end

    end # NamedInterface

  end # Clear

end # Vedeu