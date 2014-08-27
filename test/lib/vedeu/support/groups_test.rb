require 'test_helper'

module Vedeu
  describe Groups do
    let(:groups) { Groups.new }

    describe '#all' do
      before do
        groups.add('elements', 'cobalt', 0.0)
        groups.add('elements', 'nickel', 0.0)
        groups.add('elements', 'copper', 0.0)
      end

      it 'returns all the groups from storage' do
        groups.all.must_equal({
          "elements" => Set["cobalt", "nickel", "copper"]
        })
      end
    end

    describe '#find' do
      before { groups.add('elements', 'zinc', 0.0) }

      it 'raises an exception if the group cannot be found' do
        proc { groups.find('not_found') }.must_raise(GroupNotFound)
      end

      it 'returns a collection of interface names belonging to the group' do
        groups.find('elements').must_equal(Set['zinc'])
      end
    end

    describe '#add' do
      it 'returns false if the group name is empty' do
        groups.add('', 'gallium', 0.0).must_equal(false)
      end

      it 'adds the interface name to the group in storage' do
        groups.add('elements', 'germanium', 0.0)
        groups.all.must_equal({
          "elements" => Set['germanium']
        })
      end

      it 'registers a refresh event for the group' do
        groups.add('elements', 'arsenic', 0.0)
        Vedeu.events.registered.must_include(:_refresh_group_elements_)
      end

      it 'returns the object instance' do
        groups.add('elements', 'selenium', 0.0).must_be_instance_of(Groups)
      end
    end

    describe '#reset' do
      it 'removes all known groups from the storage' do
        groups.add('elements', 'bromine', 0.0)
        groups.all.must_equal({
          "elements" => Set['bromine']
        })
        groups.reset.must_be_empty
      end
    end
  end
end
