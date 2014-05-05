require_relative '../../test_helper'

module Vedeu
  describe Grid do
    let(:klass)    { Grid }
    let(:instance) { klass.new(data, mask) }
    let(:data)     { [] }
    let(:mask)     { [] }

    it { instance.must_be_instance_of(Grid) }

    describe '#compose' do
      subject { instance.compose }

      it { subject.must_be_instance_of(Array) }

      context 'when there is data and styles match' do
        context 'when we try something simple' do
          let(:data) {
            [
              ['a', 'b']
            ]
          }
          let(:mask) {
            [
              [[:red, :black], [:orange, :black]]
            ]
          }

          it 'returns an interpolated array' do
            subject.must_equal(
              [
                [["\e[38;5;31m\e[48;5;40m", "a", "\e[38;5;39m\e[48;5;49m"], ["\e[38;5;39m\e[48;5;40m", "b", "\e[38;5;39m\e[48;5;49m"]]
              ]
            )
          end
        end

        context 'when we try something a little more complex' do
          let(:data) {
            [
              ['a', 'b', 'c'],
              ['d', 'e', 'f']
            ]
          }
          let(:mask) {
            [
              [[:red, :green],  [:orange, :black], [:green, :blue]],
              [[:blue, :green], [:yellow],         [:magenta, :white]]
            ]
          }

          it 'returns an interpolated array' do
            subject.must_equal(
              [
                [["\e[38;5;31m\e[48;5;42m", "a", "\e[38;5;39m\e[48;5;49m"], ["\e[38;5;39m\e[48;5;40m", "b", "\e[38;5;39m\e[48;5;49m"], ["\e[38;5;32m\e[48;5;44m", "c", "\e[38;5;39m\e[48;5;49m"]],
                [["\e[38;5;34m\e[48;5;42m", "d", "\e[38;5;39m\e[48;5;49m"], ["\e[38;5;33m\e[48;5;49m", "e", "\e[38;5;39m\e[48;5;49m"], ["\e[38;5;35m\e[48;5;47m", "f", "\e[38;5;39m\e[48;5;49m"]]
              ]
            )
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
