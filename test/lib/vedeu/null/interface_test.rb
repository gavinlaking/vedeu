require 'test_helper'

module Vedeu

  module Null

    describe Interface do

      let(:described) { Vedeu::Null::Interface }
      let(:instance)  { described.new(attributes) }
      let(:attributes){
        {
          name: _name
        }
      }
      let(:_name)     { 'null_interface' }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it {
          instance.instance_variable_get('@attributes').must_equal(attributes)
        }
        it { instance.instance_variable_get('@name').must_equal(_name) }
      end

      describe 'accessors' do
        it { instance.must_respond_to(:name) }
        it { instance.must_respond_to(:attributes) }
        it { instance.must_respond_to(:visible) }
        it { instance.must_respond_to(:visible=) }
        it { instance.must_respond_to(:visible?) }
      end

      describe '#null' do
        it { instance.null.must_be_instance_of(NilClass) }

        it { instance.must_respond_to(:hide) }
        it { instance.must_respond_to(:parent) }
        it { instance.must_respond_to(:show) }
        it { instance.must_respond_to(:toggle) }
        it { instance.must_respond_to(:zindex) }
      end

      describe '#null?' do
        it { instance.null?.must_be_instance_of(TrueClass) }
      end

      describe '#store' do
        it { instance.store.must_be_instance_of(Vedeu::Null::Interface) }
      end

    end # Interface

  end # Null

end # Vedeu
