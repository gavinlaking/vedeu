# require 'test_helper'

# module Vedeu
#   module API
#     describe Interface do
#       describe '#build' do
#         before do
#           @interface = Vedeu.interface('testing_view') do
#             x       1
#             y       1
#             colour  foreground: '#ffffff', background: '#000000'
#             centred false
#           end
#         end

#         it 'builds a basic view' do
#           Vedeu.view 'testing_view' do
#             line do
#               text '1. A line of text.'
#               text '2. Another line of text.'
#             end
#           end.must_equal(
#             { interfaces: [{
#               name:  'testing_view',
#               group: '',
#               colour: {},
#               style: '',
#               geometry: {},
#               delay: 0.0,
#               lines: [
#                 {
#                   parent:  @interface.view_attributes,
#                   colour:  {},
#                   style:   [],
#                   streams: [
#                     {
#                       text:  '1. A line of text.'
#                     }, {
#                       text:  '2. Another line of text.'
#                     }
#                   ]
#                 }
#               ]
#             }] }
#           )
#         end

#         it 'handles coloured lines' do
#           Vedeu.view 'testing_view' do
#             line do
#               text '1. Line without colours.'
#             end
#           end.must_equal(
#             { interfaces: [{
#               name:  'testing_view',
#               group: '',
#               colour: {},
#               style: '',
#               geometry: {},
#               delay: 0.0,
#               lines: [
#                 {
#                   parent:  nil,
#                   colour:  {},
#                   style:   [],
#                   streams: [{ text: '1. Line without colours.' }]
#                 }
#               ]
#             }] }
#           )
#         end

#         it 'handles coloured lines' do
#           Vedeu.view 'testing_view' do
#             line do
#               colour background: '#ff0000', foreground: '#ffff00'
#               text   '2. Line with colours.'
#             end
#           end.must_equal(
#             { interfaces: [{
#               name:  'testing_view',
#               group: '',
#               colour: {},
#               style: '',
#               geometry: {},
#               delay: 0.0,
#               lines: [
#                 {
#                   parent:  nil,
#                   colour:  { background: '#ff0000', foreground: '#ffff00' },
#                   style:   [],
#                   streams: [{ text: '2. Line with colours.' }]
#                 }
#               ]
#             }] }
#           )
#         end

#         it 'handles coloured lines' do
#           Vedeu.view 'testing_view' do
#             line do
#               colour foreground: '#a7ff00', background: '#005700'
#               text   '3. Line with explicit colour declaration.'
#             end
#           end.must_equal(
#             { interfaces: [{
#               name:  'testing_view',
#               group: '',
#               colour: {},
#               style: '',
#               geometry: {},
#               delay: 0.0,
#               lines: [
#                 {
#                   parent: nil,
#                   colour:  { background: '#005700', foreground: '#a7ff00' },
#                   style:   [],
#                   streams: [{ text: '3. Line with explicit colour declaration.' }]
#                 }
#               ]
#             }] }
#           )
#         end

#         it 'handles coloured lines' do
#           Vedeu.view 'testing_view' do
#             line do # actually uses streams
#               foreground '#ff00ff' do
#                 text '4. Line with only foreground set.'
#               end
#             end
#           end.must_equal(
#             { interfaces: [{
#               name:  'testing_view',
#               group: '',
#               colour: {},
#               style: '',
#               geometry: {},
#               delay: 0.0,
#               lines: [
#                 {
#                   parent: nil,
#                   colour:  {},
#                   style:   [],
#                   streams: [{
#                     colour: { foreground: '#ff00ff' },
#                     style:  [],
#                     text:   '4. Line with only foreground set.',
#                     width:  nil,
#                     align:  :left,
#                     parent: nil,
#                   }]
#                 }
#               ]
#             }] }
#           )
#         end

#         it 'handles coloured lines' do
#           Vedeu.view 'testing_view' do
#             line do # actually uses streams
#               background '#00ff00' do
#                 text '5. Line with only background set.'
#               end
#             end
#           end.must_equal(
#             { interfaces: [{
#               name:  'testing_view',
#               group: '',
#               colour: {},
#               style: '',
#               geometry: {},
#               delay: 0.0,
#               lines: [
#                 {
#                   parent: nil,
#                   colour:  {},
#                   style:   [],
#                   streams: [{
#                     colour: { background: '#00ff00' },
#                     style:  [],
#                     text:   '5. Line with only background set.',
#                     width: nil,
#                     align: :left,
#                     parent: nil,
#                   }]
#                 }
#               ]
#             }] }
#           )
#         end

