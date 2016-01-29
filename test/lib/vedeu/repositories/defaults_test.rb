# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Repositories

    class DefaultsTestClass

      include Vedeu::Repositories::Defaults

      private

      def defaults
        {
          some_attribute: :some_value
        }
      end

    end # DefaultsTestClass

    describe Defaults do

      let(:described)          { Vedeu::Repositories::Defaults }
      let(:included_described) { Vedeu::Repositories::DefaultsTestClass }
      let(:included_instance)  { included_described.new(attributes) }
      let(:attributes) {
        {
          invalid_attribute: :invalid_value
        }
      }

      describe '#initialize' do
        it { included_instance.must_be_instance_of(included_described) }
        it do
          included_instance.instance_variable_get('@some_attribute').
            must_equal(:some_value)
        end
        it do
          included_instance.instance_variables.
            must_equal([:@some_attribute])
        end

        context 'when the attributes is not a Hash' do
          let(:attributes) { :invalid }

          it do
            proc { included_instance }.must_raise(Vedeu::Error::InvalidSyntax)
          end
        end
      end

      # @todo Add more tests.

    end # Defaults

  end # Repositories

end # Vedeu
