require 'test_helper'

require 'vedeu/api/view'
require 'vedeu'

module Vedeu
  module API
    describe View do
      before do
        InterfaceStore.reset
        @api_view = InterfaceTemplate.save('api_view') do
          width  10
          height 10
          x      1
          y      1
          colour  foreground: '#ffff00', background: '#5a5a5a'
          centred true
        end
      end

      # it 'raises an exception if the interface is not defined' do
      #   proc { View.build('dummy') { } }.must_raise(Vedeu::API::InterfaceNotSpecified)
      # end

      # it 'returns the interface if defined' do
      #   View.build('api_view') {}.must_be_instance_of(Interface)
      # end
    end
  end
end
