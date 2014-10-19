require 'test_helper'

module Vedeu

  describe Groups do

    describe '#add' do
      before { Groups.reset }

      it 'returns false if the group name is empty' do
        Groups.add({ group: '', name: 'gallium', delay: 0.0 }).must_equal(false)
      end

      it 'adds the interface name to the group in storage' do
        Groups.add({ group: 'elements', name: 'germanium', delay: 0.0 })
        Groups.all.must_equal({ 'elements' => Set['germanium'] })
      end

      it 'raises an exception if the attributes does not have a :name key' do
        attributes = { no_name_key: '' }

        proc { Groups.add(attributes) }.must_raise(MissingRequired)
      end
    end

  end # Groups

end # Vedeu
