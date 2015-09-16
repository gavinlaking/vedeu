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

      it { described.must_respond_to(:with) }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@border').must_equal(border) }
      end

      describe '#render' do
        let(:geometry) {
          Vedeu::Geometry::Geometry.new(name: _name, x: 1, xn: 7, y: 1, yn: 4)
        }
        let(:interface) {
          Vedeu::Models::Interface.new(name: _name, visible: visible)
        }
        before do
          Vedeu.geometries.stubs(:by_name).returns(geometry)
          Vedeu.interfaces.stubs(:by_name).returns(interface)
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

            context 'and a title is given' do
              let(:title) { 'T' }

              # @todo Add more tests.
              it { subject.size.must_equal(18) }
            end

            context 'and a title is not given' do
              # @todo Add more tests.
              it { subject.size.must_equal(18) }
            end

            context 'and a caption is given' do
              let(:caption) { 'C' }

              # @todo Add more tests.
              it { subject.size.must_equal(18) }
            end

            context 'and a caption is not given' do
              # @todo Add more tests.
              it { subject.size.must_equal(18) }
            end

            context 'and the left side is disabled' do
              let(:show_left) { false }

              # @todo Add more tests.
              it { subject.size.must_equal(16) }
            end

            context 'and the right side is disabled' do
              let(:show_right) { false }

              # @todo Add more tests.
              it { subject.size.must_equal(16) }
            end

            context 'and the top side is disabled' do
              let(:show_top) { false }

              # @todo Add more tests.
              it { subject.size.must_equal(13) }
            end

            context 'and the bottom side is disabled' do
              let(:show_bottom) { false }

              # @todo Add more tests.
              it { subject.size.must_equal(13) }
            end
          end
        end
      end

    end # Render

  end # Borders

end # Vedeu
