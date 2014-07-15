require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/models/foreground'
require_relative '../../../../lib/vedeu/models/colour'

module Vedeu
  describe Foreground do
    let(:attributes) {
      {
        foreground: '#ff0000'
      }
    }

    describe '#foreground' do
      def subject
        Colour.new(attributes).foreground
      end

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an escape sequence' do
        subject.must_equal("\e[38;5;196m")
      end

      context 'when the foreground is missing' do
        let(:attributes) { {} }

        it 'returns an empty string' do
          subject.must_equal('')
        end
      end
    end
  end
end
