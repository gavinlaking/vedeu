# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Distributed

    describe Subprocess do

      let(:described)   { Vedeu::Distributed::Subprocess }
      let(:instance)    { described.new(application) }
      let(:application) {}

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it do
          instance.instance_variable_get('@application').must_equal(application)
        end
        it { assert_nil(instance.instance_variable_get('@pid')) }
      end

      describe '.execute!' do
        it { described.must_respond_to(:execute!) }
      end

      describe '#execute!' do
        it { instance.must_respond_to(:execute!) }
      end

      describe '#kill' do
        before do
          Process.stubs(:kill)
          File.stubs(:unlink)
        end

        subject { instance.kill }

        it do
          Process.expects(:kill)
          File.expects(:unlink)
          subject
        end
      end

    end # Subprocess

  end # Distributed

end # Vedeu
