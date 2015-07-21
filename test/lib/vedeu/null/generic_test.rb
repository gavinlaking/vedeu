require 'test_helper'

module Vedeu

  module Null

    describe Generic do

      let(:described) { Vedeu::Null::Generic }
      let(:instance)  { described.new(attributes) }
      let(:attributes){
        {
          name: _name
        }
      }
      let(:_name) { 'null_generic' }

      describe 'alias methods' do
        it { instance.must_respond_to(:visible?) }
      end

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it {
          instance.instance_variable_get('@attributes').must_equal(attributes)
        }
      end

      describe '#add' do
        subject { instance.add }

        it { subject.must_be_instance_of(NilClass) }
      end

      describe '#colour' do
        subject { instance.colour }

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

      describe '#store' do
        subject { instance.store }

        it { subject.must_be_instance_of(described) }
      end

      describe '#style' do
        subject { instance.style }

        it { subject.must_be_instance_of(NilClass) }
      end

      describe '#visible' do
        subject { instance.visible }

        it { subject.must_be_instance_of(FalseClass) }
      end

      describe '#visible=' do
        let(:_value) { :ignored }

        subject { instance.visible = (_value) }

        # This should be FalseClass, I'm explicitly returning false in the method.
        it { subject.must_be_instance_of(Symbol) }
      end

    end # Generic

  end # Null

end # Vedeu
