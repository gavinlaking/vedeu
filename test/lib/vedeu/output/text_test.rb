require 'test_helper'

module Vedeu

  describe Text do

    let(:described) { Vedeu::Text }
    let(:_value)    { 'Testing the Text class with various options' }
    let(:options)   {
      {
        anchor:     anchor,
        background: background,
        colour:     colour,
        foreground: foreground,
        model:      model,
        pad:        pad,
        width:      width,
      }
    }
    let(:anchor)     { :left }
    let(:background) { nil }
    let(:colour)     { nil }
    let(:foreground) { nil }
    let(:model)      { nil }
    let(:pad)        { ' ' }
    let(:width)      { nil }

    describe '.with' do
      subject { described.with(_value, options) }

      context 'when a width is provided' do
        context 'when value longer than the width' do
          let(:width) { 23 }

          it 'returns the value truncated' do
            subject.must_equal('Testing the Text class ')
          end
        end

        context 'when value is shorter or equal to the width' do
          let(:width) { 48 }

          context 'and an anchor is not set' do
            it 'returns the value left aligned' do
              subject
                .must_equal('Testing the Text class with various options     ')
            end
          end

          context 'and the anchor is set to :left' do
            it 'returns the value left aligned' do
              subject
                .must_equal('Testing the Text class with various options     ')
            end
          end

          context 'and the anchor is set to :align' do
            let(:anchor) { :align }

            it 'returns the value left aligned' do
              subject
                .must_equal('Testing the Text class with various options     ')
            end
          end

          context 'and the anchor is set to centre' do
            let(:anchor) { :centre }

            it 'returns the value centre aligned' do
              subject
                .must_equal('  Testing the Text class with various options   ')
            end
          end

          context 'and the anchor is set to right' do
            let(:anchor) { :right }

            it 'returns the value right aligned' do
              subject
                .must_equal('     Testing the Text class with various options')
            end
          end

          context 'and the anchor is invalid' do
            let(:anchor) { :invalid }

            it 'returns the value left aligned' do
              subject
                .must_equal('Testing the Text class with various options     ')
            end
          end
        end
      end

      context 'when a width is not provided' do
        let(:width) {}
        let(:_value) { 'some value' }

        it 'returns the value as a string' do
          subject.must_equal('some value')
        end
      end
    end

    describe '.add' do
      subject { described.add(value, options) }

      context 'when the model is a Vedeu::Interface' do
        let(:model) { Vedeu::Interface.new }

        it { subject.must_be_instance_of(Vedeu::Lines) }
      end

      context 'when the model is a Vedeu::Line' do
        let(:model) { Vedeu::Line.new }

        it { subject.must_be_instance_of(Vedeu::Streams) }
      end

      context 'when the model is a Vedeu::Stream' do
        let(:parent) { Vedeu::Line.new }
        let(:model)  { Vedeu::Stream.new(parent: parent) }

        it { subject.must_be_instance_of(Vedeu::Streams) }
      end

      context 'when the model is not given' do
        let(:model) {}

        it { subject.must_be_instance_of(NilClass) }
      end

      context 'when the colour option is given' do
        let(:colour) { { background: '#33ff33', foreground: '#ffaa00' } }

        # @todo Add more tests.
        # it { skip }
      end

      context 'when the background and/or foreground options are given' do
        let(:background) { '#111111' }
        let(:foreground) { '#aadd00' }

        # @todo Add more tests.
        # it { skip }
      end

    end

  end # Text

end # Vedeu
