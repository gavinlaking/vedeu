require 'test_helper'

module Vedeu

  module Null

    describe Menu do

      let(:described)  { Vedeu::Null::Menu }
      let(:instance)   { described.new(attributes) }
      let(:attributes) {
        {
          name: _name
        }
      }
      let(:_name) { 'null_geometry' }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it {
          instance.instance_variable_get('@attributes').must_equal(attributes)
        }
        it { instance.instance_variable_get('@name').must_equal(_name) }
      end

      describe 'alias methods' do
        it { instance.must_respond_to(:bottom_item) }
        it { instance.must_respond_to(:current_item) }
        it { instance.must_respond_to(:deselect_item) }
        it { instance.must_respond_to(:items) }
        it { instance.must_respond_to(:next_item) }
        it { instance.must_respond_to(:prev_item) }
        it { instance.must_respond_to(:select_item) }
        it { instance.must_respond_to(:selected_item) }
        it { instance.must_respond_to(:top_item) }
        it { instance.must_respond_to(:view) }
      end

      describe '#item' do
        it { instance.item.must_equal(nil) }
      end

    end # Menu

  end # Null

end # Vedeu
