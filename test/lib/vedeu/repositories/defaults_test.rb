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

      let(:described)  { Vedeu::Repositories::Defaults }
      let(:includer)   { Vedeu::Repositories::DefaultsTestClass }
      let(:instance)   { includer.new(attributes) }
      let(:attributes) {
        {
          invalid_attribute: :invalid_value
        }
      }

      describe '#initialize' do
        it { instance.must_be_instance_of(includer) }
        it do
          instance.instance_variable_get('@some_attribute').
            must_equal(:some_value)
        end
        it do
          instance.instance_variables.
            must_equal([:@some_attribute])
        end

        context 'when the attributes is not a Hash' do
          let(:attributes) { :invalid }

          it { proc { instance }.must_raise(Vedeu::Error::InvalidSyntax) }
        end
      end

      # @todo Add more tests.

    end # Defaults

  end # Repositories

end # Vedeu
