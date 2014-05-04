require_relative '../../test_helper'

module Vedeu
  describe Interfaces do
    let(:klass)    { Interfaces }
    let(:instance) { klass.new {} }
    let(:block)    {}

    subject { instance }

    it { subject.must_be_instance_of(Vedeu::Interfaces) }

    describe '#add' do
      let(:interface_name)  {}
      let(:interface_klass) {}
      let(:options)         { {} }

      subject { instance.add(interface_name, interface_klass, options) }
    end

    describe '#show' do
      subject { instance.show }
    end

    describe '#run' do
      subject { instance.run }
    end
  end
end
