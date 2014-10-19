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

    describe '#attributes' do
      let(:attributes) { { name: 'roentgenium', y: 5, x: 12 } }

      it 'returns the attributes' do
        offset.attributes.must_equal(attributes)
      end
    end

    describe '#move' do
      let(:attributes) { { name: 'roentgenium' } }

      context 'left' do
        it 'does not move past the leftmost position' do
          offset.move(0, -1).x.must_equal(0)
        end

        context 'when it can move left' do
          let(:attributes) { { name: 'roentgenium', x: 5 } }

          it 'moves left' do
            offset.move(0, -1).x.must_equal(4)
          end
        end
      end

      context 'right' do
        it 'moves right' do
          offset.move(0, 1).x.must_equal(1)
        end
      end

      context 'up' do
        it 'does not move past the upmost position' do
          offset.move(-1, 0).y.must_equal(0)
        end

        context 'when it can move up' do
          let(:attributes) { { name: 'roentgenium', y: 5 } }

          it 'moves up' do
            offset.move(-1, 0).y.must_equal(4)
          end
        end
      end

      context 'down' do
        it 'moves down' do
          offset.move(1, 0).y.must_equal(1)
        end
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

      context 'when a value is set that is < 0' do
        let(:attributes) { { y: -2 } }

        it { offset.y.must_equal(0) }
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

      context 'when a value is set that is < 0' do
        let(:attributes) { { x: -2 } }

        it { offset.x.must_equal(0) }
      end
    end

  end # Offset

end # Vedeu
