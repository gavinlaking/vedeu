require 'test_helper'

module Vedeu
  module API
    describe Stream do
      describe '#align' do
        it 'returns the value assigned' do
          Stream.new.align(:left).must_equal(:left)
        end
      end

      describe '#text' do
        it 'returns the value assigned' do
          Stream.new.text('Some text...').must_equal('Some text...')
        end
      end

      describe '#width' do
        it 'returns the value assigned' do
          Stream.new.text(30).must_equal(30)
        end
      end
    end
  end
end
