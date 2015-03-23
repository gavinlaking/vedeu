require 'test_helper'

module Vedeu

  describe Clear do

    let(:described) { Vedeu::Clear }
    let(:instance)  { described.new(interface) }
    let(:interface) { Vedeu::Interface.new({ name: 'xenon' }) }
    let(:geometry)  { Vedeu::Geometry.new({ x: 1, y: 1, xn: 3, yn: 3 })}

    before { interface.stubs(:geometry).returns(geometry) }

    describe '#initialize' do
      it { instance.must_be_instance_of(Vedeu::Clear) }
      it { instance.instance_variable_get('@interface').must_equal(interface) }
    end

    describe 'alias methods' do
      it { described.must_respond_to(:render) }
    end

    describe '.clear' do
      subject { described.clear(interface) }
    end

    describe '#clear' do
      subject { instance.clear }

      it { subject.must_be_instance_of(Array) }
      it { subject.flatten.size.must_equal(9) }
    end

    describe '#write' do
      subject { instance.write }
    end

  end # Clear

end # Vedeu
