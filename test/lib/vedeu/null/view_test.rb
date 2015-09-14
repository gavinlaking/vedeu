require 'test_helper'

module Vedeu

  module Null

    describe View do

      let(:described)  { Vedeu::Null::View }
      let(:instance)   { described.new(attributes) }
      let(:_name)      { 'vedeu_null_view' }
      let(:visible)    { false }
      let(:attributes) {
        {
          name:    _name,
          visible: visible,
        }
      }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@attributes').must_equal(attributes) }
        it { instance.instance_variable_get('@name').must_equal(_name) }
        it { instance.instance_variable_get('@visible').must_equal(visible) }
      end

    end # View

  end # Null

end # Vedeu
