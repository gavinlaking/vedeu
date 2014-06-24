require_relative '../../../../test_helper'

module Vedeu
  module Buffer
    describe Stream do
      let(:described_class)    { Stream }
      let(:described_instance) { described_class.new(attributes) }
      let(:subject)            { described_instance }
      let(:attributes)         {
        {
          style:      'normal',
          foreground: :red,
          background: :black,
          text:       'Some text'
        }
      }

      it 'returns a Stream instance' do
        subject.must_be_instance_of(Stream)
      end

      it 'has a foreground attribute' do
        subject.foreground.must_be_instance_of(Symbol)

        subject.foreground.must_equal(:red)
      end

      it 'has a background attribute' do
        subject.background.must_be_instance_of(Symbol)

        subject.background.must_equal(:black)
      end

      it 'has a text attribute' do
        subject.text.must_be_instance_of(String)

        subject.text.must_equal('Some text')
      end

      it 'has a style attribute' do
        subject.style.must_be_instance_of(Array)

        subject.style.must_equal([:normal])
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
