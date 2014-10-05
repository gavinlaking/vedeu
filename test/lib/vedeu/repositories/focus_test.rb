require 'test_helper'

module Vedeu
  describe Focus do
    before { Focus.reset }
    after  { Focus.reset }

    describe '#add' do
      it 'adds an interface to storage focussed' do
        Focus.add({ name: 'thallium' }).must_equal(['thallium'])
      end

      it 'does not add it again if already exists' do
        Focus.add({ name: 'thallium' })
        Focus.add({ name: 'thallium' })
        Focus.registered.must_equal(['thallium'])
      end

      it 'raises an exception if the attributes does not have a :name key' do
        attributes = { no_name_key: '' }

        proc { Focus.add(attributes) }.must_raise(MissingRequired)
      end
    end

    describe '#by_name' do
      it 'the named interface is focussed when the method is called' do
        Focus.add({ name: 'thallium' })
        Focus.add({ name: 'lead' })
        Focus.add({ name: 'bismuth' })
        Focus.by_name('lead').must_equal('lead')
      end

      it 'raises an exception if the interface does not exist' do
        proc { Focus.by_name('not_found') }.must_raise(InterfaceNotFound)
      end
    end

    describe '#current' do
      it 'returns the name of the interface currently in focus' do
        Focus.add({ name: 'thallium' })
        Focus.add({ name: 'lead' })
        Focus.add({ name: 'bismuth' })
        Focus.current.must_equal('thallium')
      end

      it 'raises an exception if there are no interfaces defined' do
        proc { Focus.current }.must_raise(NoInterfacesDefined)
      end
    end

    describe '#current?' do
      before { Focus.stubs(:current).returns('lead') }

      context 'when the interface is currently in focus' do
        it { Focus.current?('lead').must_equal(true) }
      end

      context 'when the interface is not currently in focus' do
        it { Focus.current?('bismuth').must_equal(false) }
      end
    end

    describe '#next_item' do
      it 'the next interface is focussed when the method is called' do
        Focus.add({ name: 'thallium' })
        Focus.add({ name: 'lead' })
        Focus.add({ name: 'bismuth' })
        Focus.next_item.must_equal('lead')
      end
    end

    describe '#prev_item' do
      it 'the previous interface is focussed when the method is called' do
        Focus.add({ name: 'thallium' })
        Focus.add({ name: 'lead' })
        Focus.add({ name: 'bismuth' })
        Focus.prev_item.must_equal('bismuth')
      end
    end

    describe '#registered' do
      it 'returns all the names of the interfaces which can be focussed' do
        Focus.add({ name: 'thallium' })
        Focus.add({ name: 'lead' })
        Focus.add({ name: 'bismuth' })

        Focus.registered.must_equal(['thallium', 'lead', 'bismuth'])
      end
    end

    describe '.registered?' do
      it 'returns false when there are no interfaces registered' do
        Focus.registered?('thallium').must_equal(false)
      end

      it 'returns false when the named interface is not registered' do
        Focus.add({ name: 'thallium' })
        Focus.registered?('lead').must_equal(false)
      end

      it 'returns true if the named interface is registered' do
        Focus.add({ name: 'lead' })
        Focus.registered?('lead').must_equal(true)
      end
    end

  end
end
