require 'test_helper'

module Vedeu
  module API
    describe Stream do
      describe '#align' do
        it 'returns a Symbol' do
          Stream.new.align(:left).must_be_instance_of(Symbol)
        end

        it 'returns the value assigned' do
          Stream.new.align(:left).must_equal(:left)
        end

        it 'returns the value assigned' do
          Stream.new.align('left').must_equal(:left)
        end

        it 'raises an exception if the value is invalid' do
          proc { Stream.new.align(:unknown) }.must_raise(InvalidSyntax)
        end
      end

      describe '#background' do
        it 'returns a Hash' do
          Stream.new.background('#00ff00').must_be_instance_of(Hash)
        end

        it 'returns the value assigned' do
          Stream.new.background('#00ff00').must_equal({ background: '#00ff00' })
        end

        it 'raises an exception if the value is not defined' do
          proc { Stream.new.background('') }.must_raise(InvalidSyntax)
        end
      end

      describe '#foreground' do
        it 'returns a Hash' do
          Stream.new.foreground('#00ff00').must_be_instance_of(Hash)
        end

        it 'returns the value assigned' do
          Stream.new.foreground('#00ff00').must_equal({ foreground: '#00ff00' })
        end

        it 'raises an exception if the value is not defined' do
          proc { Stream.new.foreground('') }.must_raise(InvalidSyntax)
        end
      end

      describe '#left' do
        it 'returns a Symbol' do
          Stream.new.left.must_equal(:left)
        end
      end

      describe '#right' do
        it 'returns a Symbol' do
          Stream.new.right.must_equal(:right)
        end
      end

      describe '#centre' do
        it 'returns a Symbol' do
          Stream.new.centre.must_equal(:centre)
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
