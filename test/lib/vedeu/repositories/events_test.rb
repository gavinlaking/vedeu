require 'test_helper'

module Vedeu
  describe Events do
    describe '#add' do
      it 'adds the event' do
        Events.add(:sulphur) { proc { |x| x } }
        Events.registered.must_include(:sulphur)
      end
    end

    describe '#remove' do
      it 'removes the event by name' do
        Events.add(:chlorine) { proc { |x| x } }
        Events.add(:argon)    { proc { |y| y } }
        Events.remove(:chlorine)
        Events.registered.wont_include(:chlorine)
      end

      it 'removes the event by name only if the name exists' do
        Events.add(:chlorine) { proc { |x| x } }
        Events.add(:argon)    { proc { |y| y } }
        Events.remove(:potassium).must_equal(false)
      end
    end

    describe '#registered' do
      it 'returns all the registered events by name' do
        Events.add(:some_event) { proc { |x| x } }
        Events.registered.must_include(:some_event)
      end
    end

    describe '#registered?' do
      it '' do
        skip
      end
    end

    describe '#trigger' do
      it 'returns the result of triggering the event' do
        NastyException = Class.new(StandardError)

        Events.add(:_nasty_exception_) { fail NastyException }

        proc { Events.use(:_nasty_exception_) }.must_raise(NastyException)
      end

      it 'returns an empty collection when the event has not been registered' do
        Events.use(:_not_found_).must_be_empty
      end
    end

    # describe '#reset' do
    #   it 'removes all events registered' do
    #     Events.add(:potassium)
    #     Events.registered.must_include(:potassium)
    #     Events.reset
    #     Events.registered.wont_include(:potassium)
    #   end
    # end
  end
end
