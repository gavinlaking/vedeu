require 'test_helper'

module Vedeu

  module Terminal

    describe Content do

      let(:described) { Vedeu::Terminal::Content }

      describe '.valid?' do
        let(:char) { mock }

        subject { described.valid?(char) }

        context 'when the char does not respond to :position' do
          it { subject.must_equal(false) }
        end

        context 'when the char responds to :position' do
          let(:position) { mock }

          before do
            char.stubs(:position).returns(position)
            position.stubs(:x).returns(x)
            position.stubs(:y).returns(y)
          end

          context 'but the y value is not present' do
            let(:x) { 2 }
            let(:y) {}

            it { subject.must_equal(false) }
          end

          context 'but the x value is not present' do
            let(:x) {}
            let(:y) { 5 }

            it { subject.must_equal(false) }
          end

          context 'and both y and x values are present' do
            let(:x) { 2 }
            let(:y) { 5 }

            it { subject.must_equal(true) }
          end
        end
      end

    end # Content

  end # Terminal

end # Vedeu
