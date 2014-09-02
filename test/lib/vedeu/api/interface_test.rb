require 'test_helper'

module Vedeu
  module API
    describe Interface do
      before { Vedeu::Buffers.reset }

      describe '#define' do
        interface = Interface.new({ name: 'widget' })

        it 'creates and stores a new interface' do
          interface.define.must_be_instance_of(API::Interface)
        end

        it 'allows the setting of colours' do
          Interface.build do
            colour foreground: '#aadd00', background: '#222222'
          end.must_equal(
            {
              name: '',
              group: '',
              lines: [],
              colour: {
                foreground: "#aadd00",
                background: "#222222"
              },
              style: "",
              geometry: {},
              cursor: true,
              delay: 0.0,
              parent: nil,
            }
          )
        end

        it 'allows the setting of styles' do
          Interface.build do
            style 'underline'
          end.must_equal(
            {
              name: '',
              group: '',
              lines: [],
              colour: {},
              style: "underline",
              geometry: {},
              cursor: true,
              delay: 0.0,
              parent: nil,
            }
          )
        end

        it 'allows the use of other interfaces for attributes like geometry' do
          IO.console.stub(:winsize, [25, 40]) do
            interface = Vedeu.interface 'my_interface' do
              x      5
              y      5
              width  5
              height 5
            end
            Interface.build do
              name   'my_other_interface'
              y      use('my_interface').south
            end.must_equal({
              name: "my_other_interface",
              group: "",
              lines: [],
              colour: {},
              style: "",
              geometry: {
                y: 11
              },
              cursor: true,
              delay: 0.0,
              parent: nil,
            })
          end
        end

        it 'allows the setting of a delay for events triggered for this ' \
           'interface' do
          Interface.build do
            delay 1.0
          end.must_equal(
            {
              name: '',
              group: '',
              lines: [],
              colour: {},
              style: "",
              geometry: {},
              cursor: true,
              delay: 1.0,
              parent: nil,
            })
        end

        it 'allows the interface to be part of a group- useful for creating ' \
           'separate views' do
          Interface.build do
            group 'my_group'
          end.must_equal(
            {
              name: "",
              group: "my_group",
              lines: [],
              colour: {},
              style: "",
              geometry: {},
              cursor: true,
              delay: 0.0,
              parent: nil,
            }
          )
        end

        it 'allows the setting of the cursor for the interface to be shown ' \
           'or hidden' do
          Interface.build do
            cursor false
          end.must_equal(
            {
              name: "",
              group: "",
              lines: [],
              colour: {},
              style: "",
              geometry: {},
              cursor: false,
              delay: 0.0,
              parent: nil,
            }
          )
        end
      end

      # describe '#build' do
      #   before do
      #     @interface = Vedeu.interface('testing_view') do
      #       x       1
      #       y       1
      #       colour  foreground: '#ffffff', background: '#000000'
      #       centred false
      #     end
      #   end

      #   it 'builds a basic view' do
      #     Vedeu.view 'testing_view' do
      #       line do
      #         text '1. A line of text.'
      #         text '2. Another line of text.'
      #       end
      #     end.must_equal(
      #       { interfaces: [{
      #         name:  'testing_view',
      #         group: '',
      #         colour: {},
      #         style: '',
      #         geometry: {},
      #         cursor: true,
      #         delay: 0.0,
      #         lines: [
      #           {
      #             parent:  @interface,
      #             colour:  {},
      #             style:   [],
      #             streams: [
      #               {
      #                 text:  '1. A line of text.'
      #               }, {
      #                 text:  '2. Another line of text.'
      #               }
      #             ]
      #           }
      #         ]
      #       }] }
      #     )
      #   end

      #   it 'handles coloured lines' do
      #     Vedeu.view 'testing_view' do
      #       line do
      #         text '1. Line without colours.'
      #       end
      #     end.must_equal(
      #       { interfaces: [{
      #         name:  'testing_view',
      #         group: '',
      #         colour: {},
      #         style: '',
      #         geometry: {},
      #         cursor: true,
      #         delay: 0.0,
      #         lines: [
      #           {
      #             parent:  nil,
      #             colour:  {},
      #             style:   [],
      #             streams: [{ text: '1. Line without colours.' }]
      #           }
      #         ]
      #       }] }
      #     )
      #   end

      #   it 'handles coloured lines' do
      #     Vedeu.view 'testing_view' do
      #       line do
      #         colour background: '#ff0000', foreground: '#ffff00'
      #         text   '2. Line with colours.'
      #       end
      #     end.must_equal(
      #       { interfaces: [{
      #         name:  'testing_view',
      #         group: '',
      #         colour: {},
      #         style: '',
      #         geometry: {},
      #         cursor: true,
      #         delay: 0.0,
      #         lines: [
      #           {
      #             parent:  nil,
      #             colour:  { background: '#ff0000', foreground: '#ffff00' },
      #             style:   [],
      #             streams: [{ text: '2. Line with colours.' }]
      #           }
      #         ]
      #       }] }
      #     )
      #   end

      #   it 'handles coloured lines' do
      #     Vedeu.view 'testing_view' do
      #       line do
      #         colour foreground: '#a7ff00', background: '#005700'
      #         text   '3. Line with explicit colour declaration.'
      #       end
      #     end.must_equal(
      #       { interfaces: [{
      #         name:  'testing_view',
      #         group: '',
      #         colour: {},
      #         style: '',
      #         geometry: {},
      #         cursor: true,
      #         delay: 0.0,
      #         lines: [
      #           {
      #             parent: nil,
      #             colour:  { background: '#005700', foreground: '#a7ff00' },
      #             style:   [],
      #             streams: [{ text: '3. Line with explicit colour declaration.' }]
      #           }
      #         ]
      #       }] }
      #     )
      #   end

      #   it 'handles coloured lines' do
      #     Vedeu.view 'testing_view' do
      #       line do # actually uses streams
      #         foreground '#ff00ff' do
      #           text '4. Line with only foreground set.'
      #         end
      #       end
      #     end.must_equal(
      #       { interfaces: [{
      #         name:  'testing_view',
      #         group: '',
      #         colour: {},
      #         style: '',
      #         geometry: {},
      #         cursor: true,
      #         delay: 0.0,
      #         lines: [
      #           {
      #             parent: nil,
      #             colour:  {},
      #             style:   [],
      #             streams: [{
      #               colour: { foreground: '#ff00ff' },
      #               style:  [],
      #               text:   '4. Line with only foreground set.',
      #               width:  nil,
      #               align:  :left,
      #               parent: nil,
      #             }]
      #           }
      #         ]
      #       }] }
      #     )
      #   end

      #   it 'handles coloured lines' do
      #     Vedeu.view 'testing_view' do
      #       line do # actually uses streams
      #         background '#00ff00' do
      #           text '5. Line with only background set.'
      #         end
      #       end
      #     end.must_equal(
      #       { interfaces: [{
      #         name:  'testing_view',
      #         group: '',
      #         colour: {},
      #         style: '',
      #         geometry: {},
      #         cursor: true,
      #         delay: 0.0,
      #         lines: [
      #           {
      #             parent: nil,
      #             colour:  {},
      #             style:   [],
      #             streams: [{
      #               colour: { background: '#00ff00' },
      #               style:  [],
      #               text:   '5. Line with only background set.',
      #               width: nil,
      #               align: :left,
      #               parent: nil,
      #             }]
      #           }
      #         ]
      #       }] }
      #     )
      #   end

      #   it 'handles styles' do
      #     Vedeu.view 'testing_view' do
      #       line do
      #         style 'normal'
      #         text  '1. Line with a normal style.'
      #       end
      #     end.must_equal(
      #       { interfaces: [{
      #         name: 'testing_view',
      #         group: '',
      #         colour: {},
      #         style: '',
      #         geometry: {},
      #         cursor: true,
      #         delay: 0.0,
      #         lines: [
      #           {
      #             parent: nil,
      #             colour:  {},
      #             style:   ['normal'],
      #             streams: [{
      #               text: '1. Line with a normal style.'
      #             }]
      #           }
      #         ]
      #       }] }
      #     )
      #   end

      #   it 'handles styles' do
      #     Vedeu.view 'testing_view' do
      #       line do
      #         style 'underline'
      #         text  '2. Line with an underline style.'
      #       end
      #     end.must_equal(
      #       { interfaces: [{
      #         name: 'testing_view',
      #         group: '',
      #         colour: {},
      #         style: '',
      #         geometry: {},
      #         cursor: true,
      #         delay: 0.0,
      #         lines: [
      #           {
      #             parent: nil,
      #             colour:  {},
      #             style:   ['underline'],
      #             streams: [{
      #               text: '2. Line with an underline style.'
      #             }]
      #           }
      #         ]
      #       }] }
      #     )
      #   end

      #   it 'handles styles' do
      #     Vedeu.view 'testing_view' do
      #       line do # actually uses streams
      #         style 'normal' do
      #           text '3. Line with a normal style.'
      #         end
      #       end
      #     end.must_equal(
      #       { interfaces: [{
      #         name: 'testing_view',
      #         group: '',
      #         colour: {},
      #         style: '',
      #         geometry: {},
      #         cursor: true,
      #         delay: 0.0,
      #         lines: [
      #           {
      #             parent: nil,
      #             colour:  {},
      #             style:   [],
      #             streams: [{
      #               colour: {},
      #               style:  ['normal'],
      #               text:   '3. Line with a normal style.',
      #               width:  nil,
      #               align:  :left,
      #               parent: nil,
      #             }]
      #           }
      #         ]
      #       }] }
      #     )
      #   end

      #   it 'handles styles' do
      #     Vedeu.view 'testing_view' do
      #       line do # actually uses streams
      #         style 'underline' do
      #           text '4. Line with an underlined style.'
      #         end
      #       end
      #     end.must_equal(
      #       { interfaces: [{
      #         name: 'testing_view',
      #         group: '',
      #         colour: {},
      #         style: '',
      #         geometry: {},
      #         cursor: true,
      #         delay: 0.0,
      #         lines: [
      #           {
      #             parent: nil,
      #             colour:  {},
      #             style:   [],
      #             streams: [{
      #               colour: {},
      #               style:  ['underline'],
      #               text:   '4. Line with an underlined style.',
      #               width: nil,
      #               align: :left,
      #               parent: nil,
      #             }]
      #           }
      #         ]
      #       }] }
      #     )
      #   end

      #   it 'handles streams, which means sub-line colours and styles' do
      #     Vedeu.view 'testing_view' do
      #       line do
      #         stream do
      #           text 'A stream of text.'
      #         end
      #       end
      #     end.must_equal(
      #       { interfaces: [{
      #         name:  'testing_view',
      #         group: '',
      #         colour: {},
      #         style: '',
      #         geometry: {},
      #         cursor: true,
      #         delay: 0.0,
      #         lines: [
      #           {
      #             parent: nil,
      #             colour:  {},
      #             style:   [],
      #             streams: [
      #               {
      #                 parent: nil,
      #                 colour: {},
      #                 style:  [],
      #                 text:   'A stream of text.',
      #                 width:  nil,
      #                 align:  :left
      #               }
      #             ]
      #           }
      #         ]
      #       }] }
      #     )
      #   end

      #   it 'handles streams, which means sub-line colours and styles' do
      #     Vedeu.view 'testing_view' do
      #       line do
      #         stream do # Stream is an 'explicit declaration'.
      #                   # We don't need it unless we want to add colours and styles.
      #                   # See below.
      #           text '1. Two streams of text, these will be'
      #         end

      #         stream do
      #           text ' on the same line- note the space.'
      #         end
      #       end
      #     end.must_equal(
      #       { interfaces: [{
      #         name:  'testing_view',
      #         group: '',
      #         colour: {},
      #         style: '',
      #         geometry: {},
      #         cursor: true,
      #         delay: 0.0,
      #         lines: [
      #           {
      #             parent: nil,
      #             colour:  {},
      #             style:   [],
      #             streams: [
      #               {
      #                 colour: {},
      #                 style:  [],
      #                 text:   '1. Two streams of text, these will be',
      #                 width: nil,
      #                 align: :left,
      #                 parent: nil,
      #               }, {
      #                 colour: {},
      #                 style:  [],
      #                 text:   ' on the same line- note the space.',
      #                 width: nil,
      #                 align: :left,
      #                 parent: nil,
      #               }
      #             ]
      #           }
      #         ]
      #       }] }
      #     )
      #   end

      #   it 'handles streams, which means sub-line colours and styles' do
      #     Vedeu.view 'testing_view' do
      #       line do
      #         stream do
      #           text '2. Streams can have'
      #         end

      #         stream do
      #           colour foreground: '#ff0000', background: '#00ff00'
      #           text   ' colours too.'
      #         end
      #       end
      #     end.must_equal(
      #       { interfaces: [{
      #         name: 'testing_view',
      #         group: '',
      #         colour: {},
      #         style: '',
      #         geometry: {},
      #         cursor: true,
      #         delay: 0.0,
      #         lines: [
      #           {
      #             parent: nil,
      #             colour: {},
      #             style: [],
      #             streams: [
      #               {
      #                 colour: {},
      #                 style: [],
      #                 text: '2. Streams can have',
      #                 width: nil,
      #                 align: :left,
      #                 parent: nil,
      #               }, {
      #                 colour: {
      #                   foreground: '#ff0000',
      #                   background: '#00ff00'
      #                 },
      #                 style: [],
      #                 text: ' colours too.',
      #                 width: nil,
      #                 align: :left,
      #                 parent: nil,
      #               }
      #             ]
      #           }
      #         ]
      #       }] }
      #     )
      #   end

      #   it 'handles streams, which means sub-line colours and styles' do
      #     Vedeu.view 'testing_view' do
      #       line do
      #         stream do
      #           text '3. Streams can have'
      #         end

      #         stream do
      #           style 'underline'
      #           text  ' styles too.'
      #         end
      #       end
      #     end.must_equal(
      #       { interfaces: [{
      #         name: 'testing_view',
      #         group: '',
      #         colour: {},
      #         style: '',
      #         geometry: {},
      #         cursor: true,
      #         delay: 0.0,
      #         lines: [
      #           {
      #             parent: nil,
      #             colour: {},
      #             style: [],
      #             streams: [
      #               {
      #                 colour: {},
      #                 style: [],
      #                 text: '3. Streams can have',
      #                 width: nil,
      #                 align: :left,
      #                 parent: nil,
      #               }, {
      #                 colour: {},
      #                 style: ['underline'],
      #                 text: ' styles too.',
      #                 width: nil,
      #                 align: :left,
      #                 parent: nil,
      #               }
      #             ]
      #           }
      #         ]
      #       }] }
      #     )
      #   end

      #   it 'handles alignment' do
      #     Vedeu.view 'testing_view' do
      #       line do
      #         stream do
      #           width 80
      #           text  'This is aligned left, and padded with spaces.'
      #         end
      #       end
      #     end.must_equal(
      #       { interfaces: [{
      #         name:  'testing_view',
      #         group: '',
      #         colour: {},
      #         style: '',
      #         geometry: {},
      #         cursor: true,
      #         delay: 0.0,
      #         lines: [{
      #           parent: nil,
      #           colour:  {},
      #           style:   [],
      #           streams: [{
      #             parent: nil,
      #             align:  :left,
      #             colour: {},
      #             style:  [],
      #             width:  80,
      #             text:   'This is aligned left, and padded with spaces.'
      #           }]
      #         }]
      #       }] }
      #     )
      #   end

      #   it 'handles alignment' do
      #     Vedeu.view 'testing_view' do
      #       line do
      #         stream do
      #           width 80
      #           align :left # explicit
      #           text  'This is aligned left, and padded with spaces.'
      #         end
      #       end
      #     end.must_equal(
      #       { interfaces: [{
      #         name:  'testing_view',
      #         group: '',
      #         colour: {},
      #         style: '',
      #         geometry: {},
      #         cursor: true,
      #         delay: 0.0,
      #         lines: [{
      #           parent: nil,
      #           colour:  {},
      #           style:   [],
      #           streams: [{
      #             parent: nil,
      #             colour: {},
      #             style:  [],
      #             width:  80,
      #             align:  :left,
      #             text:   'This is aligned left, and padded with spaces.'
      #           }]
      #         }]
      #       }] }
      #     )
      #   end

      #   it 'handles alignment' do
      #     Vedeu.view 'testing_view' do
      #       line do
      #         stream do
      #           width 80
      #           align :centre
      #           text  'This is aligned centrally, and padded with spaces.'
      #         end
      #       end
      #     end.must_equal(
      #       { interfaces: [{
      #         name:  'testing_view',
      #         group: '',
      #         colour: {},
      #         style: '',
      #         geometry: {},
      #         cursor: true,
      #         delay: 0.0,
      #         lines: [{
      #           parent: nil,
      #           colour:  {},
      #           style:   [],
      #           streams: [{
      #             parent: nil,
      #             colour: {},
      #             style:  [],
      #             width:  80,
      #             align:  :centre,
      #             text:   'This is aligned centrally, and padded with spaces.'
      #           }]
      #         }]
      #       }] }
      #     )
      #   end

      #   it 'handles alignment' do
      #     Vedeu.view 'testing_view' do
      #       line do
      #         stream do
      #           width 80
      #           align :right
      #           text  'This is aligned right, and padded with spaces.'
      #         end
      #       end
      #     end.must_equal(
      #       { interfaces: [{
      #         name:  'testing_view',
      #         group: '',
      #         colour: {},
      #         style: '',
      #         geometry: {},
      #         cursor: true,
      #         delay: 0.0,
      #         lines: [{
      #           parent: nil,
      #           colour:  {},
      #           style:   [],
      #           streams: [{
      #             parent: nil,
      #             colour: {},
      #             style:  [],
      #             width:  80,
      #             align:  :right,
      #             text:   'This is aligned right, and padded with spaces.'
      #           }]
      #         }]
      #       }] }
      #     )
      #   end

      #   it 'handles multiple colour and text statements correctly' do
      #     Vedeu.view 'testing_view' do
      #       line do
      #         foreground('#ffff00') { text "\u{25B2}" }
      #         text " Prev"

      #         foreground('#ffff00') { text "\u{25BC}" }
      #         text " Next"

      #         foreground('#ffff00') { text "\u{21B2}" }
      #         text " Select"

      #         foreground('#ffff00') { text "\u{2395}" }
      #         text " Pause"

      #         foreground('#ffff00') { text "Q" }
      #         text " Quit"
      #       end
      #     end.must_equal(
      #       { interfaces: [{
      #         name:  'testing_view',
      #         group: '',
      #         colour: {},
      #         style: '',
      #         geometry: {},
      #         cursor: true,
      #         delay: 0.0,
      #         lines: [
      #           {
      #             parent: nil,
      #             colour:  {},
      #             style:   [],
      #             streams: [
      #               {
      #                 colour: {
      #                   foreground: "#ffff00"
      #                 },
      #                 style: [],
      #                 text: "▲",
      #                 width: nil,
      #                 align: :left,
      #                 parent: nil,
      #               }, {
      #                 text: " Prev",
      #               }, {
      #                 colour: {
      #                   foreground: "#ffff00"
      #                 },
      #                 style: [],
      #                 text: "▼",
      #                 width: nil,
      #                 align: :left,
      #                 parent: nil,
      #               }, {
      #                 text: " Next",
      #               }, {
      #                 colour: {
      #                   foreground: "#ffff00"
      #                 },
      #                 style: [],
      #                 text: "↲",
      #                 width: nil,
      #                 align: :left,
      #                 parent: nil,
      #               }, {
      #                 text: " Select",
      #               }, {
      #                 colour: {
      #                   foreground: "#ffff00"
      #                 },
      #                 style: [],
      #                 text: "⎕",
      #                 width: nil,
      #                 align: :left,
      #                 parent: nil,
      #               }, {
      #                 text: " Pause",
      #               }, {
      #                 colour: {
      #                   foreground: "#ffff00"
      #                 },
      #                 style: [],
      #                 text: "Q",
      #                 width: nil,
      #                 align: :left,
      #                 parent: nil,
      #               }, {
      #                 text: " Quit",
      #               }
      #             ]
      #           }
      #         ]
      #       }] }
      #     )
      #   end

      #   it 'allows inline values for line' do
      #     Vedeu.interface 'helium' do
      #     end
      #     attributes = Vedeu.view 'helium' do
      #       line 'A headline, if you will.'
      #       line # with a spacer line
      #       line 'This is a line of text...'
      #       line do
      #         text '...we can mix and match...'
      #       end
      #       line '...to our hearts content.'
      #     end
      #     attributes[:interfaces].first[:lines].size.must_equal(5)
      #   end
      # end

      describe '#use' do
        it 'returns the interface by name' do
          interface = Vedeu.interface('tungsten') {}

          Interface.new.use('tungsten').must_be_instance_of(Vedeu::Interface)
        end
      end

      describe '#line' do
        it 'adds a blank line with no arguments' do
          interface = Vedeu.interface 'carbon' do
            line
          end
          interface.must_be_instance_of(API::Interface)
          interface.attributes.must_equal(
            {
              name: "carbon",
              group: "",
              lines: [
                {
                  colour: {},
                  streams: {
                    text: ""
                  },
                  style: [],
                  parent: interface,
                }
              ],
              colour: {},
              style: "",
              geometry: {},
              cursor: true,
              delay: 0.0,
              parent: nil,
            }
          )
        end

        it 'adds a line directly with a value and no block' do
          interface = Vedeu.interface 'carbon' do
            line 'This is some text...'
          end
          interface.must_be_instance_of(API::Interface)
          interface.attributes.must_equal(
            {
              name: "carbon",
              group: "",
              lines: [
                {
                  colour: {},
                  streams: {
                    text: "This is some text..."
                  },
                  style: [],
                  parent: interface,
                }
              ],
              colour: {},
              style: "",
              geometry: {},
              cursor: true,
              delay: 0.0,
              parent: nil,
            }
          )
        end

        it 'allows the addition of more attributes with a block' do
          interface = Vedeu.interface 'silicon' do
            line do
              text 'This is different text...'
            end
          end
          interface.must_be_instance_of(API::Interface)
          interface.attributes.must_equal(
            {
              name: "silicon",
              group: "",
              lines: [
                {
                  colour: {},
                  streams: [
                    {
                      text: "This is different text..."
                    }
                  ],
                  style: [],
                  parent: interface,
                }
              ],
              colour: {},
              style: "",
              geometry: {},
              cursor: true,
              delay: 0.0,
              parent: nil
            }
          )
        end
      end

      describe '#cursor' do
        it 'raises an exception if the value is invalid' do
          proc {
            Vedeu.interface 'beryllium' do
              cursor :invalid
            end
          }.must_raise(InvalidSyntax)
        end

        it 'sets the cursor to true (visible)' do
          Vedeu.interface 'beryllium' do
            cursor true
          end

          Vedeu.use('beryllium').attributes[:cursor].must_equal(true)
        end

        it 'sets the cursor to false (hidden)' do
          Vedeu.interface 'beryllium' do
            cursor false
          end

          Vedeu.use('beryllium').attributes[:cursor].must_equal(false)
        end
      end

      describe '#delay' do
        it 'sets the delay attribute' do
          Vedeu.interface 'cobalt' do
            delay 0.25
          end

          Vedeu.use('cobalt').attributes[:delay].must_equal(0.25)
        end
      end

      describe '#group' do
        it 'sets the group attribute' do
          Vedeu.interface 'iron' do
            group 'elements'
          end

          Vedeu.use('iron').attributes[:group].must_equal('elements')
        end
      end

      describe '#name' do
        it 'sets the name attribute' do
          Vedeu.interface do
            name 'nickel'
          end

          Vedeu.use('nickel').attributes[:name].must_equal('nickel')
        end
      end

      describe '#x' do
        it 'sets the attribute to the block if a block is given' do
          skip
        end

        it 'sets the attribute to the value if a block is not given' do
          skip
        end
      end

      describe '#y' do
        it 'sets the attribute to the block if a block is given' do
          skip
        end

        it 'sets the attribute to the value if a block is not given' do
          skip
        end
      end

      describe '#width' do
        it 'sets the attribute to the value' do
          skip
        end
      end

      describe '#height' do
        it 'sets the attribute to the value' do
          skip
        end
      end

      describe '#centred' do
        it 'raises an exception if the value is invalid' do
          proc {
            Vedeu.interface 'boron' do
              centred :invalid
            end
          }.must_raise(InvalidSyntax)
        end

        it 'sets the centred to true (visible)' do
          Vedeu.interface 'boron' do
            centred true
          end

          Vedeu.use('boron').attributes[:geometry][:centred].must_equal(true)
        end

        it 'sets the centred to false (hidden)' do
          Vedeu.interface 'boron' do
            centred false
          end

          Vedeu.use('boron').attributes[:geometry][:centred].must_equal(false)
        end
      end
    end
  end
end
