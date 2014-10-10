require 'test_helper'

module Vedeu
  describe Offset do
    let(:offset)     { Offset.new(attributes) }
    let(:attributes) { {} }

    before { Offsets.reset }

    describe '#initialize' do
      it 'returns a new instance of Offset' do
        offset.must_be_instance_of(Offset)
      end
    end

    describe '#name' do
      it 'has a default value of empty string' do
        offset.name.must_equal('')
      end

      context 'when a value is set' do
        let(:attributes) { { name: 'roentgenium' } }

        it 'returns that value' do
          offset.name.must_equal('roentgenium')
        end
      end
    end

    describe '#y' do
      it 'has a default value of 0' do
        offset.y.must_equal(0)
      end

      context 'when a value is set' do
        let(:attributes) { { y: 3 } }

        it 'returns that value' do
          offset.y.must_equal(3)
        end
      end
    end

    describe '#x' do
      it 'has a default value of 0' do
        offset.x.must_equal(0)
      end

      context 'when a value is set' do
        let(:attributes) { { x: 2 } }

        it 'returns that value' do
          offset.x.must_equal(2)
        end
      end
    end

  end
end
