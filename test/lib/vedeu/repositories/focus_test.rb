require 'test_helper'

module Vedeu
  describe Focus do
    before { Focus.reset }

    describe '#add' do
      it 'adds an interface to storage focussed' do
        Focus.add({ name: 'thallium' }).must_equal(['thallium'])
      end

      it 'does not add it again if already exists' do
        Focus.add({ name: 'thallium' })
        Focus.add({ name: 'thallium' })
        Focus.registered.must_equal(['thallium'])
      end
    end

    describe '#by_name' do
      it 'the named interface is focussed when the method is called' do
        Focus.add({ name: 'thallium' })
        Focus.add({ name: 'lead' })
        Focus.add({ name: 'bismuth' })
        Focus.by_name('lead').must_equal('lead')
      end

      it 'the named interface is focussed when the event is triggered' do
        Focus.add({ name: 'thallium' })
        Focus.add({ name: 'lead' })
        Focus.add({ name: 'bismuth' })

        Vedeu.trigger(:_focus_by_name_, 'lead')

        Focus.current.must_equal('lead')
      end

      it 'raises an exception if the event is triggered for an interface ' \
         'that does not exist' do
        proc { Vedeu.trigger(:_focus_by_name_, 'not_found') }
          .must_raise(InterfaceNotFound)
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

    describe '#next_item' do
      it 'the next interface is focussed when the method is called' do
        Focus.add({ name: 'thallium' })
        Focus.add({ name: 'lead' })
        Focus.add({ name: 'bismuth' })
        Focus.next_item.must_equal('lead')
      end

      it 'the next interface is focussed when the event is triggered' do
        Focus.add({ name: 'thallium' })
        Focus.add({ name: 'lead' })
        Focus.add({ name: 'bismuth' })

        Vedeu.trigger(:_focus_next_)

        Focus.current.must_equal('lead')
      end
    end

    describe '#prev_item' do
      it 'the previous interface is focussed when the method is called' do
        Focus.add({ name: 'thallium' })
        Focus.add({ name: 'lead' })
        Focus.add({ name: 'bismuth' })
        Focus.prev_item.must_equal('bismuth')
      end

      it 'the previous interface is focussed when the event is triggered' do
        Focus.add({ name: 'thallium' })
        Focus.add({ name: 'lead' })
        Focus.add({ name: 'bismuth' })

        Vedeu.trigger(:_focus_prev_)

        Focus.current.must_equal('bismuth')
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
  end
end
