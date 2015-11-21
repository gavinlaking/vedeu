require 'test_helper'

module Vedeu

  module Geometries

    describe Geometry do

      let(:described)  { Vedeu::Geometries::Geometry }
      let(:instance)   { described.new(attributes) }
      let(:attributes) {
        {
          client:               client,
          height:               height,
          horizontal_alignment: horizontal_alignment,
          maximised:            maximised,
          name:                 _name,
          repository:           Vedeu.geometries,
          vertical_alignment:   vertical_alignment,
          width:                width,
          x:                    x,
          xn:                   xn,
          y:                    y,
          yn:                   yn,
        }
      }
      let(:client)               {}
      let(:height)               {}
      let(:horizontal_alignment) {}
      let(:maximised)            { false }
      let(:_name)                { 'vedeu_geometry_geometry' }
      let(:vertical_alignment)   {}
      let(:width)                {}
      let(:x)                    {}
      let(:xn)                   {}
      let(:y)                    {}
      let(:yn)                   {}

      before { Vedeu::Terminal.stubs(:size).returns([12, 40]) }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@client').must_equal(client) }
        it { instance.instance_variable_get('@height').must_equal(height) }
        it { instance.instance_variable_get('@horizontal_alignment').
          must_equal(horizontal_alignment) }
        it { instance.instance_variable_get('@maximised').
          must_equal(maximised) }
        it { instance.instance_variable_get('@name').must_equal(_name) }
        it { instance.instance_variable_get('@vertical_alignment').
          must_equal(vertical_alignment) }
        it { instance.instance_variable_get('@width').must_equal(width) }
        it { instance.instance_variable_get('@x').must_equal(x) }
        it { instance.instance_variable_get('@xn').must_equal(xn) }
        it { instance.instance_variable_get('@y').must_equal(y) }
        it { instance.instance_variable_get('@yn').must_equal(yn) }
        it do
          instance.instance_variable_get('@repository').
            must_equal(Vedeu.geometries)
        end
      end

      describe 'accessors' do
        it {
          instance.must_respond_to(:name)
          instance.must_respond_to(:name=)
          instance.must_respond_to(:height=)
          instance.must_respond_to(:horizontal_alignment)
          instance.must_respond_to(:horizontal_alignment=)
          instance.must_respond_to(:maximised)
          instance.must_respond_to(:maximised?)
          instance.must_respond_to(:maximised=)
          instance.must_respond_to(:vertical_alignment)
          instance.must_respond_to(:vertical_alignment=)
          instance.must_respond_to(:width=)
          instance.must_respond_to(:x=)
          instance.must_respond_to(:xn=)
          instance.must_respond_to(:y=)
          instance.must_respond_to(:yn=)
        }
      end

      describe '#attributes' do
        subject { instance.attributes }

        it { subject.must_be_instance_of(Hash) }

        # @todo Add more tests.
        # it { skip }
      end

      describe '#deputy' do
        subject { instance.deputy }

        it 'returns the DSL instance' do
          subject.must_be_instance_of(Vedeu::Geometries::DSL)
        end
      end

      describe '#eql?' do
        let(:other) { instance }

        subject { instance.eql?(other) }

        it { subject.must_equal(true) }

        context 'when different to other' do
          let(:other) { described.new(name: 'other_geometry') }

          it { subject.must_equal(false) }
        end
      end

      describe '#maximise' do
        let(:attributes) {
          {
            height:    6,
            maximised: false,
            name:      'maximise',
            width:     18
          }
        }

        before { Vedeu.stubs(:trigger) }

        subject { instance.maximise }

        it { subject.must_be_instance_of(described) }
        it { subject.maximised.must_equal(true) }
      end

      describe '#unmaximise' do
        let(:attributes) {
          {
            height:    6,
            maximised: true,
            name:      'unmaximise',
            width:     18
          }
        }

        before { Vedeu.stubs(:trigger) }

        subject { instance.unmaximise }

        it { subject.must_be_instance_of(described) }
        it { subject.maximised.must_equal(false) }
      end

      describe '#top, #right, #bottom, #left' do
        context 'maximised' do
          let(:attributes) { { maximised: true } }

          it { instance.top.must_equal(1) }
          it { instance.right.must_equal(40) }
          it { instance.bottom.must_equal(12) }
          it { instance.left.must_equal(1) }
        end
      end

      describe '#maximise' do
        let(:attributes) { { maximised: true } }

        subject { instance.maximise }

        it { instance.top.must_equal(1) }
        it { instance.right.must_equal(40) }
        it { instance.bottom.must_equal(12) }
        it { instance.left.must_equal(1) }
      end

      describe '#unmaximise' do
        let(:attributes) { { maximised: false } }

        subject { instance.unmaximise }

        it { instance.top.must_equal(1) }
        it { instance.right.must_equal(40) }
        it { instance.bottom.must_equal(12) }
        it { instance.left.must_equal(1) }
      end

    end # Geometry

  end # Geometries

end # Vedeu
