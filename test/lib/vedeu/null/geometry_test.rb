require 'test_helper'

module Vedeu

  module Null

    describe Geometry do

      let(:described) { Vedeu::Null::Geometry }
      let(:instance)  { described.new(attributes) }
      let(:attributes){
        {
          name: _name
        }
      }
      let(:_name)     { 'null_geometry' }

      before { Vedeu::Terminal.stubs(:size).returns([25, 40]) }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it {
          instance.instance_variable_get('@attributes').must_equal(attributes)
        }
        it { instance.instance_variable_get('@name').must_equal(_name) }
      end

      describe '#maximised' do
        it { instance.must_respond_to(:maximised) }
      end

      describe '#maximised=' do
        it { instance.must_respond_to(:maximised=) }
      end

      describe '#name' do
        it { instance.must_respond_to(:name) }
      end

      describe '#null?' do
        subject { instance.null? }

        it { subject.must_be_instance_of(TrueClass) }
      end

      describe '#centred' do
        subject { instance.centred }

        it { subject.must_equal(false) }
      end

      describe '#maximise' do
        subject { instance.maximise }

        it { subject.must_equal(false) }
      end

      describe '#store' do
        subject { instance.store }

        it { subject.must_be_instance_of(described) }
      end

      describe '#unmaximise' do
        subject { instance.unmaximise }

        it { subject.must_equal(false) }
      end

      describe '#height' do
        it { instance.height.must_equal(25) }
      end

      describe '#width' do
        it { instance.width.must_equal(40) }
      end

      describe '#x' do
        it { instance.x.must_equal(1) }
      end

      describe '#xn' do
        it { instance.xn.must_equal(40) }
      end

      describe '#y' do
        it { instance.y.must_equal(1) }
      end

      describe '#yn' do
        it { instance.yn.must_equal(25) }
      end

    end # Geometry

  end # Null

end # Vedeu
