require 'test_helper'

module Vedeu
  describe Groups do
    describe '#add' do
      it 'returns false if the group name is empty' do
        Groups.add({ group: '', name: 'gallium', delay: 0.0 }).must_equal(false)
      end

      it 'adds the interface name to the group in storage' do
        Groups.add({ group: 'elements', name: 'germanium', delay: 0.0 })
        Groups.all.must_equal({ 'elements' => Set['germanium'] })
      end
    end

    describe '#all' do
      before do
        Groups.add({ group: 'elements', name: 'cobalt', delay: 0.0 })
        Groups.add({ group: 'elements', name: 'nickel', delay: 0.0 })
        Groups.add({ group: 'elements', name: 'copper', delay: 0.0 })
      end

      it 'returns all the groups from storage' do
        Groups.all.must_equal({
          "elements" => Set["cobalt", "nickel", "copper"]
        })
      end
    end

    describe '#find' do
      before { Groups.add({ group: 'elements', name: 'zinc', delay: 0.0 }) }

      it 'raises an exception if the group cannot be found' do
        proc { Groups.find('not_found') }.must_raise(GroupNotFound)
      end

      it 'returns a collection of interface names belonging to the group' do
        Groups.find('elements').must_equal(Set['zinc'])
      end
    end

    describe '#registered' do
      before do
        Groups.add({ group: 'elements', name: 'cobalt', delay: 0.0 })
        Groups.add({ group: 'minerals', name: 'ruby', delay: 0.0 })
        Groups.add({ group: 'elements', name: 'copper', delay: 0.0 })
        Groups.add({ group: 'minerals', name: 'diamond', delay: 0.0 })
      end

      it 'returns all the groups from storage' do
        Groups.registered.must_equal(['elements', 'minerals'])
      end
    end

    describe '#registered?' do
      it 'returns true when the group is registered' do
        Groups.add({ group: 'registered' })

        Groups.registered?('registered').must_equal(true)
      end

      it 'returns false when the group is not registered' do
        Groups.registered?('not_registered').must_equal(false)
      end
    end

    describe '#reset' do
      it 'removes all known groups from the storage' do
        Groups.add({ group: 'elements', name: 'bromine', delay: 0.0 })
        Groups.all.must_equal({ 'elements' => Set['bromine'] })
        Groups.reset.must_be_empty
      end
    end
  end
end
