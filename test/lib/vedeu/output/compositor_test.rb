require 'test_helper'

module Vedeu

  # TODO: Leak detected. (GL 2015-01-28)

  describe Compositor do

    let(:described) { Vedeu::Compositor }
    let(:instance)  { described.new(_name) }
    let(:_name)     { 'compositor' }
    let(:buffer)    { Buffer.new(_name, interface) }
    let(:interface) {
      Vedeu.interface(_name) do
        border!
        geometry do
          height 5
          width  10
        end
        lines do
          line 'Some text.'
        end
      end
    }

    before do
      IO.console.stubs(:print)

      Vedeu.buffers.reset
      Vedeu.interfaces.reset
      Buffer.new(_name, interface).store
    end

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@name').must_equal(_name) }
    end

    describe '.compose' do
      subject { described.compose(_name) }

      it { subject.must_be_instance_of(Array) }
      it { subject.first.must_be_instance_of(Vedeu::Interface) }
    end

  end # Compositor

end # Vedeu
