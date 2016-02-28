# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Repositories

    class ModelTestClass

      include Vedeu::Repositories::Model

      def initialize(attributes)
        @attributes = attributes
      end

      def store
        self
      end

    end # ModelTestClass

    describe Model do

      let(:described)          { Vedeu::Repositories::Model }
      let(:included_described) { Vedeu::Repositories::ModelTestClass }
      let(:included_instance)  { included_described.new(attributes) }
      let(:attributes) {
        {
          name: :vedeu_repositories_model
        }
      }

      describe '#repository' do
        it { included_instance.must_respond_to(:repository) }
      end

      describe '#repository=' do
        it { included_instance.must_respond_to(:repository=) }
      end

      describe '.build' do
        let(:attributes) {}

        subject { included_described.build(attributes) { } }

        # @todo Add more tests.
        # it { skip }
      end

      describe '.included' do
        subject { described.included(included_described) }

        it { subject.must_be_instance_of(Class) }
      end

      describe '.repository' do
        let(:klass) {}

        subject { included_described.repository(klass) }

        # @todo Add more tests.
        # it { skip }
      end

      describe '.store' do
        let(:klass) {}

        context 'when a block is given' do
          subject { included_described.store(klass) }
        end

        context 'when a block is not given' do
          subject { included_described.store(klass) { :some_proc } }
        end

        # @todo Add more tests.
        # it { skip }
      end

      describe '#store' do
        subject { included_instance.store }

        it 'returns the model' do
          subject.must_be_instance_of(included_described)
        end
      end

    end # Model

  end # Repositories

end # Vedeu
