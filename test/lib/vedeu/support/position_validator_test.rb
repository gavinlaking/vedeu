require 'test_helper'

module Vedeu

  describe PositionValidator do

    let(:described) { Vedeu::PositionValidator }
    let(:instance)  { described.new(interface, x, y) }
    let(:interface) {}
    let(:x)         {}
    let(:y)         {}

    describe '#initialize' do
      subject { instance }

      it { subject.must_be_instance_of(described) }
      it { subject.instance_variable_get('@interface').must_equal(interface) }
      it { subject.instance_variable_get('@x').must_equal(x) }
      it { subject.instance_variable_get('@y').must_equal(y) }
    end

  end # PositionValidator

end # Vedeu
