require 'test_helper'

module Vedeu

  describe Clear do

    let(:described) { Vedeu::Clear }
    let(:instance)  { described.new(interface, options) }
    let(:interface) { Vedeu::Interface.new(name: 'xenon', visible: visible) }
    let(:options)   {
      {

      }
    }
    let(:visible)   { true }
    let(:drb)       { false }

    before do
      Vedeu::Border.new(name: 'xenon').store
      Vedeu::Geometry.new(name: 'xenon', x: 1, y: 1, xn: 3, yn: 3).store
      Vedeu::Configuration.stubs(:drb?).returns(drb)
      Vedeu.renderers.stubs(:render)
    end

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@interface').must_equal(interface) }
      it { instance.instance_variable_get('@options').must_equal(options) }
    end

    describe 'alias methods' do
      it { described.must_respond_to(:render) }
    end

    describe '.clear' do
      subject { described.clear(interface, options) }

      context 'when the interface is visible' do
        context 'when DRb is enabled' do
          let(:drb) { true }
        end

        context 'when DRb is not enabled' do
        end
      end

      context 'when the interface is not visible' do
        let(:visible) { false }

        it { subject.must_be_instance_of(Array) }

        it { subject.must_equal([]) }
      end
    end

    describe '#clear' do
      subject { instance.clear }

      it { subject.must_be_instance_of(Array) }
      it { subject.flatten.size.must_equal(9) }

      context 'when the interface is visible' do
      end

      context 'when the interface is not visible' do
        let(:visible) { false }

        it { subject.must_equal([]) }
      end
    end

    describe '#write' do
      subject { instance.write }
    end

  end # Clear

end # Vedeu
