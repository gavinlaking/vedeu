require 'test_helper'

module Vedeu
  module API
    class HelpersTestClass
      include Helpers

      attr_accessor :attributes

      def initialize
        @attributes = { streams: [], style: [] }
      end
    end

    describe Helpers do
      describe '#colour' do
        it 'raises an exception if neither a :foreground or :background ' \
           'attribute exists' do
          proc { HelpersTestClass.new.colour({}) }.must_raise(InvalidSyntax)
        end

        it 'sets the attribute when a :foreground is given' do
          HelpersTestClass.new.colour({ foreground: '#ff0000' })
            .must_equal({ foreground: '#ff0000' })
        end

        it 'sets the attribute when a :background is given' do
          HelpersTestClass.new.colour({ background: '#ff0000' })
            .must_equal({ background: '#ff0000' })
        end
      end

      describe '#style' do
        it 'return an empty collection with no arguments' do
          HelpersTestClass.new.style.must_equal([])
        end

        it 'return a collection containing the style' do
          HelpersTestClass.new.style('normal').must_equal(['normal'])
        end

        it 'return a collection containing the styles' do
          HelpersTestClass.new.style(['bold', 'underline'])
            .must_equal(['bold', 'underline'])
        end

        it 'returns Stream attributes with an empty block' do
          HelpersTestClass.new.style do
            #...
          end.must_equal(
            [{ colour: {}, style: [], text: '', width: nil, align: :left, parent: nil, }]
          )
        end

        it 'returns Stream attributes with a block' do
          HelpersTestClass.new.style do
            style 'italic'
          end.must_equal(
            [
              {
                colour: {},
                style: ['italic'],
                text: '',
                width: nil,
                align: :left,
                parent: nil,
              }
            ]
          )
        end

        it 'returns Stream attributes with a block' do
          HelpersTestClass.new.style do
            style ['italic', 'blink']
          end.must_equal(
            [
              {
                colour: {},
                style: ['italic', 'blink'],
                text: '',
                width: nil,
                align: :left,
                parent: nil,
              }
            ]
          )
        end
      end
    end
  end
end
