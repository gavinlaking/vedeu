require 'test_helper'

module Vedeu

  module Distributed

    describe Client do

      let(:described) { Vedeu::Distributed::Client }
      let(:instance)  { described.new(uri) }
      let(:uri)       {}

      describe '#initialize' do
        subject { instance }

        it { subject.must_be_instance_of(described) }
        it { subject.instance_variable_get('@uri').must_equal('') }
      end

      describe '#input' do
      end

      describe '#output' do
      end

      describe '#start' do
      end

      describe '#stop' do
      end

    end # Client

  end # Distributed

end # Vedeu
