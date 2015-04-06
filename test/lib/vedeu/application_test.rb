require 'test_helper'

module Vedeu

  describe Application do

    let(:described)     { Vedeu::Application }
    let(:instance)      { described.new(configuration) }
    let(:configuration) { Vedeu.configuration }

    before do
      configuration.stubs(:drb?).returns(false)
      Terminal.stubs(:open).returns([''])
    end

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@configuration').must_equal(configuration) }
    end

    describe '.start' do
      subject { described.start(configuration) }

      it { subject.must_be_instance_of(Array) }

      it { described.must_respond_to(:restart) }
    end

    describe '.stop' do
      subject { described.stop }

      it { subject.must_equal(false) }
    end

    describe '#start' do
      subject { instance.start }

      it { subject.must_be_instance_of(Array) }
    end

  end # Application

end # Vedeu
