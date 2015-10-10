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

        # it 'returns the DSL instance' do
        #   subject.must_be_instance_of(Vedeu::Repositories::ModelTestClass::DSL)
        # end
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
