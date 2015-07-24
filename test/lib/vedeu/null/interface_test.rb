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

      describe '#hide' do
        it { instance.hide.must_be_instance_of(NilClass) }
      end

      describe '#null?' do
        it { instance.null?.must_be_instance_of(TrueClass) }
      end

      describe '#parent' do
        it { instance.parent.must_be_instance_of(NilClass) }
      end

      describe '#show' do
        it { instance.show.must_be_instance_of(NilClass) }
      end

      describe '#store' do
        it { instance.store.must_be_instance_of(Vedeu::Null::Interface) }
      end

      describe '#toggle' do
        it { instance.toggle.must_be_instance_of(NilClass) }
      end

    end # Interface

  end # Null

end # Vedeu
