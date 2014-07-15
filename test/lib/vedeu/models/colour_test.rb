require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/models/colour'

module Vedeu
  describe Colour do
    let(:attributes) {
      {
        foreground: '#ff0000',
        background: '#000000'
      }
    }

    describe '#initialize' do
      def subject
        Colour.new(attributes)
      end

      it 'returns a Colour instance' do
        subject.must_be_instance_of(Colour)
      end
    end

    describe '#to_json' do
      def subject
        Colour.new(attributes).to_json
      end

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns the model as JSON' do
        subject.must_equal("{\"foreground\":\"\\u001b[38;5;196m\",\"background\":\"\\u001b[48;5;16m\"}")
      end
    end

    describe '#to_s' do
      def subject
        Colour.new(attributes).to_s
      end

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an escape sequence' do
        subject.must_equal("\e[38;5;196m\e[48;5;16m")
      end

      context 'when the foreground is missing' do
        let(:attributes) { { background: '#000000' } }

        it 'returns an escape sequence' do
          subject.must_equal("\e[48;5;16m")
        end
      end

      context 'when the background is missing' do
        let(:attributes) { { foreground: '#ff0000' } }

        it 'returns an escape sequence' do
          subject.must_equal("\e[38;5;196m")
        end
      end

      context 'when both are missing' do
        let(:attributes) { {} }

        it 'returns an empty string' do
          subject.must_equal('')
        end
      end
    end
  end
end
