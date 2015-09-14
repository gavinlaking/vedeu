require 'test_helper'

module Vedeu

  module Null

    describe Menu do

      let(:described)  { Vedeu::Null::Menu }
      let(:instance)   { described.new(attributes) }
      let(:_name)      { 'null_menu' }
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

    end # Menu

  end # Null

end # Vedeu
