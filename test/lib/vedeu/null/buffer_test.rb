require 'test_helper'

module Vedeu

  module Null

    describe Buffer do

      let(:described) { Vedeu::Null::Buffer }
      let(:instance)  { described.new(attributes) }
      let(:attributes){
        {
          name: _name
        }
      }
      let(:_name)     { 'null_buffer' }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it {
          instance.instance_variable_get('@attributes').must_equal(attributes)
        }
        it { instance.instance_variable_get('@name').must_equal(_name) }
      end

      describe '#null' do
        subject { instance.null }

        it { subject.must_be_instance_of(NilClass) }

        it { instance.must_respond_to(:clear) }
        it { instance.must_respond_to(:hide) }
        it { instance.must_respond_to(:render) }
        it { instance.must_respond_to(:show) }
        it { instance.must_respond_to(:toggle) }
      end

      describe '#null?' do
        subject { instance.null? }

        it { subject.must_be_instance_of(TrueClass) }
      end

    end # Buffer

  end # Null

end # Vedeu
