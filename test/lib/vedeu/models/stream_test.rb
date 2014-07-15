require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/models/stream'

module Vedeu
  describe Stream do
    let(:attributes) {
      {
        style:  'normal',
        colour: { foreground: '#ff0000', background: '#000000' },
        text:   'Some text'
      }
    }

    describe '#initialize' do
      def subject
        Stream.new(attributes)
      end

      it 'returns a Stream instance' do
        subject.must_be_instance_of(Stream)
      end
    end

    describe '#colour' do
      def subject
        Stream.new(attributes).colour
      end

      it 'has a colour attribute' do
        subject.must_be_instance_of(Colour)
      end
    end

    describe '#text' do
      def subject
        Stream.new(attributes).text
      end

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'has a text attribute' do
        subject.must_equal('Some text')
      end
    end

    describe '#style' do
      def subject
        Stream.new(attributes).style
      end

      it 'has a style attribute' do
        subject.must_be_instance_of(String)
      end
    end

    describe '#to_s' do
      def subject
        Stream.new(attributes).to_s
      end

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns a String' do
        subject.must_equal("\e[38;5;196m\e[48;5;16m\e[24m\e[21m\e[27mSome text")
      end
    end

    describe '#to_json' do
      def subject
        Stream.new(attributes).to_json
      end

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns a String' do
        subject.must_equal("{\"colour\":{\"foreground\":\"\\u001b[38;5;196m\",\"background\":\"\\u001b[48;5;16m\"},\"style\":\"\\u001b[24m\\u001b[21m\\u001b[27m\",\"text\":\"Some text\"}")
      end
    end
  end
end
