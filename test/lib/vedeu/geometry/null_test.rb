require 'test_helper'

module Vedeu

  module Geometry

    describe Null do

      let(:described) { Vedeu::Geometry::Null }
      let(:instance)  { described.new(attributes) }
      let(:attributes){
        {
          name: _name
        }
      }
      let(:_name)     { 'null_geometry' }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it {
          instance.instance_variable_get('@attributes').must_equal(attributes)
        }
        it { instance.instance_variable_get('@name').must_equal(_name) }
      end

      describe 'accessors' do
        it { instance.must_respond_to(:maximised) }
        it { instance.must_respond_to(:maximised=) }
        it { instance.must_respond_to(:name) }
      end

      describe '#height' do
        before { Vedeu::Terminal.stubs(:size).returns([25, 40]) }

        it { instance.height.must_equal(25) }
      end

      describe '#width' do
        before { Vedeu::Terminal.stubs(:size).returns([25, 40]) }

        it { instance.width.must_equal(40) }
      end

      describe '#x' do
        before { Vedeu::Terminal.stubs(:size).returns([25, 40]) }

        it { instance.x.must_equal(1) }
      end

      describe '#xn' do
        before { Vedeu::Terminal.stubs(:size).returns([25, 40]) }

        it { instance.xn.must_equal(40) }
      end

      describe '#y' do
        before { Vedeu::Terminal.stubs(:size).returns([25, 40]) }

        it { instance.y.must_equal(1) }
      end

      describe '#yn' do
        before { Vedeu::Terminal.stubs(:size).returns([25, 40]) }

        it { instance.yn.must_equal(25) }
      end

    end # Null

  end # Geometry

end # Vedeu
