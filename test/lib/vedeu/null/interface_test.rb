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
      end

      describe '#hide' do
        subject { instance.hide }

        it { subject.must_be_instance_of(NilClass) }
      end

      describe '#null?' do
        subject { instance.null? }

        it { subject.must_be_instance_of(TrueClass) }
      end

      describe '#parent' do
        subject { instance.parent }

        it { subject.must_be_instance_of(NilClass) }
      end

      describe '#show' do
        subject { instance.show }

        it { subject.must_be_instance_of(NilClass) }
      end

      describe '#store' do
        subject { instance.store }

        it { subject.must_be_instance_of(Vedeu::Null::Interface) }
      end

      describe '#toggle' do
        subject { instance.toggle }

        it { subject.must_be_instance_of(NilClass) }
      end

      describe '#visible?' do
        subject { instance.visible? }

        it { subject.must_be_instance_of(FalseClass) }
      end

      describe '#visible=' do
        subject { instance.visible=(:irrelevant) }

        # @todo
        # it { skip }
        # it { subject.must_be_instance_of(FalseClass) }
      end

    end # Interface

  end # Null

end # Vedeu
