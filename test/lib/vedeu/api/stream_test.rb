require 'test_helper'

module Vedeu

  module API

    describe Stream do

      describe '#align' do
        it { return_type_for(Stream.new.align(:left), Symbol) }

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

    end # Stream

  end # API

end # Vedeu
