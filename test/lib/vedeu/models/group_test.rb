require 'test_helper'

module Vedeu

  describe Group do

    let(:described)  { Vedeu::Group }
    let(:instance)   { described.new(attributes) }
    let(:attributes) {
      {
        name:    _name,
        members: members,
      }
    }
    let(:_name)      { 'organics' }
    let(:members)    { ['carbon', 'nitrogen', 'oxygen'] }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it {
        instance.instance_variable_get('@attributes').must_be_instance_of(Hash)
      }
      it { instance.instance_variable_get('@members').must_equal(members) }
      it { instance.instance_variable_get('@name').must_equal(_name) }
      it {
        instance.instance_variable_get('@repository').must_equal(Vedeu.groups)
      }
    end

    describe '#add' do
      subject { instance.add('hydrogen') }

      it { subject.must_be_instance_of(Group) }

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

    describe '#name' do
      subject { instance.name }

      it { subject.must_equal('organics') }
    end

    describe '#name=' do
      it { instance.must_respond_to(:name=) }
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

      it { subject.must_be_instance_of(Group) }
      it { subject.members.must_be_empty }
    end

  end # Group

end # Vedeu
