require 'test_helper'

module Vedeu

  module Repositories

    describe Cache do

      let(:described) { Vedeu::Repositories::Cache }
      let(:instance)  { described.new }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
      end

      describe '#add' do
        let(:resource) {}
        let(:options)  { {} }

        subject { instance.add(resource, options) }

        it { instance.must_respond_to(:add) }
      end

      describe '#clear' do
        subject { instance.clear }

        it { instance.must_respond_to(:clear) }
      end

      describe '#read' do
        let(:resource) {}

        subject { instance.read(resource) }

        it { instance.must_respond_to(:read) }
      end

      describe '#remove' do
        let(:resource) {}

        subject { instance.remove(resource) }

        it { instance.must_respond_to(:remove) }
      end

    end # Cache

  end # Repositories

end # Vedeu
