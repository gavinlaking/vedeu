require 'test_helper'

module Vedeu

  describe 'Bindings' do
    it { Vedeu.bound?(:_clear_).must_equal(true) }
    it { Vedeu.bound?(:_drb_retrieve_output_).must_equal(true) }
    it { Vedeu.bound?(:_drb_store_output_).must_equal(true) }
  end

  module Buffers

    describe Terminal do

      let(:described) { Vedeu::Buffers::Terminal }
      let(:height)    { 2 }
      let(:width)     { 3 }

      before do
        Vedeu.stubs(:height).returns(height)
        Vedeu.stubs(:width).returns(width)
        Vedeu::Buffers::Terminal.reset!
      end

      describe '#clear' do
        subject { described.clear }

        it {
          Vedeu.renderers.expects(:clear)
          subject
        }
      end

      describe '#output' do
        subject { described.output }

        it {
          Vedeu::Models::Page.expects(:coerce)
          subject
        }
      end

      describe '#refresh' do
        subject { described.refresh }

        it {
          Vedeu.renderers.expects(:render)
          subject
        }
      end

      describe '#reset!' do
        subject { described.reset! }

        it { subject.must_be_instance_of(Vedeu::Buffers::View) }
      end

      describe '#update' do
        let(:_value) {}

        subject { described.update(_value) }

        # @todo Add more tests.
      end

      describe '#write' do
        let(:_value) {}

        before { Vedeu.renderers.stubs(:render) }

        subject { described.write(_value) }

        # @todo Add more tests.
      end

    end # Buffer

  end # Terminal

end # Vedeu
