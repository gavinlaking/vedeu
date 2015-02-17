require 'test_helper'

module Vedeu

  module Distributed

    describe Server do

      let(:described) { Vedeu::Distributed::Server }
      let(:instance)  { described.new(uri, service) }
      let(:uri)       {}
      let(:service)   {}

      describe '#initialize' do
        subject { instance }

        it { subject.must_be_instance_of(described) }
        it { subject.instance_variable_get('@uri').must_equal(uri) }
        it { subject.instance_variable_get('@service').must_equal(service) }
      end

      describe '#start' do
      end

      describe '#stop' do
      end

    end # Server

  end # Distributed

end # Vedeu
