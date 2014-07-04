require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/models/colour'

module Vedeu
  describe Colour do
    let(:described_class)    { Colour }
    let(:described_instance) { described_class.new(attributes) }
    let(:attributes)         {
      {
        foreground: '#ff0000',
        background: '#000000'
      }
    }

    describe '#initialize' do
      let(:subject) { described_instance }

      it 'returns a Colour instance' do
        subject.must_be_instance_of(Colour)
      end
    end

    describe '#to_s' do
      let(:subject) { described_instance.to_s }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns a String' do
        subject.must_equal("\e[38;5;196m\e[48;5;16m")
      end

      context 'when the foreground is missing' do
        let(:attributes) { { background: '#000000' } }

        it 'returns a String' do
          subject.must_equal("\e[48;5;16m")
        end
      end

      context 'when the background is missing' do
        let(:attributes) { { foreground: '#ff0000' } }

        it 'returns a String' do
          subject.must_equal("\e[38;5;196m")
        end
      end

      context 'when both are missing' do
        let(:attributes) { {} }

        it 'returns a String' do
          subject.must_equal('')
        end
      end
    end

    describe '#empty?' do
      let(:subject) { described_instance.empty? }

      context 'when both are set' do
        it 'returns a FalseClass' do
          subject.must_be_instance_of(FalseClass)
        end
      end

      context 'when the foreground is missing' do
        let(:attributes) { { background: '#000000' } }

        it 'returns a FalseClass' do
          subject.must_be_instance_of(FalseClass)
        end
      end

      context 'when the background is missing' do
        let(:attributes) { { foreground: '#ff0000' } }

        it 'returns a FalseClass' do
          subject.must_be_instance_of(FalseClass)
        end
      end

      context 'when both are missing' do
        let(:attributes) { {} }

        it 'returns a TrueClass' do
          subject.must_be_instance_of(TrueClass)
        end
      end
    end
  end
end
