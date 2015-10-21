require 'test_helper'

module Vedeu

  module Geometry

    describe Alignment do

      let(:described) { Vedeu::Geometry::Alignment }
      let(:instance)  { described.new(_value) }
      let(:_value)    {}

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@value').must_equal(_value) }
      end

      describe '.align' do
        subject { described.align(_value) }

        it { proc { subject }.must_raise(Vedeu::Error::NotImplemented) }
      end

      describe '#align' do
        subject { instance.align }

        it { proc { subject }.must_raise(Vedeu::Error::NotImplemented) }
      end

    end # Alignment

  end # Geometry

end # Vedeu
