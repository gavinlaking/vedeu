require 'test_helper'

require 'vedeu/api/view'
require 'vedeu'

module Vedeu
  module API
    describe View do
      before do
        InterfaceStore.reset
        InterfaceTemplate.save('testing_view') do
          width  80
          height 25
          x      1
          y      1
          colour  foreground: '#ffffff', background: '#000000'
          centred false
        end
      end

      it 'builds a basic view' do
        Vedeu.view 'testing_view' do
          line do
            text '1. A line of text.'
            text '2. Another line of text.'
          end

          # line do
          #   text "3. These lines will split\ninternally into multiple lines."
          # end
        end.must_equal(
          {
            name:  'testing_view',
            lines: [
              { streams: [{ text: '1. A line of text.' }] },
              { streams: [{ text: '2. Another line of text.' }] }
            ]
          }
        )
      end

      it 'handles coloured lines' do
        Vedeu.view 'testing_view' do
          line do
            text '1. Line without colours.'
          end

          line do
            colour '#ff0000', '#ffff00'
            text   '2. Line with colours.'
          end

          line do
            colour foreground: '#a7ff00', background: '#005700'
            text   '3. Line with explicit colour declaration.'
          end

          line do # actually uses streams
            foreground '#ff00ff' do
              text '4. Line with only foreground set.'
            end
          end

          line do # actually uses streams
            background '#00ff00' do
              text '5. Line with only background set.'
            end
          end
        end.must_equal(
          {
            name:  'testing_view',
            lines: [
              {
                streams: [{ text: '1. Line without colours.' }]
              }, {
                colour:  { background: '#ff0000', foreground: '#ffff00' },
                streams: [{ text: '2. Line with colours.' }]
              }, {
                colour:  { background: '#005700', foreground: '#a7ff00' },
                streams: [{ text: '3. Line with explicit colour declaration.' }]
              }, {
                streams: [{
                  colour: { background: '', foreground: '#ff00ff' },
                  text:   '4. Line with only foreground set.'
                }]
              }, {
                streams: [{
                  colour: { background: '#00ff00', foreground: '' },
                  text:   '5. Line with only background set.'
                }]
              }
            ]
          }
        )
      end

      it 'handles styles' do
        Vedeu.view 'testing_view' do
          line do
            style 'normal'
            text  '1. Line with a normal style.'
          end

          line do
            style 'underline'
            text  '2. Line with an underline style.'
          end

          line do # actually uses streams
            style 'normal' do
              text '3. Line with a normal style.'
            end
          end

          line do # actually uses streams
            style 'underline' do
              text '4. Line with an underlined style.'
            end
          end
        end.must_equal(
          {
            name: 'testing_view',
            lines: [
              {
                style:   'normal',
                streams: [{
                  text: '1. Line with a normal style.'
                }]
              }, {
                style:   'underline',
                streams: [{
                  text: '2. Line with an underline style.'
                }]
              }, {
                streams: [{
                  style: 'normal',
                  text:  '3. Line with a normal style.'
                }]
              }, {
                streams: [{
                  style: 'underline',
                  text:  '4. Line with an underlined style.'
                }]
              }
            ]
          }
        )
      end

      it 'handles streams, which means sub-line colours and styles' do
        Vedeu.view 'testing_view' do
          line do
            stream do
              text 'A stream of text.'
            end
          end.must_equal(

        )
      end

      it 'handles streams, which means sub-line colours and styles' do
        Vedeu.line do
            stream do # Stream is an 'explicit declaration'.
                      # We don't need it unless we want to add colours and styles.
                      # See below.
              text '1. Two streams of text, these will be'
            end

            stream do
              text ' on the same line- note the space.'
            end
          end.must_equal(

        )
      end

      it 'handles streams, which means sub-line colours and styles' do
        Vedeu.line do
            stream do
              text '2. Streams can have'
            end

            stream do
              colour foreground: '#ff0000', background: '#00ff00'
              text   ' colours too.'
            end
          end.must_equal(

        )
      end

      it 'handles streams, which means sub-line colours and styles' do
        Vedeu.line do
            stream do
              text '3. Streams can have'
            end

            stream do
              style 'underline'
              text  ' styles too.'
            end
          end
        end.must_equal(

        )
      end

      it 'handles alignment' do
        Vedeu.view 'testing_view' do
          line do
            width 80
            text  'This is aligned left, and padded with spaces.'
          end
        end.must_equal(
          {
            name:  'testing_view',
            lines: [{
              streams: [{
                width: 80,
                text:  'This is aligned left, and padded with spaces.'
              }]
            }]
          }
        )
      end

      it 'handles alignment' do
        Vedeu.view 'testing_view' do
          line do
            width 80
            align :left # explicit
            text  'This is aligned left, and padded with spaces.'
          end
        end.must_equal(
          {
            name:  'testing_view',
            lines: [{
              streams: [{
                width: 80,
                align: :left,
                text:  'This is aligned left, and padded with spaces.'
              }]
            }]
          }
        )
      end

      it 'handles alignment' do
        Vedeu.view 'testing_view' do
          line do
            width 80
            align :centre
            text  'This is aligned centrally, and padded with spaces.'
          end
        end.must_equal(
          {
            name:  'testing_view',
            lines: [{
              streams: [{
                width: 80,
                align: :centre,
                text:  'This is aligned right, and padded with spaces.'
              }]
            }]
          }
        )
      end

      it 'handles alignment' do
        Vedeu.view 'testing_view' do
          line do
            width 80
            align :right
            text  'This is aligned right, and padded with spaces.'
          end
        end.must_equal(
          {
            name:  'testing_view',
            lines: [{
              streams: [{
                width: 80,
                align: :right,
                text:  'This is aligned right, and padded with spaces.'
              }]
            }]
          }
        )
      end
    end
  end
end
