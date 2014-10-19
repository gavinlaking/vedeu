require 'test_helper'

module Vedeu

  describe Viewport do

    let(:interface) {
      Interface.new({
        name:     'fluorine',
        geometry: {
          width:  30,
          height: 2,
        },
        lines: [
          { # 53
            streams: [{
              text: 'Something interesting ', # 22
            },{
              text: 'on this line ', # 13
            },{
              text: 'would be cool, eh?' # 18
            }]
          }, { # 49
            streams: [{
              text: 'Maybe a lyric, a little ditty ', # 30
            },{
              text: 'to help you unwind.',  # 19
            }]
          }
        ]
      })
    }

  end # Viewport

end # Vedeu
