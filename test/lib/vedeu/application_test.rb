require 'test_helper'

module Vedeu

  describe Application do

    let(:described)     { Vedeu::Application }
    let(:instance)      { described.new(configuration) }
    let(:configuration) { }

    before { Terminal.stubs(:open).returns(['']) }

    describe '#initialize' do
      subject { instance }

      it { return_type_for(subject, described) }
      it { subject.instance_variable_get('@configuration').must_equal(configuration) }
    end

    describe '.start' do
      subject { described.start(configuration) }

      it { return_type_for(subject, Array) }

      context 'alias method: .restart' do
        it { return_type_for(subject, Array) }
      end
    end

    describe '.stop' do
      subject { described.stop }

      it { proc { subject }.must_raise(StopIteration) }
    end

    describe '#start' do
      subject { instance.start }

      it { return_type_for(subject, Array) }
    end

  end # Application

end # Vedeu
