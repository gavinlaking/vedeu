require 'test_helper'

module Vedeu

  module Terminal

    describe Buffer do

      let(:described)    { Vedeu::Terminal::Buffer }
      let(:empty_buffer) {
        Array.new(2) do |y|
          Array.new(3) do |x|
            Vedeu::Cell.new(y: y + 1, x: x + 1)
          end
        end
      }

      before do
        Vedeu.stubs(:height).returns(2)
        Vedeu.stubs(:width).returns(3)
        Vedeu::Terminal::Buffer.reset
      end

      describe '#output' do
        subject { described.output }

        context 'when nothing has been written to the buffer' do
          it {
            described.instance_variable_get('@output').must_equal(empty_buffer)
          }
        end

        context 'when something has been written to the buffer' do
          let(:expected) {
            exp = empty_buffer
            exp[1][2] = Vedeu::Views::Char.new(value: 'a', position: [1, 2])
            exp
          }

          before do
            described.write(Vedeu::Views::Char.new(value: 'a',
                                                   position: [1, 2]), 1, 2)
          end

          it { described.instance_variable_get('@output').must_equal(expected) }
        end
      end

      describe '#render' do
        subject { described.render }

        context 'when Vedeu is not ready' do
          before do
            Vedeu.stubs(:ready?).returns(false)
          end

          it { subject.must_equal(nil) }
        end

        context 'when Vedeu is ready' do
          # it { skip }
        end
      end

      describe '#reset' do
        subject { described.reset }

        it {
          described.instance_variable_get('@output').must_equal(empty_buffer)
        }
        it { subject.must_equal(empty_buffer) }
      end

      describe '#terminal' do
        subject { described.terminal }

        it { subject.must_be_instance_of(Array) }
        it { subject.must_equal(empty_buffer) }
      end

      describe '#write' do
        let(:y)      { 0 }
        let(:x)      { 0 }
        let(:_value) {}

        subject { described.write(_value, y, x) }

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
          let(:_value) { Vedeu::Views::Char.new(y: y, x: x, value: 'a') }
          let(:expected) {
            exp = empty_buffer
            exp[y][x] = Vedeu::Views::Char.new(value: 'a', position: [y, x])
            exp
          }

          before do
            described.write(Vedeu::Views::Char.new(value: 'a',
                                                   position: [y, x]), y, x)
          end

          it { subject.must_equal(true) }
          it { described.output.must_equal(expected) }
        end
      end

    end # Buffer

  end # Terminal

end # Vedeu
