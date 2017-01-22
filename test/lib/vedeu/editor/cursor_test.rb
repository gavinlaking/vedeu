# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Editor

    describe Cursor do

      let(:described)  { Vedeu::Editor::Cursor }
      let(:instance)   { described.new(attributes) }
      let(:attributes) {
        {
          name: _name,
          ox:   ox,
          oy:   oy,
          x:    x,
          y:    y,
        }
      }
      let(:_name) { :vedeu_editor_cursor }
      let(:ox)    { 0 }
      let(:oy)    { 0 }
      let(:x)     { 0 }
      let(:y)     { 0 }

      let(:border) {
        Vedeu::Borders::Border.new(name: _name, enabled: false)
      }
      let(:geometry) {
        Vedeu::Geometries::Geometry.new(name: _name,
                                      x:    1,
                                      y:    1,
                                      xn:   6,
                                      yn:   6)
      }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@y').must_equal(y) }
        it { instance.instance_variable_get('@x').must_equal(x) }
        it { instance.instance_variable_get('@name').must_equal(_name) }
        it { instance.instance_variable_get('@oy').must_equal(0) }
        it { instance.instance_variable_get('@ox').must_equal(0) }
      end

      describe '#name' do
        it { instance.must_respond_to(:name) }
      end

      describe '#ox' do
        it { instance.must_respond_to(:ox) }
      end

      describe '#ox=' do
        it { instance.must_respond_to(:ox=) }
      end

      describe '#oy' do
        it { instance.must_respond_to(:oy) }
      end

      describe '#oy=' do
        it { instance.must_respond_to(:oy=) }
      end

      describe '#x=' do
        it { instance.must_respond_to(:x=) }
      end

      describe '#y=' do
        it { instance.must_respond_to(:y=) }
      end

      describe '#bol' do
        let(:x)  { 11 }
        let(:ox) { 4 }

        subject { instance.bol }

        it { subject.must_be_instance_of(described) }

        it { subject.x.must_equal(0) }
        it { subject.ox.must_equal(0) }
      end

      describe '#down' do
        let(:y)    { 11 }
        let(:size) {}

        subject { instance.down(size) }

        it { subject.must_be_instance_of(described) }

        it { subject.y.must_equal(12) }
        it { subject.x.must_equal(0) }

        context 'when a size is given and x > size' do
          let(:x)    { 15 }
          let(:size) { 11 }

          it { subject.x.must_equal(11) }
        end
      end

      describe '#left' do
        let(:x)  { 11 }
        let(:ox) { 4 }

        subject { instance.left }

        it { subject.must_be_instance_of(described) }

        it { subject.x.must_equal(10) }
        it { subject.ox.must_equal(3) }
      end

      describe '#refresh' do
        before {
          Vedeu::Cursors::Cursor.stubs(:store)
          Vedeu.stubs(:trigger)
        }

        subject { instance.refresh }

        it 'stores the virtual cursor in place of the real cursor' do
          Vedeu::Cursors::Cursor.expects(:store)
          Vedeu.expects(:trigger).with(:_refresh_cursor_, _name)

          subject.must_be_instance_of(described)
        end
      end

      describe '#reset!' do
        let(:x)  { 11 }
        let(:y)  { 5 }
        let(:ox) { 4 }
        let(:oy) { 2 }

        subject { instance.reset! }

        it { subject.must_be_instance_of(described) }
        it { subject.x.must_equal(0) }
        it { subject.y.must_equal(0) }
        it { subject.ox.must_equal(0) }
        it { subject.oy.must_equal(0) }
      end

      describe '#right' do
        let(:x) { 11 }

        subject { instance.right }

        it { subject.must_be_instance_of(described) }

        it { subject.x.must_equal(12) }
      end

      describe '#to_s' do
        let(:x)  { 11 }
        let(:y)  { 5 }
        let(:ox) { 0 }
        let(:oy) { 0 }

        subject { instance.to_s }

        it { subject.must_be_instance_of(String) }

        it { subject.must_equal("\e[6;12H\e[?25h") }
      end

      describe '#to_str' do
        it { instance.must_respond_to(:to_str) }
      end

      describe '#up' do
        let(:y)    { 11 }
        let(:oy)   { 2 }
        let(:size) {}

        subject { instance.up(size) }

        it { subject.must_be_instance_of(described) }

        it { subject.y.must_equal(10) }
        it { subject.oy.must_equal(1) }
        it { subject.x.must_equal(0) }

        context 'when a size is given and x > size' do
          let(:x)    { 15 }
          let(:size) { 11 }

          it { subject.x.must_equal(11) }
        end
      end

      describe '#x' do
        subject { instance.x }

        it { subject.must_be_instance_of(Integer) }

        # @todo Add more tests.
        # it { skip }
      end

      describe '#y' do
        subject { instance.x }

        it { subject.must_be_instance_of(Integer) }

        # @todo Add more tests.
        # it { skip }
      end

    end # Cursor

  end # Editor

end # Vedeu
