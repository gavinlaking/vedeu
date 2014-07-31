require 'test_helper'
require 'vedeu'

module Vedeu
  describe ClassMethods do
    describe '.interface' do
    end

    describe '.event' do
    end

    describe '.run' do
    end

    describe '.view' do
      it 'returns the interface referenced by name' do
        skip
        [].must_be_instance_of(Interface)
        [].name.must_equal([])
      end

      it 'returns false with no name' do
        skip
        [].must_equal(false)
      end

      it 'raises an exception if the interface does not exist' do
        skip
        proc { }.must_raise(EntityNotFound)
      end
    end
  end
end

describe Vedeu do
  describe '.debug?' do
    it 'allows me to quickly enable/disable debugging' do
      skip
    end
  end

  describe '.events' do
    it 'creates some system events for the client application' do
      skip
    end
  end

  describe '.log' do
    it 'returns a logger instance for writing debug messages to' do
      skip
    end
  end

  describe '.error' do
    it 'writes an error to the log' do
      skip
    end
  end
end
