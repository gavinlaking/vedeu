require 'test_helper'

module Vedeu

  module Terminal

    describe Buffer do

      let(:described) { Vedeu::Terminal::Buffer }
      let(:instance)  { described.new }

      before do
        Vedeu.stubs(:height).returns(2)
        Vedeu.stubs(:width).returns(3)
      end

      describe '#column' do
        let(:y) { 1 }
        let(:x) { 2 }

        subject { instance.column(y, x) }

        context 'when y < 1' do
          let(:y) { 0 }

          it { subject.must_equal(false) }
        end

        context 'when y > height' do
          let(:y) { 3 }

          it { subject.must_equal(false) }
        end

        context 'when x < 1' do
          let(:x) { 0 }

          it { subject.must_equal(false) }
        end

        context 'when x > width' do
          let(:x) { 4 }

          it { subject.must_equal(false) }
        end
      end

      describe '#row' do
        let(:y) {}

        subject { instance.row(y) }

        context 'when y < 1' do
          let(:y) { 0 }

          it { subject.must_equal(false) }
        end

        context 'when y > height' do
          let(:y) { 3 }

          it { subject.must_equal(false) }
        end
      end

      describe '#terminal' do
        let(:expected) {
          Array.new(2) do |y|
            Array.new(3) do |x|
              Vedeu::Cell.new(y: y + 1, x: x + 1)
            end
          end
        }

        subject { instance.terminal }

        it { subject.must_be_instance_of(Array) }
        it { subject.must_equal(expected) }
      end

      describe '#write' do
        let(:y)      { 0 }
        let(:x)      { 0 }
        let(:_value) {}

        subject { instance.write(_value, y, x) }

        context 'when the value is nil' do
          it { subject.must_equal(false) }
        end

        context 'when y < 1' do
          let(:y) { 0 }

          it { subject.must_equal(false) }
        end

        context 'when y > height' do
          let(:y) { 3 }

          it { subject.must_equal(false) }
        end

        context 'when x < 1' do
          let(:x) { 0 }

          it { subject.must_equal(false) }
        end

        context 'when x > width' do
          let(:x) { 4 }

          it { subject.must_equal(false) }
        end

        context 'when y and x are within the height and width' do
          let(:y)      { 1 }
          let(:x)      { 2 }
          let(:_value) { Vedeu::Cell.new(y: y, x: x, value: 'a') }

          it { subject.must_equal(_value) }
        end
      end

    end # Buffer

  end # Terminal

end # Vedeu
