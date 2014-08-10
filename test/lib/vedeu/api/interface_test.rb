require 'test_helper'
require 'vedeu/api/interface'

module Vedeu
  module API
    describe Interface do
      before { API::Store.reset }

      interface = Interface.new('widget')

      it 'creates and stores a new interface' do
        interface.save.must_be_instance_of(Vedeu::Interface)
      end

      it 'allows interfaces to share behaviour' do
        IO.console.stub :winsize, [10, 40] do
          main =    Vedeu.interface('main') do
                      colour  foreground: '#ff0000', background: '#000000'
                      cursor  false
                      centred true
                      width   10
                      height  2
                    end
          status =  Vedeu.interface('status') do
                      colour  foreground: 'aadd00', background: '#4040cc'
                      cursor  true
                      centred true
                      width   10
                      height  1
                      y       main.geometry.bottom
                      x       main.geometry.left
                    end

          main.geometry.left.must_equal(15)
          main.geometry.top.must_equal(4)
          status.geometry.left.must_equal(15)
          status.geometry.top.must_equal(5)
        end
      end

      it 'raises an exception when the value is out of bounds' do
        proc { interface.save { x 0 } }.must_raise(XOutOfBounds)
      end

      it 'raises an exception when the value is out of bounds' do
        proc { interface.save { x 999 } }.must_raise(XOutOfBounds)
      end

      it 'raises an exception when the value is out of bounds' do
        proc { interface.save { y 0 } }.must_raise(YOutOfBounds)
      end

      it 'raises an exception when the value is out of bounds' do
        proc { interface.save { y 999 } }.must_raise(YOutOfBounds)
      end

      it 'raises an exception when the value is out of bounds' do
        proc { interface.save { width 0 } }.must_raise(InvalidWidth)
      end

      it 'raises an exception when the value is out of bounds' do
        proc { interface.save { width 999 } }.must_raise(InvalidWidth)
      end

      it 'raises an exception when the value is out of bounds' do
        proc { interface.save { height 0 } }.must_raise(InvalidHeight)
      end

      it 'raises an exception when the value is out of bounds' do
        proc { interface.save { height 999 } }.must_raise(InvalidHeight)
      end
    end
  end
end
