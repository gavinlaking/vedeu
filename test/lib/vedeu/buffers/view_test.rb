# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Buffers

    describe View do

      let(:described)  { Vedeu::Buffers::View }
      let(:instance)   { described.new(attributes) }
      let(:_name)      { :vedeu_buffers_view }
      let(:attributes) {
        {
          name: _name,
        }
      }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }

        context 'when a name is given' do
          it { instance.instance_variable_get('@name').must_equal(_name) }
        end

        context 'when a name is not given' do
          let(:_name) {}

          it { assert_nil(instance.instance_variable_get('@name')) }
        end
      end

      describe '#attributes' do
        subject { instance.attributes }

        it { subject.must_be_instance_of(Hash) }
        it { subject.must_equal(attributes) }
      end

      describe '#each' do
        # @todo Add more tests.
      end

      describe '#reset!' do
        subject { instance.reset! }

        it { subject.must_be_instance_of(described) }
      end

      describe '#update' do
        let(:value_or_values) {}

        subject { instance.update(value_or_values) }

        it { subject.must_be_instance_of(described) }

        context 'when given a single value' do
          let(:value_or_values) {}

          context 'when the value is valid' do
            # @todo Add more tests.
          end

          context 'when the value is not valid' do
            # @todo Add more tests.
          end
        end

        context 'when given multiple values' do
          let(:value_or_values) {}

          context 'when the value is valid' do
            # @todo Add more tests.
          end

          context 'when the value is not valid' do
            # @todo Add more tests.
          end
        end
      end

    end # View

  end # Buffers

end # Vedeu
