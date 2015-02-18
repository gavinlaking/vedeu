require 'test_helper'

module Vedeu

  describe Application do

    let(:described)     { Vedeu::Application }
    let(:instance)      { described.new(configuration) }
    let(:configuration) { }

    before { Terminal.stubs(:open).returns(['']) }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@configuration').must_equal(configuration) }
    end

    describe '.start' do
      subject { described.start(configuration) }

      it { subject.must_be_instance_of(Array) }

      context 'alias method: .restart' do
        it { subject.must_be_instance_of(Array) }
      end
    end

    describe '.stop' do
      subject { described.stop }

      it { proc { subject }.must_raise(StopIteration) }
    end

    describe '#start' do
      subject { instance.start }

      it { subject.must_be_instance_of(Array) }
    end

  end # Application

end # Vedeu
