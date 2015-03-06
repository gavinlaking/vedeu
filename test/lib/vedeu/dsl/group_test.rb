require 'test_helper'

module Vedeu

  module DSL

    describe Group do

      let(:described)  { Vedeu::DSL::Group }
      let(:instance)   { described.new(model, client) }
      let(:model)      { Vedeu::Group.new }
      let(:client)     {}
      let(:group_name) { 'main_screen' }

      describe '#initialize' do
        it { instance.must_be_instance_of(Vedeu::DSL::Group) }
        it { instance.instance_variable_get('@model').must_equal(model) }
        it { instance.instance_variable_get('@client').must_equal(client) }
      end

      describe '.group' do
        context 'when the block is given' do
          subject {
            described.group(group_name) do
              # ...
            end
          }

        end

        context 'when the block is not given' do
          subject { described.group(group_name) }

          it { proc { subject }.must_raise(InvalidSyntax) }
        end
      end

      describe '#add' do
        subject {
          described.group(group_name) do
            add('editor_interface')
          end
        }

        it { subject.must_be_instance_of(Vedeu::Group) }
      end

    end # Group

  end # DSL

end # Vedeu
