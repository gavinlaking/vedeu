require 'test_helper'

module Vedeu

  describe 'Bindings' do
    it { Vedeu.bound?(:_clear_).must_equal(true) }
    it { Vedeu.bound?(:_drb_retrieve_output_).must_equal(true) }
    it { Vedeu.bound?(:_drb_store_output_).must_equal(true) }
  end

  module Terminal

    describe Buffer do

      let(:described) { Vedeu::Terminal::Buffer }
      let(:height)    { 2 }
      let(:width)     { 3 }

      before do
        Vedeu.stubs(:ready?).returns(true)
        Vedeu.stubs(:height).returns(height)
        Vedeu.stubs(:width).returns(width)
        Vedeu::Terminal::Buffer.reset
      end

      describe '#buffer' do
        subject { described.buffer }

        it { subject.must_be_instance_of(Array) }

        # @todo Add more tests.
      end

      describe '#clear' do
        let(:ready) { false }

        before do
          Vedeu.stubs(:ready?).returns(ready)
          Vedeu.renderers.stubs(:clear)
        end

        subject { described.clear }

        context 'when Vedeu is ready' do
          let(:ready) { true }

          it {
            Vedeu.renderers.expects(:clear)
            subject
          }
        end

        context 'when Vedeu is not ready' do
          # @todo Add more tests.
        end
      end

      describe '#output' do
        # @todo Add more tests.
      end

      describe '#read' do
        # @todo Add more tests.
      end

      describe '#render' do
        let(:ready)  { false }

        before do
          Vedeu.stubs(:ready?).returns(ready)
          Vedeu.renderers.stubs(:render)
        end

        subject { described.render }

        context 'when Vedeu is not ready' do
          it { subject.must_equal(nil) }
        end

        context 'when Vedeu is ready' do
          let(:ready) { true }

          it {
            Vedeu.renderers.expects(:render)
            subject
          }
        end
      end

      describe '#reset' do
        subject { described.reset }

        it { subject.must_be_instance_of(Array) }
      end

      describe '#write' do
        let(:_value) {}

        subject { described.write(_value) }

        # @todo Add more tests.
      end

      describe '#update' do
        let(:_value) {}

        subject { described.update(_value) }

        # @todo Add more tests.
      end

    end # Buffer

  end # Terminal



end # Vedeu
