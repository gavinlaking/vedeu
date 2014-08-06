require 'test_helper'
require 'vedeu/support/menu'
require 'vedeu/output/menu_parser'

module Vedeu
  describe MenuParser do
    describe '.parse' do
      it 'returns an interface' do
        items  = [
          [false, true,  'Hydrogen'],
          [true,  false, 'Helium'],
          [false, false, 'Lithium'],
          [true,  true,  'Beryllium']
        ]
        args   = ['dummy', items]
        parser = MenuParser.parse(args)
        parser.must_equal(
          {
            interfaces: {
              name:  'dummy',
              lines: [
                {
                  streams: {
                    text: ' > Hydrogen'
                  }
                }, {
                  streams: {
                    text: '*  Helium'
                  }
                }, {
                  streams: {
                    text: '   Lithium'
                  }
                }, {
                  streams: {
                    text: '*> Beryllium'
                  }
                }
              ]
            }
          }
        )
      end
    end
  end
end
