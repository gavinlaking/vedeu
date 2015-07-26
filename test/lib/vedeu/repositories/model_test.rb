require 'test_helper'

module Vedeu

  module DSL

    class ModelTestClass

      include Vedeu::DSL::Presentation

      def initialize(model, client = nil)
        @model  = model
        @client = client
      end

      protected

      attr_reader :model

    end # ModelTestClass

  end # DSL

  describe Model do

    let(:described)  { ModelTestClass }
    let(:instance)   { described.new(attributes) }
    let(:attributes) {
      {
        name: 'hydrogen'
      }
    }

    describe 'accessors' do
      it { instance.must_respond_to(:repository) }
      it { instance.must_respond_to(:repository=) }
    end

    describe '.build' do
      let(:attributes) {}

      subject { described.build(attributes) { } }

      # @todo Add more tests.
      # it { skip }
    end

    describe '.by_name' do
      let(:_name) {}

      subject { described.by_name(_name) }

      context 'when the model has no repository set' do
        it { subject.must_be_instance_of(NilClass) }
      end

      context 'when the model has a repository set' do
        # @todo Add more tests.
        # it { skip }
      end
    end

    describe '.child' do
      let(:klass) {}

      subject { described.child(klass) }

      it { described.must_respond_to(:member) }
      it { described.must_respond_to(:collection) }

      # @todo Add more tests.
      # it { skip }
    end

    describe '.repository' do
      let(:klass) {}

      subject { described.repository(klass) }

      # @todo Add more tests.
      # it { skip }
    end

    describe '#deputy' do
      subject { instance.deputy }

      it 'returns the DSL instance' do
        subject.must_be_instance_of(DSL::ModelTestClass)
      end
    end

    describe '#store' do
      subject { instance.store }

      it 'returns the model' do
        subject.must_be_instance_of(ModelTestClass)
      end
    end

  end # Model

end # Vedeu
