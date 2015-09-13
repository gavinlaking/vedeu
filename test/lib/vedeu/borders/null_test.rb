require 'test_helper'

module Vedeu

  module Borders

    describe Null do

      let(:described) { Vedeu::Borders::Null }
      let(:instance)  { described.new(attributes) }
      let(:attributes){
        {
          name: _name
        }
      }
      let(:_name)     { 'null_border' }
      let(:geometry)  {
        Vedeu::Geometry::Geometry.new(name: _name, x: 4, y: 6, xn: 10, yn: 12)
      }

      before { Vedeu.geometries.stubs(:by_name).returns(geometry) }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it {
          instance.instance_variable_get('@attributes').must_equal(attributes)
        }
        it { instance.instance_variable_get('@name').must_equal(_name) }
      end

      describe 'accessors' do
        it { instance.must_respond_to(:name) }
      end

      describe '#bx' do
        subject { instance.bx }

        it { subject.must_be_instance_of(Fixnum) }
        it { subject.must_equal(4) }
      end

      describe '#by' do
        subject { instance.by }

        it { subject.must_be_instance_of(Fixnum) }
        it { subject.must_equal(6) }
      end

      describe '#bxn' do
        subject { instance.bxn }

        it { subject.must_be_instance_of(Fixnum) }
        it { subject.must_equal(10) }
      end

      describe '#byn' do
        subject { instance.byn }

        it { subject.must_be_instance_of(Fixnum) }
        it { subject.must_equal(12) }
      end

      describe '#enabled?' do
        subject { instance.enabled? }

        it { subject.must_be_instance_of(FalseClass) }
      end

      describe '#height' do
        subject { instance.height }

        it { subject.must_be_instance_of(Fixnum) }
        it { subject.must_equal(7) }
      end

      describe '#null?' do
        subject { instance.null? }

        it { subject.must_be_instance_of(TrueClass) }
      end

      describe '#render' do
        subject { instance.render }

        it { subject.must_be_instance_of(Array) }
        it { subject.must_equal([]) }
      end

      describe '#width' do
        subject { instance.width }

        it { subject.must_be_instance_of(Fixnum) }
        it { subject.must_equal(7) }
      end

    end # Null

  end # Borders

end # Vedeu
