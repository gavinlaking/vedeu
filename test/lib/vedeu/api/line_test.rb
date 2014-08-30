require 'test_helper'

module Vedeu
  module API
    describe Line do
      describe '#stream' do
        it 'returns the value assigned' do
          Line.new.stream do
            text 'Some text...'
          end.must_equal(
            [
              {
                colour: {},
                style: [],
                text: "Some text...",
                width: nil,
                align: :left
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
          Line.new.foreground('#ff0000').must_equal(
            [
              {
                colour: {
                  foreground: "#ff0000"
                },
                style: [],
                text: "",
                width: nil,
                align: :left
              }
            ]
          )
        end
      end

      describe '#background' do
        it 'returns the value assigned' do
          Line.new.background('#00ff00').must_equal(
            [
              {
                colour: {
                  background: "#00ff00"
                },
                style: [],
                text: "",
                width: nil,
                align: :left
              }
            ]
          )
        end
      end
    end
  end
end
