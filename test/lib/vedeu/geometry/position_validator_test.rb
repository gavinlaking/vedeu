require 'test_helper'

module Vedeu

  describe PositionValidator do

    let(:described) { Vedeu::PositionValidator }
    let(:instance)  { described.new(_name, x, y) }
    let(:_name)     {}
    let(:x)         {}
    let(:y)         {}

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@name').must_equal(_name) }
      it { instance.instance_variable_get('@x').must_equal(x) }
      it { instance.instance_variable_get('@y').must_equal(y) }
    end

    describe '.validate' do
      subject { described.validate(_name, x, y) }

      it { instance.must_be_instance_of(described) }
    end

    describe '#y' do
      subject { described.validate(_name, x, y).y }
    end

    describe '#x' do
      subject { described.validate(_name, x, y).x }
    end

  end # PositionValidator

end # Vedeu
