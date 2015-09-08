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

      describe '#store' do
        let(:char) {}

        subject { described.store(char) }

        it { subject.must_equal(char) }
      end

      describe '#stores' do
        let(:chars) {}

        subject { described.stores(chars) }

        it { subject.must_equal([]) }
      end

      describe '#write' do
        subject { described.write }

        context 'when logging is enabled' do
          # before { Vedeu::Configuration.stubs(:log?).returns(true) }
          # before { File.stubs(:write) }

          # it {
          #   File.expects(:write)
          #   subject
          # }
        end

        context 'when logging is not enabled' do
          before { Vedeu::Configuration.stubs(:log?).returns(false) }

          it { subject.must_equal(nil) }
        end
      end

      describe '#reprocess' do
        before { Vedeu::Terminal.stubs(:clear) }

        subject { described.reprocess }

        it { subject.must_equal(['']) }
      end

      describe '#reset' do
        subject { described.reset }

        it { subject.must_be_instance_of(Hash) }

        it { subject.must_be_empty }
      end

    end # Content

  end # Terminal

end # Vedeu
