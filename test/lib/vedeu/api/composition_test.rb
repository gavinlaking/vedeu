require 'test_helper'

module Vedeu
  module API
    describe Composition do
      describe '#view' do
      end

      describe '#views' do
        it 'allows multiple views to be defined at once' do
          attrs = Vedeu.views do
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
          end
          attrs[:interfaces].size.must_equal(2)
        end

        it 'raises an exception when a block is not given' do
          proc { Vedeu.views }.must_raise(InvalidSyntax)
        end
      end
    end
  end
end
