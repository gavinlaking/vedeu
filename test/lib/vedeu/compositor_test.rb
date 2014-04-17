require_relative '../../test_helper'

module Vedeu
  describe Compositor do
    let(:klass)    { Compositor }
    let(:instance) { klass.new(data, mask) }
    let(:data)     { [] }
    let(:mask)     { [] }

    it 'returns an instance of self' do
      instance.must_be_instance_of(Vedeu::Compositor)
    end

    describe '#interpolate' do
      subject { instance.interpolate }

      context 'when there is data and styles match' do
        let(:data) { ['a', 'b', 'c'] }
        let(:mask) { [[:red], [:orange], [:green]] }

        it 'returns an interpolated array' do
          subject.must_equal([
            "\e[31;49ma\e[0m", "\e[39;49mb\e[0m", "\e[32;49mc\e[0m"
          ])
        end
      end

      context 'when there is not enough data' do
        let(:data) { ['a', 'b'] }
        let(:mask) { [:red, :orange, :green] }

        it 'raises an exception' do
          proc { subject }.must_raise(OutOfDataError)
        end
      end

      context 'when there is not enough style' do
        let(:data) { ['a', 'b', 'c'] }
        let(:mask) { [:red, :orange] }

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
