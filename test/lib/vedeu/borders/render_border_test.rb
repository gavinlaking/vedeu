require 'test_helper'

module Vedeu

  describe RenderBorder do

    let(:described)   { Vedeu::RenderBorder }
    let(:instance)    { described.new(border) }
    let(:border)      { Vedeu::Border.new(enabled: enabled, name: _name) }
    let(:visible)     { false }
    let(:enabled)     { false }
    let(:_name)       { 'Vedeu::RenderBorder' }

    it { described.must_respond_to(:with) }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@border').must_equal(border) }
    end

    describe '#render' do
      let(:geometry) {
        Vedeu::Geometry.new(name: _name, x: 1, xn: 3, y: 1, yn: 3)
      }
      let(:interface) {
        Vedeu::Interface.new(name: _name, visible: visible)
      }
      before {
        Vedeu.geometries.stubs(:by_name).returns(geometry)
        Vedeu.interfaces.stubs(:by_name).returns(interface)
      }

      subject { instance.render }

      context 'when the interface is not visible' do
        it { subject.must_equal([]) }
      end

      context 'when the interface is visible' do
        let(:visible) { true }

        context 'when the border is not enabled' do
          it { subject.must_equal([]) }
        end

        context 'when the border is enabled' do
          let(:enabled) { true }

          # @todo Add more tests.
          # it { skip }
        end
      end
    end

  end # RenderBorder

end # Vedeu
