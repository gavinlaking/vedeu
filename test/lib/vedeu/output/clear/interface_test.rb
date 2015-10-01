require 'test_helper'

module Vedeu

  module Clear

    describe Interface do

      let(:described) { Vedeu::Clear::Interface }
      let(:instance)  { described.new(_name, options) }
      let(:options)   {
        {
          content_only: false,
        }
      }
      let(:_name)     { 'Vedeu::Clear::Interface' }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@name').must_equal(_name) }
        it { instance.instance_variable_get('@options').must_equal(options) }
      end

      describe '.render' do
        it { described.must_respond_to(:by_name) }
        it { described.must_respond_to(:clear_by_name) }
        it { described.must_respond_to(:render) }
      end

      describe '#render' do
        let(:interface) {
          Vedeu::Models::Interface.new(name: _name, visible: visible)
        }
        let(:visible)   { true }
        let(:geometry)  {
          Vedeu::Geometry::Geometry.new(name: _name, x: 1, y: 1, xn: 2, yn: 2)
        }
        let(:output) {
          [
            [
              Vedeu::Views::Char.new(value: ' ', position: [1, 1]),
              Vedeu::Views::Char.new(value: ' ', position: [1, 2]),

            ], [
              Vedeu::Views::Char.new(value: ' ', position: [2, 1]),
              Vedeu::Views::Char.new(value: ' ', position: [2, 2]),

            ]
          ]
        }

        before do
          Vedeu.interfaces.stubs(:by_name).returns(interface)
          Vedeu.geometries.stubs(:by_name).returns(geometry)
          Vedeu::Output::Output.stubs(:render).returns(output)
        end

        subject { instance.render }

        it { subject.must_be_instance_of(Array) }
        it {
          Vedeu::Output::Output.expects(:render).with(output)
          subject
        }
        it { subject.must_equal(output) }
      end

    end # Interface

  end # Clear

end # Vedeu
