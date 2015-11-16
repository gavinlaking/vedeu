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

      describe '#enabled' do
        subject { instance.enabled? }

        it { subject.must_equal(false) }
      end

      describe '#render' do
        subject { instance.render }

        it { subject.must_be_instance_of(Array) }
        it { subject.must_equal([]) }
      end

    end # Null

  end # Borders

end # Vedeu
