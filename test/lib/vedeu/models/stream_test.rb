require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/models/stream'

module Vedeu
  describe Stream do
    let(:described_class)    { Stream }
    let(:described_instance) { described_class.new(attributes) }
    let(:attributes)         {
      {
        style:  'normal',
        colour: { foreground: '#ff0000', background: '#000000' },
        text:   'Some text'
      }
    }

    describe '#initialize' do
      let(:subject) { described_instance }

      it 'returns a Stream instance' do
        subject.must_be_instance_of(Stream)
      end
    end

    describe '#colour' do
      let(:subject) { described_instance.colour }

      it 'has a colour attribute' do
        subject.must_be_instance_of(Colour)
      end
    end

    describe '#text' do
      let(:subject) { described_instance.text }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'has a text attribute' do
        subject.must_equal('Some text')
      end
    end

    describe '#style' do
      let(:subject) { described_instance.style }

      it 'has a style attribute' do
        subject.must_be_instance_of(String)
      end
    end

    describe '#to_s' do
      let(:subject) { described_instance.to_s }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns a String' do
        subject.must_equal("\e[38;5;196m\e[48;5;16m\e[24m\e[21m\e[27mSome text")
      end
    end

    describe '#to_json' do
      let(:subject) { described_instance.to_json }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns a String' do
        subject.must_equal("{\"colour\":{\"foreground\":\"\\u001b[38;5;196m\",\"background\":\"\\u001b[48;5;16m\"},\"style\":\"\\u001b[24m\\u001b[21m\\u001b[27m\",\"text\":\"Some text\"}")
      end
    end
  end
end
