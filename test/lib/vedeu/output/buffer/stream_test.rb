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
      end

      it 'has a background attribute' do
        subject.background.must_be_instance_of(Symbol)
      end

      it 'has a text attribute' do
        subject.text.must_be_instance_of(String)
      end

      it 'has a style attribute' do
        subject.style.must_be_instance_of(Array)
      end
    end
  end
end
