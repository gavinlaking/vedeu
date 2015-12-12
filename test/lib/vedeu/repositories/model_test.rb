require 'test_helper'

module Vedeu

  module Repositories

    describe Model do

      let(:described)  { Vedeu::Repositories::ModelTestClass }
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

      describe '.repository' do
        let(:klass) {}

        subject { described.repository(klass) }

        # @todo Add more tests.
        # it { skip }
      end

      describe '.store' do
        let(:klass) {}

        context 'when a block is given' do
          subject { described.store(klass) }
        end

        context 'when a block is not given' do
          subject { described.store(klass) { :some_proc } }
        end

        # @todo Add more tests.
        # it { skip }
      end

      describe '#store' do
        subject { instance.store }

        it 'returns the model' do
          subject.must_be_instance_of(Vedeu::Repositories::ModelTestClass)
        end
      end

    end # Model

  end # Repositories

end # Vedeu
