require 'test_helper'

module Vedeu

  module Distributed

    describe Client do

      let(:described) { Vedeu::Distributed::Client }
      let(:instance)  { described.new(uri) }
      let(:uri)       { 'druby://localhost:21420' }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@uri').must_equal('druby://localhost:21420') }
      end

      describe '.connect' do
        subject { described.connect(uri) }

        it { subject.must_be_instance_of(Symbol) }
      end

      describe '#input' do
        let(:data) {}

        subject { instance.input(data) }

        it { instance.must_respond_to(:read) }
      end

      describe '#output' do
        subject { instance.output }

        it { instance.must_respond_to(:write) }
      end

      describe '#shutdown' do
        subject { instance.shutdown }
      end

    end # Client

  end # Distributed

end # Vedeu