#         it 'handles styles' do
#           Vedeu.view 'testing_view' do
#             line do
#               style 'normal'
#               text  '1. Line with a normal style.'
#             end
#           end.must_equal(
#             { interfaces: [{
#               name: 'testing_view',
#               group: '',
#               colour: {},
#               style: '',
#               geometry: {},
#               delay: 0.0,
#               lines: [
#                 {
#                   parent: nil,
#                   colour:  {},
#                   style:   ['normal'],
#                   streams: [{
#                     text: '1. Line with a normal style.'
#                   }]
#                 }
#               ]
#             }] }
#           )
#         end

#         it 'handles styles' do
#           Vedeu.view 'testing_view' do
#             line do
#               style 'underline'
#               text  '2. Line with an underline style.'
#             end
#           end.must_equal(
#             { interfaces: [{
#               name: 'testing_view',
#               group: '',
#               colour: {},
#               style: '',
#               geometry: {},
#               delay: 0.0,
#               lines: [
#                 {
#                   parent: nil,
#                   colour:  {},
#                   style:   ['underline'],
#                   streams: [{
#                     text: '2. Line with an underline style.'
#                   }]
#                 }
#               ]
#             }] }
#           )
#         end

#         it 'handles styles' do
#           Vedeu.view 'testing_view' do
#             line do # actually uses streams
#               style 'normal' do
#                 text '3. Line with a normal style.'
#               end
#             end
#           end.must_equal(
#             { interfaces: [{
#               name: 'testing_view',
#               group: '',
#               colour: {},
#               style: '',
#               geometry: {},
#               delay: 0.0,
#               lines: [
#                 {
#                   parent: nil,
#                   colour:  {},
#                   style:   [],
#                   streams: [{
#                     colour: {},
#                     style:  ['normal'],
#                     text:   '3. Line with a normal style.',
#                     width:  nil,
#                     align:  :left,
#                     parent: nil,
#                   }]
#                 }
#               ]
#             }] }
#           )
#         end

#         it 'handles styles' do
#           Vedeu.view 'testing_view' do
#             line do # actually uses streams
#               style 'underline' do
#                 text '4. Line with an underlined style.'
#               end
#             end
#           end.must_equal(
#             { interfaces: [{
#               name: 'testing_view',
#               group: '',
#               colour: {},
#               style: '',
#               geometry: {},
#               delay: 0.0,
#               lines: [
#                 {
#                   parent: nil,
#                   colour:  {},
#                   style:   [],
#                   streams: [{
#                     colour: {},
#                     style:  ['underline'],
#                     text:   '4. Line with an underlined style.',
#                     width: nil,
#                     align: :left,
#                     parent: nil,
#                   }]
#                 }
#               ]
#             }] }
#           )
#         end

#         it 'handles streams, which means sub-line colours and styles' do
#           Vedeu.view 'testing_view' do
#             line do
#               stream do
#                 text 'A stream of text.'
#               end
#             end
#           end.must_equal(
#             { interfaces: [{
#               name:  'testing_view',
#               group: '',
#               colour: {},
#               style: '',
#               geometry: {},
#               delay: 0.0,
#               lines: [
#                 {
#                   parent: nil,
#                   colour:  {},
#                   style:   [],
#                   streams: [
#                     {
#                       parent: nil,
#                       colour: {},
#                       style:  [],
#                       text:   'A stream of text.',
#                       width:  nil,
#                       align:  :left
#                     }
#                   ]
#                 }
#               ]
#             }] }
#           )
#         end

#         it 'handles streams, which means sub-line colours and styles' do
#           Vedeu.view 'testing_view' do
#             line do
#               stream do # Stream is an 'explicit declaration'.
#                         # We don't need it unless we want to add colours and styles.
#                         # See below.
#                 text '1. Two streams of text, these will be'
#               end

