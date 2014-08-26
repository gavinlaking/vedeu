require 'test_helper'

# [['thallium', false], ['lead', false], ['bismuth', false]]

module Vedeu
  describe Focus do
    before { Vedeu.events.reset }

    describe '#add' do
      it 'adds an interface to storage unfocussed' do
        focus = Focus.new
        focus.add('thallium').must_equal(['thallium'])
      end

      it 'does not add it again if already exists' do
        focus = Focus.new(['thallium'])
        focus.add('thallium').must_equal(['thallium'])
      end
    end

    describe '#by_name' do
      it 'returns the name of the interface after focussing it' do
        focus = Focus.new(['thallium', 'lead', 'bismuth'])

        Vedeu.trigger(:_focus_by_name_, 'bismuth')

        focus.current.must_equal('bismuth')
      end

      it 'returns the name of the interface after focussing it' do
        focus = Focus.new(['thallium', 'lead', 'bismuth'])

        Vedeu.trigger(:_focus_by_name_, 'bismuth')
        Vedeu.trigger(:_focus_by_name_, 'lead')

        focus.current.must_equal('lead')
      end

      it 'raises an exception if the interface does not exist' do
        focus = Focus.new
        proc { focus.by_name('not_found') }.must_raise(InterfaceNotFound)
      end
    end

    describe '#current' do
      it 'returns the name of the interface currently in focus' do
        focus = Focus.new(['thallium', 'lead', 'bismuth'])
        focus.current.must_equal('thallium')
      end

      it 'raises an exception if there are no interfaces defined' do
        focus = Focus.new
        proc { focus.current }.must_raise(NoInterfacesDefined)
      end
    end

    describe '#next_item' do
      it 'makes the next interface focussed' do
        focus = Focus.new(['thallium', 'lead', 'bismuth'])
        focus.next_item.must_equal('lead')
      end
    end

    describe '#prev_item' do
      it 'makes the previous interface focussed' do
        focus = Focus.new(['thallium', 'lead', 'bismuth'])
        focus.prev_item.must_equal('bismuth')
      end
    end
  end
end
