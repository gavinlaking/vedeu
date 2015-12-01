require 'test_helper'

module Vedeu

  describe 'Bindings' do
    it { Vedeu.bound?(:_initialize_).must_equal(true) }
  end

  module Runtime

    describe Flags do

      let(:described) { Vedeu::Runtime::Flags }

      describe '.ready!' do
        it { described.ready!.must_equal(true) }
      end

      describe '.ready?' do
        context 'when Vedeu has triggered the :_initialize_ event' do
          before do
            described.reset!
            described.ready!
          end

          it { described.ready?.must_equal(true) }
        end

        context 'when Vedeu has not triggered the :_initialize_ event' do
          before do
            described.reset!
          end

          it { described.ready?.must_equal(false) }
        end
      end

      describe '.reset!' do
        subject { described.reset! }

        it do
          subject
          described.ready?.must_equal(false)
        end
        it { described.instance.must_respond_to(:reset) }
      end

      describe '#reset!' do
        it { described.instance.must_respond_to(:reset!) }
        it { described.instance.must_respond_to(:reset) }
      end

    end # Flags

  end # Runtime

end # Vedeu
