require 'test_helper'

module Vedeu

  module Models

    describe Group do

      let(:described)  { Vedeu::Models::Group }
      let(:instance)   { described.new(attributes) }
      let(:attributes) {
        {
          name:       _name,
          members:    members,
          repository: repository,
          visible:    visible,
        }
      }
      let(:_name)      { 'organics' }
      let(:members)    { Set.new(['carbon', 'nitrogen', 'oxygen']) }
      let(:repository) { Vedeu.groups }
      let(:visible)    { true }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@members').must_equal(members) }
        it { instance.instance_variable_get('@name').must_equal(_name) }
        it {
          instance.instance_variable_get('@repository').must_equal(repository)
        }
        it { instance.instance_variable_get('@visible').must_equal(visible) }
      end

      describe 'accessors' do
        it { instance.must_respond_to(:name) }
        it { instance.must_respond_to(:name=) }
        it { instance.must_respond_to(:visible) }
        it { instance.must_respond_to(:visible=) }
        it { instance.must_respond_to(:visible?) }
      end

      describe '#add' do
        subject { instance.add('hydrogen') }

        it { subject.must_be_instance_of(Vedeu::Models::Group) }

        context 'when the member already exists' do
          it 'does not add the member again but returns a new Group' do
            subject.wont_equal(instance)
          end
        end

        context 'when the member does not exist' do
          it 'adds the member and returns a new Group' do
            subject.wont_equal(instance)
          end
        end
      end

      describe '#by_zindex' do
        subject { instance.by_zindex }

        it { subject.must_be_instance_of(Array) }

        # @todo Add more tests.
        # it { skip }
      end

      describe '#hide' do
        subject { instance.hide }

        it { subject.must_equal(instance) }
      end

      describe '#members' do
        subject { instance.members }

        it { subject.must_be_instance_of(Set) }

        context 'when the group has no members' do
          let(:members) { [] }

          it 'returns an empty Set' do
            subject.must_be_empty
          end
        end

        context 'when the group has members' do
          it 'returns a set of members' do
            subject.wont_be_empty
          end
        end
      end

      describe '#remove' do
        let(:member) { 'hydrogen' }

        subject { instance.remove(member) }

        it { subject.must_be_instance_of(described) }

        context 'when the group is already empty' do
          let(:members) { [] }

          it { subject.wont_equal(instance) }
        end

        context 'when the member exists' do
          let(:member) { 'oxygen' }

          it { subject.wont_equal(instance) }
          it { subject.members.wont_include(member) }
        end

        context 'when the member does not exist' do
          it { subject.wont_equal(instance) }
          it { subject.members.wont_include(member) }
        end
      end

      describe '#reset' do
        subject { instance.reset }

        it { subject.must_be_instance_of(Vedeu::Models::Group) }
        it { subject.members.must_be_empty }
      end

      describe '#show' do
        subject { instance.show }

        it { subject.must_equal(instance) }
      end

    end # Group

  end # Models

end # Vedeu
