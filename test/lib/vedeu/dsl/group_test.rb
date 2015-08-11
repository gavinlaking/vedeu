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
        it { instance.must_be_instance_of(described) }
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

          it { proc { subject }.must_raise(Vedeu::InvalidSyntax) }
        end
      end

      describe '#add' do
        subject {
          described.group(group_name) do
            add('editor_interface')
          end
        }

        it { subject.must_be_instance_of(Vedeu::Group) }

        it { subject.members.must_equal(Set['editor_interface']) }
      end

      describe '#members' do
        let(:expected) {
          Set['editor_interface', 'some_interface', 'other_interface']
        }

        subject {
          described.group(group_name) do
            members('editor_interface', 'some_interface', 'other_interface')
          end
        }

        it { subject.must_be_instance_of(Vedeu::Group) }

        it { subject.members.must_equal(expected) }
      end

    end # Group

    describe 'integration' do

      context 'it does not work without a name' do
        subject {
          Vedeu.group('') do
            add('main_interface')
          end
        }

        it { proc { subject }.must_raise(Vedeu::MissingRequired) }
      end

      context 'it adds interface names to the group' do
        subject {
          Vedeu.group('my_group') do
            add('main_interface')
            add('status_interface')
            add('command_interface')
          end
        }

        it { subject.members.size.must_equal(3) }

        it { subject.members.must_equal(
          Set['main_interface', 'status_interface', 'command_interface']
        ) }
      end

      context 'it does not add duplicate names to the group' do
        subject {
          Vedeu.group('my_group') do
            add('main_interface')
            add('status_interface')
            add('main_interface')
          end
        }

        it { subject.members.size.must_equal(2) }

        it { subject.members.must_equal(
          Set['main_interface', 'status_interface']
        ) }
      end

    end

  end # DSL

end # Vedeu
