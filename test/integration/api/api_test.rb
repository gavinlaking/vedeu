require 'test_helper'

describe 'Testing Vedeu::API methods' do

  describe '.configure' do
    it 'raises an exception when the required block is not given' do
      proc { Vedeu.configure }.must_raise(Vedeu::InvalidSyntax)
    end
  end

  describe '.defined' do
    it 'returns the Vedeu::API::Defined module name' do
      Vedeu.defined.must_equal(Vedeu::API::Defined)
    end
  end

  describe '.event' do
    it 'returns a list of event associated with the provided event name ' \
    'after adding the event' do
      skip 'Need to mock an event'
      Vedeu.event(:_hydrogen_event_).must_equal('')
    end

    it 'should raise an exception when the event name is nil or empty' do
      skip 'Need to raise an exception'
      Vedeu.event(nil).must_equal('')
    end
  end

  describe '.focus' do
    it 'raises an exception when the interface does not exist' do
      proc { Vedeu.focus(nil) }.must_raise(Vedeu::InterfaceNotFound)
    end

    it 'raises an exception when the interface does not exist' do
      proc { Vedeu.focus('not_defined') }.must_raise(Vedeu::InterfaceNotFound)
    end

    it 'sets the specified interface as in focus' do
      skip 'Finish this test off'
      Vedeu.focus('hydrogen')
    end
  end

  describe '.height' do
    before { Vedeu::Terminal.console.stubs(:winsize).returns([25, 80]) }

    it 'returns the height of the terminal' do
      Vedeu.height.must_equal(25)
    end
  end

  describe '.interface' do
  end

  describe '.keypress' do
  end

  describe '.keys' do
  end

  describe '.log' do
  end

  describe '.menu' do
  end

  describe '.render' do
  end

  describe '.resize' do
  end

  describe '.trigger' do
  end

  describe '.unevent' do
  end

  describe '.use' do
  end

  describe '.view' do
  end

  describe '.views' do
  end

  describe '.width' do
    before { Vedeu::Terminal.console.stubs(:winsize).returns([25, 80]) }

    it 'returns the width of the terminal' do
      Vedeu.width.must_equal(80)
    end
  end

end
