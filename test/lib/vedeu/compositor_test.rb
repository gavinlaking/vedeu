require_relative '../../test_helper'

module Vedeu
  describe Compositor do
    let(:klass)    { Compositor }
    let(:instance) { klass.new(data, mask) }
    let(:data)     { [] }
    let(:mask)     { [] }

    it { instance.must_be_instance_of(Vedeu::Compositor) }

    describe '#compose' do
      subject { instance.compose }

      it { subject.must_be_instance_of(Array) }

      context 'when there is data and styles match' do
        context 'when we try something simple' do
          let(:data) { [['a', 'b']] }
          let(:mask) { [[[:red, :black], [:orange, :black]]] }

          it 'returns an interpolated array' do
            subject.must_equal([[["\e[31;40m", "a", "\e[0m"], ["\e[39;40m", "b", "\e[0m"]]])
          end
        end

        context 'when we try something a little more complex' do
          let(:data) { [['a', 'b', 'c'], ['d', 'e', 'f']] }
          let(:mask) { [[[:red, :green], [:orange, :black], [:green, :blue]], [[:blue, :green], [:yellow], [:magenta, :white]]] }

          it 'returns an interpolated array' do
            subject.must_equal([[["\e[31;42m", "a", "\e[0m"], ["\e[39;40m", "b", "\e[0m"], ["\e[32;44m", "c", "\e[0m"]], [["\e[34;42m", "d", "\e[0m"], ["\e[33;49m", "e", "\e[0m"], ["\e[35;47m", "f", "\e[0m"]]])
          end
        end
      end

      context 'when there is not enough data' do
        let(:data) { ['a', 'b'] }
        let(:mask) { [[:red, :white], [:orange, :black], [:green, :blue]] }

        it 'raises an exception' do
          proc { subject }.must_raise(OutOfDataError)
        end
      end

      context 'when there is not enough style' do
        let(:data) { ['a', 'b', 'c'] }
        let(:mask) { [[:red, :white], [:orange, :black]] }

        it 'raises an exception' do
          proc { subject }.must_raise(OutOfStyleError)
        end
      end

      context 'when the data and styles are empty' do
        it 'returns an empty collection' do
          subject.must_equal([])
        end
      end
    end
  end
end
