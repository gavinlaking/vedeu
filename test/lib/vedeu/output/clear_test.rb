require 'test_helper'

module Vedeu

  describe Clear do

    let(:described) { Vedeu::Clear }
    let(:instance)  { described.new(interface) }
    let(:interface) { Vedeu::Interface.new({ name: 'xenon' }) }

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

    describe '#write' do
      subject { instance.write }
    end

  end # Clear

end # Vedeu
