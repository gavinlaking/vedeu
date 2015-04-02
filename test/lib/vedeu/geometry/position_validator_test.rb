require 'test_helper'

module Vedeu

  describe PositionValidator do

    let(:described) { Vedeu::PositionValidator }
    let(:instance)  { described.new(interface, x, y) }
    let(:interface) {}
    let(:x)         {}
    let(:y)         {}

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@interface').must_equal(interface) }
      it { instance.instance_variable_get('@x').must_equal(x) }
      it { instance.instance_variable_get('@y').must_equal(y) }
    end

    describe '.validate' do
      subject { described.validate(interface, x, y) }

      it { instance.must_be_instance_of(described) }
    end

  end # PositionValidator

end # Vedeu
