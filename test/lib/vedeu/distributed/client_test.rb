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

      describe '.connect' do
        subject { described.connect(uri) }

        it { subject.must_be_instance_of(described) }
      end

      describe '#input' do
        let(:data) {}

        subject { instance.input(data) }
      end

      describe '#output' do
        subject { instance.output }
      end

      describe '#shutdown' do
        subject { instance.shutdown }
      end

    end # Client

  end # Distributed

end # Vedeu
