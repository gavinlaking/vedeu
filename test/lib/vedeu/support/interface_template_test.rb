require 'test_helper'
require 'vedeu/support/interface_template'

module Vedeu
  describe InterfaceTemplate do
    it 'creates and stores a new interface' do
      interface = InterfaceTemplate.save('widget') do
                    colour  foreground: '#ff0000', background: '#5f0000'
                    cursor  false
                    width   10
                    height  2
                    centred true
                  end
      interface.must_be_instance_of(Interface)
    end

    it 'allows interfaces to share behaviour' do
      IO.console.stub :winsize, [10, 40] do
        main =    InterfaceTemplate.save('main') do
                    colour  foreground: '#ff0000', background: '#000000'
                    cursor  false
                    centred true
                    width   10
                    height  2
                  end
        status =  InterfaceTemplate.save('status') do
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
  end
end
