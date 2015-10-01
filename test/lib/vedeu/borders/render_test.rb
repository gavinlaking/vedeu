require 'test_helper'

module Vedeu

  module Borders

    describe Render do

      let(:described)   { Vedeu::Borders::Render }
      let(:instance)    { described.new(border) }
      let(:border)      {
        Vedeu::Borders::Border.new(enabled:     enabled,
                                   name:        _name,
                                   title:       title,
                                   caption:     caption,
                                   show_top:    show_top,
                                   show_bottom: show_bottom,
                                   show_left:   show_left,
                                   show_right:  show_right)
      }
      let(:visible)     { false }
      let(:enabled)     { false }
      let(:_name)       { 'Vedeu::RenderBorder' }
      let(:title)       {}
      let(:caption)     {}
      let(:show_top)    { true }
      let(:show_bottom) { true }
      let(:show_left)   { true }
      let(:show_right)  { true }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@border').must_equal(border) }
      end

      describe '#render' do
        it { instance.must_respond_to(:render) }
      end

      describe '.render' do
        let(:geometry) {
          Vedeu::Geometry::Geometry.new(name: _name, x: 1, xn: 7, y: 1, yn: 4)
        }
        let(:interface) {
          Vedeu::Models::Interface.new(name: _name, visible: true)
        }
        before do
          Vedeu.geometries.stubs(:by_name).returns(geometry)
          Vedeu.interfaces.stubs(:by_name).returns(interface)
        end

        subject { described.render(border) }

        context 'when the border is enabled' do
          let(:enabled) { true }

          it {
            Vedeu::Output::Output.expects(:render)
            subject
          }
        end

        context 'when the border is not enabled' do
          it { subject.must_equal(nil) }
        end
      end

    end # Render

  end # Borders

end # Vedeu
