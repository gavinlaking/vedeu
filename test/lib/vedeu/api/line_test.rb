require 'test_helper'

require 'vedeu/api/line'
require 'vedeu/api/interface'
require 'vedeu/support/interface_store'

module Vedeu
  module API
    describe Line do
      before do
        InterfaceStore.reset
        Interface.save('testing_view') do
          width  80
          height 25
          x      1
          y      1
          colour  foreground: '#ffffff', background: '#000000'
          centred false
        end
      end
    end
  end
end
