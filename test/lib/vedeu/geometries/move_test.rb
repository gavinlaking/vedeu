# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Geometries

    describe Move do

      let(:described)  { Vedeu::Geometries::Move }
      let(:instance)   { described.new(attributes) }
      let(:direction)  {}
      let(:_name)      { :vedeu_geometries_move }
      let(:offset)     { 1 }
      let(:attributes) {
        {
          direction: direction,
          name:      _name,
          offset:    offset,
        }
      }
      let(:geometry)   {
        Vedeu::Geometries::Geometry.new(name: _name, x: 2, xn: 8, y: 2, yn: 8)
      }

      before { Vedeu.stubs(:trigger).with(:_movement_refresh_, _name) }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }

        context 'when a direction is given' do
          let(:direction) { :left }

          it do
            instance.instance_variable_get('@direction').must_equal(direction)
          end
        end

        context 'when a direction is not given' do
          it { instance.instance_variable_get('@direction').must_equal(:none) }
        end

        context 'when a name is given' do
          it { instance.instance_variable_get('@name').must_equal(_name) }
        end

        context 'when a name is not given' do
          let(:_name) {}

          it { assert_nil(instance.instance_variable_get('@name')) }
        end

        context 'when an offset is given' do
          let(:offset) { 2 }

          it { instance.instance_variable_get('@offset').must_equal(offset) }
        end

        context 'when an offset is not given' do
          it { instance.instance_variable_get('@offset').must_equal(1) }
        end
      end

      describe '.move' do
        before do
          Vedeu.geometries.stubs(:by_name).with(_name).returns(geometry)
          Vedeu.stubs(:height).returns(10)
          Vedeu.stubs(:width).returns(10)
        end

        subject { described.move(attributes) }

        context 'when the direction is :down' do
          let(:direction) { :down }

          before do
            Vedeu.stubs(:trigger).with(:_cursor_down_, _name, 0)
          end

          context 'when y + offset > terminal height' do
            let(:offset) { 3 }

            it { subject.must_equal(false) }
          end

          context 'when y + offset <= terminal height' do
            it { subject.must_be_instance_of(Vedeu::Geometries::Geometry) }
            it { subject.x.must_equal(2) }
            it { subject.xn.must_equal(8) }
            it { subject.y.must_equal(3) }
            it { subject.yn.must_equal(9) }
          end
        end

        context 'when the direction is :left' do
          let(:direction) { :left }

          before do
            Vedeu.stubs(:trigger).with(:_cursor_left_, _name, 0)
          end

          context 'when x - offset < 1' do
            let(:offset) { 3 }

            it { subject.must_equal(false) }
          end

          context 'when x - offset >= 1' do
            it { subject.must_be_instance_of(Vedeu::Geometries::Geometry) }
            it { subject.x.must_equal(1) }
            it { subject.xn.must_equal(7) }
            it { subject.y.must_equal(2) }
            it { subject.yn.must_equal(8) }
          end
        end

        context 'when the direction is :none' do
          let(:direction) { :none }
          let(:offset)    { 1 }

          it { subject.must_equal(false) }
        end

        context 'when the direction is :origin' do
          let(:direction) { :origin }

          before do
            Vedeu.stubs(:trigger).with(:_cursor_origin_, _name)
          end

          it { subject.must_be_instance_of(Vedeu::Geometries::Geometry) }
          it { subject.x.must_equal(1) }
          it { subject.xn.must_equal(7) }
          it { subject.y.must_equal(1) }
          it { subject.yn.must_equal(7) }
        end

        context 'when the direction is :right' do
          let(:direction) { :right }

          before do
            Vedeu.stubs(:trigger).with(:_cursor_right_, _name, 0)
          end

          context 'when xn + offset > terminal width' do
            let(:offset) { 3 }

            it { subject.must_equal(false) }
          end

          context 'when xn + offset <= terminal width' do
            it { subject.must_be_instance_of(Vedeu::Geometries::Geometry) }
            it { subject.x.must_equal(3) }
            it { subject.xn.must_equal(9) }
            it { subject.y.must_equal(2) }
            it { subject.yn.must_equal(8) }
          end
        end

        context 'when the direction is :up' do
          let(:direction) { :up }

          before do
            Vedeu.stubs(:trigger).with(:_cursor_up_, _name, 0)
          end

          context 'when y - offset < 1' do
            let(:offset) { 3 }

            it { subject.must_equal(false) }
          end

          context 'when y - offset >= 1' do
            it { subject.must_be_instance_of(Vedeu::Geometries::Geometry) }
            it { subject.x.must_equal(2) }
            it { subject.xn.must_equal(8) }
            it { subject.y.must_equal(1) }
            it { subject.yn.must_equal(7) }
          end
        end

        context 'when the direction is invalid' do
          let(:direction) { :invalid }
          let(:offset)    { 1 }

          it { subject.must_equal(false) }
        end
      end

      describe '#move' do
        it { instance.must_respond_to(:move) }
      end

    end # Move

  end # Geometries

end # Vedeu
