require 'test_helper'

module Vedeu

  describe Subprocess do

    let(:described)   { Vedeu::Subprocess }
    let(:instance)    { described.new(application) }
    let(:application) {}

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it do
        instance.instance_variable_get('@application').must_equal(application)
      end
      it { instance.instance_variable_get('@pid').must_equal(nil) }
    end

    describe '.execute!' do
      it { described.must_respond_to(:execute!) }
    end

    describe '#execute!' do
      it { instance.must_respond_to(:execute!) }
    end

    describe '#kill' do
      it { instance.must_respond_to(:kill) }
    end

  end # Subprocess

end # Vedeu
