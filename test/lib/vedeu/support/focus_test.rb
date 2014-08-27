require 'test_helper'

# [['thallium', false], ['lead', false], ['bismuth', false]]

module Vedeu
  describe Focus do
    before do
      Vedeu.unevent(:_focus_next_)
      Vedeu.unevent(:_focus_prev_)
      Vedeu.unevent(:_focus_by_name_)
    end

    describe '#add' do
      it 'adds an interface to storage unfocussed' do
        focus = Focus.new
        focus.add('thallium').must_equal(['thallium'])
      end

      it 'does not add it again if already exists' do
        focus = Focus.new
        focus.add('thallium')
        focus.add('thallium').must_equal(['thallium'])
      end
    end

    describe '#by_name' do
      it 'the named interface is focussed when the method is called' do
        focus = Focus.new
        focus.add('thallium')
        focus.add('lead')
        focus.add('bismuth')
        focus.by_name('bismuth').must_equal('bismuth')
      end

      it 'the named interface is focussed when the event is triggered' do
        focus = Focus.new
        focus.add('thallium')
        focus.add('lead')
        focus.add('bismuth')

        Vedeu.trigger(:_focus_by_name_, 'lead')

        focus.current.must_equal('lead')
      end

      it 'raises an exception if the interface does not exist' do
        focus = Focus.new
        proc { Vedeu.trigger(:_focus_by_name_, 'not_found') }.must_raise(InterfaceNotFound)
      end

      it 'raises an exception if the interface does not exist' do
        focus = Focus.new
        proc { focus.by_name('not_found') }.must_raise(InterfaceNotFound)
      end
    end

    describe '#current' do
      it 'returns the name of the interface currently in focus' do
        focus = Focus.new
        focus.add('thallium')
        focus.add('lead')
        focus.add('bismuth')
        focus.current.must_equal('thallium')
      end

      it 'raises an exception if there are no interfaces defined' do
        focus = Focus.new
        proc { focus.current }.must_raise(NoInterfacesDefined)
      end
    end

    describe '#next_item' do
      it 'the next interface is focussed when the method is called' do
        focus = Focus.new
        focus.add('thallium')
        focus.add('lead')
        focus.add('bismuth')
        focus.next_item.must_equal('lead')
      end

      it 'the next interface is focussed when the event is triggered' do
        focus = Focus.new
        focus.add('thallium')
        focus.add('lead')
        focus.add('bismuth')

        Vedeu.trigger(:_focus_next_)

        focus.current.must_equal('lead')
      end
    end

    describe '#prev_item' do
      it 'the previous interface is focussed when the method is called' do
        focus = Focus.new
        focus.add('thallium')
        focus.add('lead')
        focus.add('bismuth')
        focus.prev_item.must_equal('bismuth')
      end

      it 'the previous interface is focussed when the event is triggered' do
        focus = Focus.new
        focus.add('thallium')
        focus.add('lead')
        focus.add('bismuth')

        Vedeu.trigger(:_focus_prev_)

        focus.current.must_equal('bismuth')
      end
    end
  end
end
