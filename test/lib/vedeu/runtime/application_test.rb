# frozen_string_literal: true

require 'test_helper'

module Vedeu

  describe 'Bindings' do
    it { Vedeu.bound?(:_exit_).must_equal(true) }
    it { Vedeu.bound?(:_mode_switch_).must_equal(true) }
    it { Vedeu.bound?(:_cleanup_).must_equal(true) }
  end

  module Runtime

    describe Application do

      let(:described)     { Vedeu::Runtime::Application }
      let(:instance)      { described.new }

      before do
        Vedeu.config.stubs(:drb?).returns(false)
        Vedeu::Terminal.stubs(:open).returns([''])

        Vedeu.stubs(:trigger)
      end

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
      end

      describe '.restart' do
        subject { described.restart }

        it { subject.must_be_instance_of(Array) }
      end

      describe '.start' do
        subject { described.start }

        it { subject.must_be_instance_of(Array) }
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

  end # Runtime

end # Vedeu
