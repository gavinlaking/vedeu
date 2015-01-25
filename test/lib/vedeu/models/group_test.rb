require 'test_helper'

module Vedeu

  describe Group do

    let(:described) { Group.new('organics', *members) }
    let(:members)   { ['carbon', 'nitrogen', 'oxygen'] }

    describe '#initialize' do
      it { described.must_be_instance_of(Group) }
      it { described.instance_variable_get('@members').must_equal(members.to_set) }
      it { described.instance_variable_get('@name').must_equal('organics') }
      it { described.instance_variable_get('@repository').must_equal(Vedeu.groups) }
    end

    describe '#add' do
      it 'returns a Group' do
        Group.new('organics', 'carbon', 'nitrogen').add('oxygen').must_be_instance_of(Group)
      end

      context 'when the member already exists' do
        it 'does not add the member again but returns a new Group' do
          group = Group.new('organics', 'nitrogen', 'carbon')
          new_group = group.add('nitrogen')
          new_group.wont_equal(group)
        end
      end

      context 'when the member does not exist' do
        it 'adds the member and returns a new Group' do
          group = Group.new('organics', 'carbon')
          new_group = group.add('nitrogen')
          new_group.wont_equal(group)
        end
      end
    end

    describe '#members' do
      it { described.members.must_be_instance_of(Set) }

      context 'when the group has no members' do
        it 'returns an empty Set' do
          group = Group.new('organics')
          group.members.must_be_empty
        end
      end

      context 'when the group has members' do
        it 'returns a set of members' do
          group = Group.new('organics', 'nitrogen', 'carbon')
          group.members.wont_be_empty
        end
      end
    end

    describe '#name' do
      it 'returns the specified name for the group' do
        Group.new('organics').name.must_equal('organics')
      end
    end

    describe '#remove' do
      it 'returns a Group' do
        group = Group.new('organics')
        group.members.must_be_empty
        group.remove('nitrogen').must_be_instance_of(Group)
      end

      context 'when the member exists' do
        it 'removes the member and returns a new Group' do
          group     = Group.new('organics', 'nitrogen', 'carbon')
          new_group = group.remove('nitrogen')
          new_group.members.wont_include('nitrogen')
        end
      end

      context 'when the member does not exist' do
        it 'returns a new Group' do
          group     = Group.new('organics', 'nitrogen', 'carbon')
          new_group = group.remove('oxygen')
          new_group.wont_equal(group)
        end
      end
    end

    describe '#reset' do
      it { described.reset.must_be_instance_of(Group) }

      it 'returns a Group with no members' do
        group     = Group.new('organics', 'nitrogen', 'carbon')
        new_group = group.reset
        new_group.members.must_be_empty
      end
    end

  end # Group

end # Vedeu
