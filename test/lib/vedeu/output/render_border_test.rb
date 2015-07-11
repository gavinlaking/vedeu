require 'test_helper'

module Vedeu

  describe RenderBorder do

    let(:described)   { Vedeu::RenderBorder }
    let(:instance)    { described.new(border) }
    let(:border)      {
      Vedeu::Border.new(enabled: enabled,
                        name: _name).store
    }
    let(:visible)     { false }
    let(:enabled)     { false }
    let(:_name)       { 'Vedeu::RenderBorder' }

    it { described.must_respond_to(:with) }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@border').must_equal(border) }
    end

    describe '#render' do
      before do
        Vedeu::Geometry.new(name: _name, x: 1, xn: 3, y: 1, yn: 3).store
        Vedeu::Interface.new(name: _name, visible: visible).store
      end
      after do
        Vedeu.geometries.reset!
        Vedeu.interfaces.reset!
        Vedeu.borders.reset!
      end

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

          # it { skip }
        end
      end
    end

  end # RenderBorder

end # Vedeu
