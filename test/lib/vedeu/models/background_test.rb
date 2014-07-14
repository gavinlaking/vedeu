require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/models/background'
require_relative '../../../../lib/vedeu/models/colour'

module Vedeu
  describe Background do
    let(:described_class)    { Background }
    let(:described_instance) { Vedeu::Colour.new(attributes) }
    let(:attributes)         {
      {
        background: '#00ff00'
      }
    }

    describe '#background' do
      let(:subject) { described_instance.background }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an escape sequence' do
        subject.must_equal("\e[48;5;46m")
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
