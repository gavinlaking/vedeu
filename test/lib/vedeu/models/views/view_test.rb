require 'test_helper'

module Vedeu

  module Views

  	describe View do

      let(:described)  { Vedeu::Views::View }
      let(:instance)   { described.new(attributes) }
      let(:attributes) {
        {
          name: _name,
        }
      }
      let(:_name)      { 'Vedeu::Views::View' }

      describe '#store_immediate' do
        subject { instance.store_immediate }

        it { subject.must_be_instance_of(described) }
      end

      describe '#store_deferred' do
        subject { instance.store_deferred }

        it { subject.must_be_instance_of(described) }

        context 'when the name is not defined' do
          let(:_name) {}

          it { proc { subject }.must_raise(Vedeu::InvalidSyntax) }
        end
      end

  	end # View

  end # Views

end # Vedeu
