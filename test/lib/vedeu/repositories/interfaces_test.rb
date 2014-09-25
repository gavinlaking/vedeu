require 'test_helper'

module Vedeu
  describe Interfaces do

    describe '#add' do
      before { Interfaces.reset }

      it 'adds the interface to the storage' do
        Interfaces.add({ name: 'germanium' })
        Interfaces.all.must_equal({ 'germanium' => { name: 'germanium' } })
      end

      it 'raises an exception if the attributes does not have a :name key' do
        attributes = { no_name_key: '' }

        proc { Interfaces.add(attributes) }.must_raise(MissingRequired)
      end
    end

    describe '#all' do
      before do
        Interfaces.reset
        Interfaces.add({ name: 'cobalt' })
        Interfaces.add({ name: 'nickel' })
        Interfaces.add({ name: 'copper' })
      end

      it 'returns the storage' do
        Interfaces.all.must_equal(
          {
            'cobalt' => { name: 'cobalt' },
            'nickel' => { name: 'nickel' },
            'copper' => { name: 'copper' }
          }
        )
      end
    end

    describe '#find' do
      before { Interfaces.add({ name: 'zinc' }) }

      it 'raises an exception if the interface cannot be found' do
        proc { Interfaces.find('not_found') }.must_raise(InterfaceNotFound)
      end

      it 'returns the attributes of the named interface' do
        Interfaces.find('zinc').must_equal({ name: 'zinc' })
      end
    end

    describe '#registered' do
      before do
        Interfaces.reset
        Interfaces.add({ name: 'cobalt' })
        Interfaces.add({ name: 'ruby' })
      end

      it 'returns all the registered interfaces from storage' do
        Interfaces.registered.must_equal(['cobalt', 'ruby'])
      end
    end

    describe '#registered?' do
      it 'returns true when the interface is registered' do
        Interfaces.add({ name: 'registered' })

        Interfaces.registered?('registered').must_equal(true)
      end

      it 'returns false when the interface is not registered' do
        Interfaces.registered?('not_registered').must_equal(false)
      end
    end

    describe '#reset' do
      before { Interfaces.reset }

      it 'removes all known interfaces from the storage' do
        Interfaces.add({ name: 'bromine' })
        Interfaces.all.must_equal({ 'bromine' => { name: 'bromine' } })
        Interfaces.reset.must_be_empty
      end
    end

  end
end
