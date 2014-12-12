require 'test_helper'

module Vedeu

  module DSL

    describe Stream do

      describe '#align' do
        it 'returns the string aligned and added to the Stream' do
          skip

          stream = Vedeu::Stream.build do
            align 'This is added to the stream.', width: 30
          end

          stream.text.must_equal('This is added to the stream.  ')
        end

        context 'alias_method' do
          context ':left' do
            it 'returns the string aligned and added to the Stream' do
              skip

              stream = Vedeu::Stream.build do
                left 'This is added to the stream.', width: 30
              end

              stream.text.must_equal('This is added to the stream.  ')
            end
          end

          context ':centre/:center' do
            it 'returns the string aligned and added to the Stream' do
              skip

              stream = Vedeu::Stream.build do
                centre 'This is added to the stream.', width: 30
              end

              stream.text.must_equal(' This is added to the stream. ')
            end
          end

          context ':right' do
            it 'returns the string aligned and added to the Stream' do
              skip

              stream = Vedeu::Stream.build do
                right '  This is added to the stream.', width: 30
              end

              stream.text.must_equal('  This is added to the stream.')
            end

            it 'ignores the anchor option when provided' do
              skip

              stream = Vedeu::Stream.build do
                right 'This is added to the stream.', width: 30, anchor: :left
              end

              stream.text.must_equal('  This is added to the stream.')
            end
          end
        end
      end

      describe '#text' do
        it 'adds the string to the Stream' do
          skip

          stream = Vedeu::Stream.build do
            text 'This is added to the stream.'
          end

          stream.text.must_equal('This is added to the stream.')
        end

        context 'multiple calls' do
          it 'adds the strings to the Stream' do
            skip

            stream = Vedeu::Stream.build do
              text 'This is added to the stream. '
              text 'This is also added to the stream.'
            end

            stream.text.must_equal(
              'This is added to the stream. This is also added to the stream.'
            )
          end
        end
      end

    end # Stream

  end # DSL

end # Vedeu
