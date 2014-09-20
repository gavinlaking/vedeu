require 'test_helper'

module Vedeu
  module API
    describe Line do
      describe '#stream' do
        it 'returns the value assigned' do
          line  = Line.new
          attrs = line.stream do
            text 'Some text...'
          end

          attrs.must_equal(
            [
              {
                colour: {},
                style:  [],
                text:   "Some text...",
                width:  nil,
                align:  :left,
                parent: line.view_attributes,
              }
            ]
          )
        end

        it 'raises an exception if a block was not given' do
          proc {
            Vedeu.view 'carbon' do
              line do
                stream
              end
            end
          }.must_raise(InvalidSyntax)
        end
      end

      describe '#text' do
        it 'returns the value assigned' do
          Line.new.text('Some text...').must_equal(
            [
              { text: 'Some text...' }
            ]
          )
        end
      end

      describe '#foreground' do
        it 'returns the value assigned' do
          attrs = Line.new.foreground('#ff0000')
          attrs.first[:colour].must_equal({ foreground: '#ff0000' })
        end

        it 'returns the value assigned with a block' do
          attrs = Line.new.foreground('#00ff00') do
            # ...
          end
          attrs.first[:colour].must_equal({ foreground: '#00ff00' })
        end
      end

      describe '#background' do
        it 'returns the value assigned' do
          attrs = Line.new.background('#00ff00')
          attrs.first[:colour].must_equal({ background: '#00ff00' })
        end

        it 'returns the value assigned with a block' do
          attrs = Line.new.background('#0000ff') do
            # ...
          end
          attrs.first[:colour].must_equal({ background: '#0000ff' })
        end
      end
    end
  end
end
