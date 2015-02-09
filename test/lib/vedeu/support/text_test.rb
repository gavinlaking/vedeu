require 'test_helper'

module Vedeu

  describe Text do

    let(:value)   { 'Testing the Text class with various options' }
    let(:options) {
      {
        anchor: anchor,
        pad:    pad,
        width:  width,
      }
    }
    let(:anchor) { :left }
    let(:pad)    { ' ' }
    let(:width)  { nil }

    describe '.with' do
      context 'when a width is provided' do
        context 'when value longer than the width' do
          let(:width) { 23 }

          it 'returns the value truncated' do
            Text.with(value, options).must_equal('Testing the Text class ')
          end
        end

        context 'when value is shorter or equal to the width' do
          let(:width) { 48 }

          context 'and an anchor is not set' do
            it 'returns the value left aligned' do
              Text.with(value, options)
                .must_equal('Testing the Text class with various options     ')
            end
          end

          context 'and the anchor is set to :left' do
            it 'returns the value left aligned' do
              Text.with(value, options)
                .must_equal('Testing the Text class with various options     ')
            end
          end

          context 'and the anchor is set to :align' do
            let(:anchor) { :align }

            it 'returns the value left aligned' do
              Text.with(value, options)
                .must_equal('Testing the Text class with various options     ')
            end
          end

          context 'and the anchor is set to centre' do
            let(:anchor) { :centre }

            it 'returns the value centre aligned' do
              Text.with(value, options)
                .must_equal('  Testing the Text class with various options   ')
            end
          end

          context 'and the anchor is set to right' do
            let(:anchor) { :right }

            it 'returns the value right aligned' do
              Text.with(value, options)
                .must_equal('     Testing the Text class with various options')
            end
          end

          context 'and the anchor is invalid' do
            let(:anchor) { :invalid }

            it 'returns the value left aligned' do
              Text.with(value, options)
                .must_equal('Testing the Text class with various options     ')
            end
          end
        end
      end

      context 'when a width is not provided' do
        it 'returns the value as a string' do
          Text.with(:some_value).must_equal('some_value')
        end
      end
    end

  end # Text

end # Vedeu
