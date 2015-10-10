require 'test_helper'

module Vedeu

  describe 'Bindings' do
    it { Vedeu.bound?(:_refresh_view_).must_equal(true) }
    it { Vedeu.bound?(:_refresh_view_content_).must_equal(true) }
  end

  module Buffers

    describe Refresh do

      let(:described) { Vedeu::Buffers::Refresh }
      let(:instance)  { described.new(_name) }
      let(:_name)     { 'Vedeu::Buffers::Refresh' }
      let(:ready)     { true }

      before do
        Vedeu.stubs(:ready?).returns(ready)
      end

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@name').must_equal(_name) }
      end

      describe '.by_name' do
        subject { described.by_name(_name) }

        context 'when Vedeu is not yet ready' do
          let(:buffer) { mock(render: '') }

          before do
            Vedeu.stubs(:trigger).with(:_clear_view_content_, _name)
            Vedeu.buffers.expects(:by_name).with(_name).returns(buffer)
            Vedeu.stubs(:trigger).with(:_refresh_border_, _name)
          end

          let(:ready) { false }

          it {
            Vedeu.expects(:trigger).with(:_clear_view_content_, _name)
            subject
          }

          it {
            Vedeu.expects(:trigger).with(:_refresh_border_, _name)
            subject
          }
        end

        context 'when Vedeu is ready' do
          # @todo Add more tests.
          # it { skip }
        end
      end

      describe '#by_name' do
        it { instance.must_respond_to(:by_name) }
      end

    end # Refresh

  end # Buffers

end # Vedeu
