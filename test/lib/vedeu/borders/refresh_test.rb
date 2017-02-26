# frozen_string_literal: true

require 'test_helper'

module Vedeu

  describe 'Bindings' do
    it { Vedeu.bound?(:_refresh_border_).must_equal(true) }
  end

  module Borders

    describe Refresh do

      let(:described)   { Vedeu::Borders::Refresh }
      let(:instance)    { described.new(_name) }
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
      let(:visible)     { true }
      let(:enabled)     { false }
      let(:_name)       { :vedeu_borders_refresh }
      let(:title)       {}
      let(:caption)     {}
      let(:show_top)    { true }
      let(:show_bottom) { true }
      let(:show_left)   { true }
      let(:show_right)  { true }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@name').must_equal(_name) }
      end

      describe '#render' do
        it { instance.must_respond_to(:render) }
      end

      describe '.by_name' do
        let(:geometry) {
          Vedeu::Geometries::Geometry.new(name: _name, x: 1, xn: 7, y: 1, yn: 4)
        }
        let(:interface) {
          Vedeu::Interfaces::Interface.new(name: _name, visible: visible)
        }
        before do
          Vedeu.borders.stubs(:by_name).returns(border)
          Vedeu.geometries.stubs(:by_name).returns(geometry)
          Vedeu.interfaces.stubs(:by_name).returns(interface)
        end

        subject { described.by_name(_name) }

        context 'when the border is enabled' do
          let(:enabled) { true }

          it do
            Vedeu.expects(:render_output)
            subject
          end

          context 'but the interface/view is not visible' do
            let(:visible) { false }

            it { Vedeu.expects(:render_output).never }
            it { assert_nil(subject) }
          end
        end

        context 'when the border is not enabled' do
          it { Vedeu.expects(:render_output).never }
          it { assert_nil(subject) }
        end
      end

    end # Render

  end # Borders

end # Vedeu
