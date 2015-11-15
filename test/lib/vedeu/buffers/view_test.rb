require 'test_helper'

module Vedeu

  module Buffers

    describe View do

      let(:described)  { Vedeu::Buffers::View }
      let(:instance)   { described.new(attributes) }
      let(:_name)      { 'Vedeu::Buffers::View' }
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

          it { instance.instance_variable_get('@name').must_equal('') }
        end
      end

      # @todo Add more tests.

    end # View

  end # Buffers

end # Vedeu
