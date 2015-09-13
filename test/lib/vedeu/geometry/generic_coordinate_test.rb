require 'test_helper'

module Vedeu

  module Geometry

    describe GenericCoordinate do

      let(:described)  { Vedeu::Geometry::GenericCoordinate }
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

    end # GenericCoordinate

  end # Geometry

end # Vedeu
