require 'test_helper'

module Vedeu

  module Geometries

    describe Coordinate do

      let(:described)  { Vedeu::Geometries::Coordinate }
      let(:instance)   { described.new(attributes) }
      let(:attributes) {
        {
          name:   _name,
          offset: offset,
          type:   type,
        }
      }
      let(:_name)  {}
      let(:offset) {}
      let(:type)   {}

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@name').must_equal(_name) }
        it { instance.instance_variable_get('@offset').must_equal(offset) }
        it { instance.instance_variable_get('@type').must_equal(type) }
      end

      describe '#dn' do
        subject { instance.dn }

        # it { skip }
      end

      describe '#position' do
        subject { instance.position }

        # it { skip }
      end

      # let(:described) { Vedeu::Geometries::Coordinate }
      # let(:instance)  { described.new(_name, oy, ox) }
      # let(:_name)     { 'coordinate' }
      # let(:oy)        { 0 }
      # let(:ox)        { 0 }
      # let(:height)    { 6 }
      # let(:width)     { 6 }
      # let(:x)         { 7 }
      # let(:y)         { 5 }
      # let(:border)    { Vedeu::Borders::Border.new(name: _name, enabled: true) }
      # let(:geometry)  {
      #   Vedeu::Geometries::Geometry.new(name:   _name,
      #                                 height: height,
      #                                 width:  width,
      #                                 x:      x,
      #                                 y:      y)
      # }

      # before do
      #   Vedeu.borders.stubs(:by_name).returns(border)
      #   Vedeu.geometries.stubs(:by_name).returns(geometry)
      # end

      # describe '#initialize' do
      #   it { instance.must_be_instance_of(described) }
      #   it { instance.instance_variable_get('@name').must_equal(_name) }
      #   it { instance.instance_variable_get('@oy').must_equal(oy) }
      #   it { instance.instance_variable_get('@ox').must_equal(ox) }
      # end

      # describe '#yn' do
      #   subject { instance.yn }

      #   context 'when the height is <= to 0' do
      #     let(:height) { 0 }

      #     it { subject.must_equal(0) }
      #   end

      #   context 'when the height is > 0' do
      #     it { subject.must_equal(9) }
      #   end
      # end

      # describe '#xn' do
      #   subject { instance.xn }

      #   context 'when the width is <= to 0' do
      #     let(:width) { 0 }

      #     it { subject.must_equal(0) }
      #   end

      #   context 'when the width is > 0' do
      #     it { subject.must_equal(11) }
      #   end
      # end

      # describe '#y' do
      #   let(:oy)  { 0 }

      #   subject { instance.y }

      #   it { subject.must_be_instance_of(Fixnum) }

      #   context 'with a negative index' do
      #     let(:oy) { -3 }

      #     it { subject.must_equal(6) }
      #   end

      #   context 'with an index greater than the maximum index for y' do
      #     let(:oy) { 9 }

      #     it { subject.must_equal(9) }

      #     context 'but the height is negative' do
      #       let(:height) { -2 }

      #       it { subject.must_equal(1) }
      #     end
      #   end

      #   context 'with an index within range' do
      #     let(:oy) { 3 }

      #     it { subject.must_equal(8) }
      #   end
      # end

      # describe '#x' do
      #   let(:ox)  { 0 }

      #   subject { instance.x }

      #   it { subject.must_be_instance_of(Fixnum) }

      #   context 'with a negative index' do
      #     let(:ox) { -3 }

      #     it { subject.must_equal(8) }
      #   end

      #   context 'with an index greater than the maximum index for x' do
      #     let(:ox) { 9 }

      #     it { subject.must_equal(11) }

      #     context 'but the width is negative' do
      #       let(:width) { -2 }

      #       it { subject.must_equal(3) }
      #     end
      #   end

      #   context 'with an index within range' do
      #     let(:ox) { 3 }

      #     it { subject.must_equal(10) }
      #   end
      # end

    end # Coordinate

  end # Geometries

end # Vedeu
