# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Cursors

    describe Coordinate do

      let(:described)  { Vedeu::Cursors::Coordinate }
      let(:instance)   { described.new(attributes) }
      let(:attributes) {
        {
          geometry: geometry,
          offset:   offset,
          type:     type,
        }
      }
      let(:geometry)   {
        Vedeu::Geometries::Geometry.new(name: :vedeu_cursors_coordinate,
                                        x:    2,
                                        y:    3,
                                        xn:   10,
                                        yn:   6)
      }
      let(:offset)     {}
      let(:type)       {}

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@geometry').must_equal(geometry) }
        it { instance.instance_variable_get('@offset').must_equal(offset) }
        it { instance.instance_variable_get('@type').must_equal(type) }
      end

      describe '#dn_position' do
        subject { instance.dn_position }

        context 'when the type is x' do
          let(:type) { :x }

          context 'when d_dn is <= 0' do
            before { geometry.stubs(:bordered_width).returns(0) }

            it { subject.must_equal(0) }
          end

          context 'when d_dn > 0' do
            it { subject.must_equal(11) }
          end
        end

        context 'when the type is y' do
          let(:type) { :y }

          context 'when d_dn is <= 0' do
            before { geometry.stubs(:bordered_height).returns(0) }

            it { subject.must_equal(0) }
          end

          context 'when d_dn > 0' do
            it { subject.must_equal(7) }
          end
        end
      end

      describe '#d_position' do
        subject { instance.d_position }

        context 'when the type is x' do
          let(:type) { :x }

          context 'when the offset is <= 0' do
            let(:offset) { 0 }

            it { subject.must_equal(2) }
          end

          context 'when the offset is > dn_index' do
            let(:offset) { 0 }

            it { subject.must_equal(2) }
          end

          context 'when the offset is <= dn_index' do
            let(:offset) { 0 }

            it { subject.must_equal(2) }
          end
        end

        context 'when the type is y' do
          let(:type) { :y }

          context 'when the offset is <= 0' do
            let(:offset) { 0 }

            it { subject.must_equal(3) }
          end
        end
      end

    end # Coordinate

  end # Cursors

end # Vedeu
