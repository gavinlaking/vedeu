require 'test_helper'

module Vedeu

  module Null

  	describe View do

      let(:described)  { Vedeu::Null::View }
      let(:instance)   { described.new(attributes) }
      let(:attributes) {
        {
          name:    'vedeu_null_view',
          visible: true,
        }
      }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@attributes').must_equal(attributes) }
        it { instance.instance_variable_get('@name').must_equal('vedeu_null_view') }
        it { instance.instance_variable_get('@visible').must_equal(false) }
      end

      describe 'accessors' do
        it { instance.must_respond_to(:name) }
        it { instance.must_respond_to(:attributes) }
        it { instance.must_respond_to(:visible) }
        it { instance.must_respond_to(:visible=) }
        it { instance.must_respond_to(:visible?) }
      end

      describe '#null' do
        it { instance.null.must_equal(nil) }

        it { instance.must_respond_to(:parent) }
        it { instance.must_respond_to(:zindex) }
      end

      describe '#null?' do
        it { instance.null?.must_equal(true) }
      end

      describe '#store' do
        it { instance.store.must_equal(instance) }
      end

      describe '#visible?' do
        it { instance.visible?.must_equal(false) }
      end

  	end # View

  end # Null

end # Vedeu
