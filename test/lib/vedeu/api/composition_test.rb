require 'test_helper'

module Vedeu
  module API
    describe '#views' do
      it 'allows multiple views to be defined at once' do
        Vedeu.views do
          view 'view_1' do
            line do
              text '1. A line of text in view 1.'
              text '2. Another line of text in view 1.'
            end
          end
          view 'view_2' do
            line do
              text '1. A line of text in view 2.'
              text '2. Another line of text in view 2.'
            end
          end
        end.must_equal(
          {
            interfaces: [
              {
                name:  "view_1",
                group: "",
                lines: [
                  {
                    colour: {},
                    streams: [
                      {
                        text: "1. A line of text in view 1."
                      }, {
                        text: "2. Another line of text in view 1."
                      }
                    ],
                    style: []
                  }
                ],
                colour: {},
                style: "",
                geometry: {},
                cursor: true,
                delay: 0.0
              }, {
                name: "view_2",
                group: "",
                lines: [
                  {
                    colour: {},
                    streams: [
                      {
                        text: "1. A line of text in view 2."
                      }, {
                        text: "2. Another line of text in view 2."
                      }
                    ],
                    style: []
                  }
                ],
                colour: {},
                style: "",
                geometry: {},
                cursor: true,
                delay: 0.0
              }
            ]
          }
        )
      end
    end
  end
end
