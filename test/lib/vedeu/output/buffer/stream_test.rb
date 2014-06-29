require_relative '../../../../test_helper'

module Vedeu
  module Buffer
    describe Stream do
      let(:described_class)    { Stream }
      let(:described_instance) { described_class.new(attributes) }
      let(:attributes)         {
        {
          style:      'normal',
          foreground: :red,
          background: :black,
          text:       'Some text'
        }
      }

      describe '#initialize' do
        let(:subject) { described_instance }

        it 'returns a Stream instance' do
          subject.must_be_instance_of(Stream)
        end
      end

      describe '#foreground' do
        let(:subject) { described_instance.foreground }

        it 'has a foreground attribute' do
          subject.must_be_instance_of(Symbol)

          subject.must_equal(:red)
        end
      end

      describe '#background' do
        let(:subject) { described_instance.background }

        it 'has a background attribute' do
          subject.must_be_instance_of(Symbol)

          subject.must_equal(:black)
        end
      end

      describe '#text' do
        let(:subject) { described_instance.text }

        it 'has a text attribute' do
          subject.must_be_instance_of(String)

          subject.must_equal('Some text')
        end
      end

      describe '#style' do
        let(:subject) { described_instance.style }

        it 'has a style attribute' do
          subject.must_be_instance_of(Array)

          subject.must_equal([:normal])
        end
      end

      describe '#to_compositor' do
        let(:subject) { described_instance.to_compositor }

        it 'returns a Hash' do
          subject.must_be_instance_of(Hash)

          subject.must_equal({
            style:  [:normal],
            colour: [:red, :black],
            text:   "Some text"
          })
        end
      end
    end
  end
end