#               stream do
#                 text ' on the same line- note the space.'
#               end
#             end
#           end.must_equal(
#             { interfaces: [{
#               name:  'testing_view',
#               group: '',
#               colour: {},
#               style: '',
#               geometry: {},
#               delay: 0.0,
#               lines: [
#                 {
#                   parent: nil,
#                   colour:  {},
#                   style:   [],
#                   streams: [
#                     {
#                       colour: {},
#                       style:  [],
#                       text:   '1. Two streams of text, these will be',
#                       width: nil,
#                       align: :left,
#                       parent: nil,
#                     }, {
#                       colour: {},
#                       style:  [],
#                       text:   ' on the same line- note the space.',
#                       width: nil,
#                       align: :left,
#                       parent: nil,
#                     }
#                   ]
#                 }
#               ]
#             }] }
#           )
#         end

#         it 'handles streams, which means sub-line colours and styles' do
#           Vedeu.view 'testing_view' do
#             line do
#               stream do
#                 text '2. Streams can have'
#               end

#               stream do
#                 colour foreground: '#ff0000', background: '#00ff00'
#                 text   ' colours too.'
#               end
#             end
#           end.must_equal(
#             { interfaces: [{
#               name: 'testing_view',
#               group: '',
#               colour: {},
#               style: '',
#               geometry: {},
#               delay: 0.0,
#               lines: [
#                 {
#                   parent: nil,
#                   colour: {},
#                   style: [],
#                   streams: [
#                     {
#                       colour: {},
#                       style: [],
#                       text: '2. Streams can have',
#                       width: nil,
#                       align: :left,
#                       parent: nil,
#                     }, {
#                       colour: {
#                         foreground: '#ff0000',
#                         background: '#00ff00'
#                       },
#                       style: [],
#                       text: ' colours too.',
#                       width: nil,
#                       align: :left,
#                       parent: nil,
#                     }
#                   ]
#                 }
#               ]
#             }] }
#           )
#         end

#         it 'handles streams, which means sub-line colours and styles' do
#           Vedeu.view 'testing_view' do
#             line do
#               stream do
#                 text '3. Streams can have'
#               end

#               stream do
#                 style 'underline'
#                 text  ' styles too.'
#               end
#             end
#           end.must_equal(
#             { interfaces: [{
#               name: 'testing_view',
#               group: '',
#               colour: {},
#               style: '',
#               geometry: {},
#               delay: 0.0,
#               lines: [
#                 {
#                   parent: nil,
#                   colour: {},
#                   style: [],
#                   streams: [
#                     {
#                       colour: {},
#                       style: [],
#                       text: '3. Streams can have',
#                       width: nil,
#                       align: :left,
#                       parent: nil,
#                     }, {
#                       colour: {},
#                       style: ['underline'],
#                       text: ' styles too.',
#                       width: nil,
#                       align: :left,
#                       parent: nil,
#                     }
#                   ]
#                 }
#               ]
#             }] }
#           )
#         end

#         it 'handles alignment' do
#           Vedeu.view 'testing_view' do
#             line do
#               stream do
#                 width 80
#                 text  'This is aligned left, and padded with spaces.'
#               end
#             end
#           end.must_equal(
#             { interfaces: [{
#               name:  'testing_view',
#               group: '',
#               colour: {},
#               style: '',
#               geometry: {},
#               delay: 0.0,
#               lines: [{
#                 parent: nil,
#                 colour:  {},
#                 style:   [],
#                 streams: [{
#                   parent: nil,
#                   align:  :left,
#                   colour: {},
#                   style:  [],
#                   width:  80,
#                   text:   'This is aligned left, and padded with spaces.'
#                 }]
#               }]
#             }] }
#           )
#         end

#         it 'handles alignment' do
#           Vedeu.view 'testing_view' do
#             line do
#               stream do
#                 width 80
#                 align :left # explicit
#                 text  'This is aligned left, and padded with spaces.'
#               end
#             end
#           end.must_equal(
#             { interfaces: [{
#               name:  'testing_view',
#               group: '',
#               colour: {},
#               style: '',
#               geometry: {},
#               delay: 0.0,
#               lines: [{
#                 parent: nil,
#                 colour:  {},
#                 style:   [],
#                 streams: [{
#                   parent: nil,
#                   colour: {},
#                   style:  [],
#                   width:  80,
#                   align:  :left,
#                   text:   'This is aligned left, and padded with spaces.'
#                 }]
#               }]
#             }] }
#           )
#         end

