require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/models/line'

module Vedeu
  describe Line do
    let(:attributes) {
      {
        model:  {},
        style:  'normal',
        colour: { foreground: '#ff0000', background: '#000000' },
        stream: [],
      }
    }

    describe '#style' do
      def subject
        Line.new(attributes).style
      end

      it 'has a style attribute' do
        skip
        subject.must_be_instance_of(String)
      end
    end

    describe '#colour' do
      def subject
        Line.new(attributes).colour
      end

      it 'has a colour attribute' do
        skip
        subject.must_be_instance_of(Colour)
      end
    end

    describe '#model' do
      def subject
        Line.new(attributes).model
      end

      it 'has a model attribute' do
        skip
        subject.must_be_instance_of(Hash)
      end
    end

    describe '#streams' do
      def subject
        Line.new(attributes).streams
      end

      it 'has a streams attribute' do
        subject.must_equal([])
      end
    end

    describe '#to_json' do
      def subject
        Line.new(attributes).to_json
      end

      it 'returns an String' do
        subject.must_equal("{\"colour\":{\"foreground\":\"\\u001b[38;5;196m\",\"background\":\"\\u001b[48;5;16m\"},\"style\":\"\\u001b[24m\\u001b[21m\\u001b[27m\",\"streams\":[]}")
      end
    end

    describe '#to_s' do
      def subject
        Line.new(attributes).to_s
      end

      it 'returns an String' do
        subject.must_equal("\e[38;5;196m\e[48;5;16m\e[24m\e[21m\e[27m")
      end
    end
  end
end

