require 'test_helper'

module Vedeu

  module Null

    describe Interface do

      let(:described)  { Vedeu::Null::Interface }
      let(:instance)   { described.new(attributes) }
      let(:_name)      { 'null_interface' }
      let(:attributes) {
        {
          name: _name
        }
      }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it {
          instance.instance_variable_get('@attributes').must_equal(attributes)
        }
        it { instance.instance_variable_get('@name').must_equal(_name) }
      end

    end # Interface

  end # Null

end # Vedeu