#         it 'handles alignment' do
#           Vedeu.view 'testing_view' do
#             line do
#               stream do
#                 width 80
#                 align :centre
#                 text  'This is aligned centrally, and padded with spaces.'
#               end
#             end
#           end.must_equal(
#             { interfaces: [{
#               name:  'testing_view',
#               group: '',
#               colour: {},
#               style: '',
#               geometry: {},
#               delay: 0.0,
#               lines: [{
#                 parent: nil,
#                 colour:  {},
#                 style:   [],
#                 streams: [{
#                   parent: nil,
#                   colour: {},
#                   style:  [],
#                   width:  80,
#                   align:  :centre,
#                   text:   'This is aligned centrally, and padded with spaces.'
#                 }]
#               }]
#             }] }
#           )
#         end

#         it 'handles alignment' do
#           Vedeu.view 'testing_view' do
#             line do
#               stream do
#                 width 80
#                 align :right
#                 text  'This is aligned right, and padded with spaces.'
#               end
#             end
#           end.must_equal(
#             { interfaces: [{
#               name:  'testing_view',
#               group: '',
#               colour: {},
#               style: '',
#               geometry: {},
#               delay: 0.0,
#               lines: [{
#                 parent: nil,
#                 colour:  {},
#                 style:   [],
#                 streams: [{
#                   parent: nil,
#                   colour: {},
#                   style:  [],
#                   width:  80,
#                   align:  :right,
#                   text:   'This is aligned right, and padded with spaces.'
#                 }]
#               }]
#             }] }
#           )
#         end

#         it 'handles multiple colour and text statements correctly' do
#           Vedeu.view 'testing_view' do
#             line do
#               foreground('#ffff00') { text "\u{25B2}" }
#               text " Prev"

#               foreground('#ffff00') { text "\u{25BC}" }
#               text " Next"

#               foreground('#ffff00') { text "\u{21B2}" }
#               text " Select"

#               foreground('#ffff00') { text "\u{2395}" }
#               text " Pause"

#               foreground('#ffff00') { text "Q" }
#               text " Quit"
#             end
#           end.must_equal(
#             { interfaces: [{
#               name:  'testing_view',
#               group: '',
#               colour: {},
#               style: '',
#               geometry: {},
#               delay: 0.0,
#               lines: [
#                 {
#                   parent: nil,
#                   colour:  {},
#                   style:   [],
#                   streams: [
#                     {
#                       colour: {
#                         foreground: "#ffff00"
#                       },
#                       style: [],
#                       text: "▲",
#                       width: nil,
#                       align: :left,
#                       parent: nil,
#                     }, {
#                       text: " Prev",
#                     }, {
#                       colour: {
#                         foreground: "#ffff00"
#                       },
#                       style: [],
#                       text: "▼",
#                       width: nil,
#                       align: :left,
#                       parent: nil,
#                     }, {
#                       text: " Next",
#                     }, {
#                       colour: {
#                         foreground: "#ffff00"
#                       },
#                       style: [],
#                       text: "↲",
#                       width: nil,
#                       align: :left,
#                       parent: nil,
#                     }, {
#                       text: " Select",
#                     }, {
#                       colour: {
#                         foreground: "#ffff00"
#                       },
#                       style: [],
#                       text: "⎕",
#                       width: nil,
#                       align: :left,
#                       parent: nil,
#                     }, {
#                       text: " Pause",
#                     }, {
#                       colour: {
#                         foreground: "#ffff00"
#                       },
#                       style: [],
#                       text: "Q",
#                       width: nil,
#                       align: :left,
#                       parent: nil,
#                     }, {
#                       text: " Quit",
#                     }
#                   ]
#                 }
#               ]
#             }] }
#           )
#         end

#         it 'allows inline values for line' do
#           Vedeu.interface 'helium' do
#           end
#           attributes = Vedeu.view 'helium' do
#             line 'A headline, if you will.'
#             line # with a spacer line
#             line 'This is a line of text...'
#             line do
#               text '...we can mix and match...'
#             end
#             line '...to our hearts content.'
#           end
#           attributes[:interfaces].first[:lines].size.must_equal(5)
#         end
#       end
#     end
#   end
# end
